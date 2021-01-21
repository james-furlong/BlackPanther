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
    func getNrlFixture(year: String, comp: NRLComp, completion: @escaping (NRLFixture?) -> ())
    func getNrlResults(fixture: NRLFixture, completion: @escaping ([NRLRound]?) -> ())
    func getNrlPlayers(completion: @escaping ([NRLPlayerResponse]) -> ())
    
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
    
    func getNrlFixture(year: String, comp: NRLComp, completion: @escaping (NRLFixture?) -> ()) {
        let url = String(format: "https://www.nrl.com/draw/data?competition=\(comp.rawValue)")
        get(from: url) { [weak self] result in
            do {
                var roundArray = [NRLRound]()
                let initialData = try result.decoded() as NRLFixtureResponse
                let rounds: [Int] = initialData.filterRounds.map { $0.value }
                for round in rounds {
                    let roundUrl = "https://www.nrl.com/draw/data?competition=\(comp.rawValue)&season=\(year)&round=\(round)"
                    self?.get(from: roundUrl) { result in
                        do {
                            let roundResponse = try result.decoded() as NRLFixtureResponse
                            roundArray.append(NRLRound(from: roundResponse))
                        } catch {
                            print(error)
                        }
                        if roundArray.count == rounds.count {
                            completion(NRLFixture(year: year, rounds: roundArray))
                        }
                    }
                }
                
            } catch {
                completion(nil)
            }
        }
        
        completion(nil)
    }
    
    func getNrlResults(fixture: NRLFixture, completion: @escaping ([NRLRound]?) -> ()) {
        var roundArray: [NRLRound] = []
        fixture.rounds.forEach { round in
            var matchResults = NRLRound(
                round: round.round,
                roundTitle: round.roundTitle,
                roundStartDateTime: round.roundStartDateTime,
                roundEndDateTime: round.roundEndDateTime
            )
            round.matches.forEach { match in
                let url = "https://www.nrl.com\(match.matchUrl)data?"
                get(from: url) { result in
                    do {
                        let roundResult = try result.decoded() as NRLMatchResponse
                        matchResults.matches.append(NRLMatch(from: roundResult, with: match))
                    } catch {
                        print(error)
                        completion(nil)
                    }
                    if matchResults.matches.count == round.matches.count {
                        roundArray.append(matchResults)
                    }
                    if roundArray.count == fixture.rounds.count {
                        completion(roundArray)
                    }
                }
            }
        }
    }
    
    func getNrlPlayers(completion: @escaping ([NRLPlayerResponse]) -> ()) {
        
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
