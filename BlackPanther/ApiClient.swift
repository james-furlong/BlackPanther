//
//  ApiClient.swift
//  BlackPanther
//
//  Created by James Furlong on 12/1/21.
//

import Foundation
import WebKit

protocol ApiClientProtocols {
    
    // NRL
    func getNrlFixture(leagueId: String, year: String, completion: @escaping (NRLFixtureResponse?) -> ())
    func getNrlPlayers(completion: @escaping ([NRLPlayer]) -> ())
    
    // BigBash
    func getBigBashFixture(year: String, completion: @escaping (BigBashFixture?) -> ())
    func getBigBashResults(fixture: BigBashFixture, completion: @escaping ([BigBashResult]?) -> ())
}

extension Result where Success == Data {
    func decoded<T: Decodable>(
        using decoder: JSONDecoder = .init()
    ) throws -> T {
        let data = try get()
        return try decoder.decode(T.self, from: data)
    }
}

class ApiClient: ApiClientProtocols {
    
    // MARK: - NRL
    
    func getNrlFixture(leagueId: String, year: String, completion: @escaping (NRLFixtureResponse?) -> ()) {
        let url = String(format: "https://www.thesportsdb.com/api/v1/json/1/eventsseason.php?id=\(leagueId)&s=\(year)")
        get(from: url) { result in
            do {
                let fixture = try result.decoded() as NRLFixtureResponse
                completion(fixture)
            } catch {
                completion(nil)
            }
        }
    }
    
    func getNrlPlayers(completion: @escaping ([NRLPlayer]) -> ()) {
        var teamArray: [NRLTeam] = []
        var playerArray: [NRLPlayer] = []
        for team in NRLTeam.allCases {
            var jsonText: String?
            self.scrapeWebsite(url: team.url) { rawData in
                if let startRange = rawData.range(of: "profileGroups") {
                    let startText = rawData.substring(from: startRange.lowerBound)
                    let rangeText = """
                    \"\r\n
                    """
                    if let endRange = startText.range(of:rangeText) {
                        jsonText = startText.substring(to: endRange.lowerBound)
                        let json1 = jsonText?.replacingOccurrences(
                            of: "&quot;",
                            with: "\""
                        )
                        let json3 = "{\(json1!)"
                        let json5 = json3.replacingOccurrences(of: "\\", with: "")
                        var json4 = json5.replacingOccurrences(of: "Optional(", with: "")
                        json4.append("}")
                        if json4[1] != "\"" {
                            json4.insert("\"", at: json4.index(after: json4.startIndex))
                        }
                        if json4[json4.count - 1] == "}" && json4[json4.count - 2] == "}" {
                            json4.removeLast()
                        }
                        print(json4.description)

                        let jsonData = json4.data(using: .utf8)
                        do {
                            let decoded = try JSONDecoder().decode(NRLPlayersResponse.self, from: jsonData!)
                            for group in decoded.profileGroups {
                                for player in group.profiles {
                                    playerArray.append(player)
                                }
                            }
                        } catch {
                            // TODO: Log error
                        }
                    }
                }
                teamArray.append(team)
                var containsAllTeams: Bool = true
                for t in NRLTeam.allCases {
                    if !teamArray.contains(t) { containsAllTeams = false }
                }

                if containsAllTeams {
                    completion(playerArray)
                }
            }
        }
    }
    
    // MARK: - Big Bash League
    
    func getBigBashFixture(year: String, completion: @escaping (BigBashFixture?) -> ()) {
        let url = String(format: "https://cricket.yahoo.net/sifeeds/multisport/?methodtype=3&client=24&sport=1&league=0&timezone=0530&language=en&tournament=1638")
        get(from: url) { result in
            do {
                let fixture = try result.decoded() as BigBashFixture
                completion(fixture)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
    
    func getBigBashResults(fixture: BigBashFixture, completion: @escaping ([BigBashResult]?) -> ()) {
        var results: [BigBashResult] = []
        var resultCount: Int = 0
        var rounds = fixture.matches
        rounds.sort { (one, two) in
            guard let oneStart = one.startDateTime else { return false }
            guard let twoStart = two.startDateTime else { return false }
            
            return oneStart < twoStart
        }
        let completedRounds = rounds.filter { $0.matchStatus == .Completed }
        for round in completedRounds {
            let url: String = "https://cricket.yahoo.net/sifeeds/cricket/live/json/\(round.game_id).json"
            get(from: url) { result in
                resultCount += 1
                do {
                    print(result)
                    let result = try result.decoded() as BigBashResult
                    results.append(result)
                } catch {
                    print(error)
                    completion(nil)
                }
                
                if resultCount == completedRounds.count {
                    completion(results)
                }
            }
        }
    }
    
    // MARK: - Internal functions
    
    private func scrapeWebsite(url: String, completion: @escaping (String) -> ()) {
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            let rawData = String(data: data!, encoding: String.Encoding.utf8) ?? ""
            completion(rawData)
        }.resume()
    }
    
    private func get(from url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let serviceUrl = URL(string: url) else { return completion(.failure(NetworkError.badUrl)) }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else { return completion(.failure(NetworkError.invalidData)) }
            
            completion(.success(data))
        }.resume()
    }
}
