//
//  ViewController.swift
//  BlackPanther
//
//  Created by James Furlong on 10/1/21.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
    @IBOutlet weak var playerIndicatorBar: NSProgressIndicator!
    @IBOutlet weak var fixtureIndicatorBar: NSProgressIndicator!
    @IBOutlet weak var fixtureYearTextField: NSTextField?
    
    private let leagueId: String = "4416"
    
    var playerArray: [NRLPlayer] = []
    var teamArray: [NRLTeam] = []
    var roundResultArray: [RoundResultResponse] = []
    var fixtureYear: String = ""
    
    // MARK: - Actions
    
    @IBAction func fixtureButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.fixtureIndicatorBar.doubleValue = 0.0
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year: String = (fixtureYearTextField?.objectValue ?? formatter.string(from: Date())) as! String
        let Url = String(format: "https://www.thesportsdb.com/api/v1/json/1/eventsseason.php?id=\(leagueId)&s=\(year)")
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let fixture = try JSONDecoder().decode(FixtureResponse.self, from: data)
                    self.pushUpFixtureInformation(fixture)
                    // Fixture is old so get the results
                    if year != formatter.string(from: Date()) {
                        for round in fixture.events {
                            DispatchQueue.main.async {
                                self.fixtureIndicatorBar.increment(by: 100.0 / Double(fixture.events.count))
                            }
                            guard let id = round.idEvent else { continue }
                            self.getCompletedRound(id) { result in
                                self.roundResultArray.append(result)
                                if self.roundResultArray.count == fixture.events.count {
                                    self.pushUpRoundResults()
                                }
                            }
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            self.fixtureIndicatorBar.doubleValue = 100.0
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        for team in NRLTeam.allCases {
            var jsonText: String?
            let url = URL(string: team.url)
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                let rawData = String(data: data!, encoding: String.Encoding.utf8)
                if let startRange = rawData?.range(of: "profileGroups") {
                    let startText = rawData?.substring(from: startRange.lowerBound)
                    let rangeText = """
                    \"\r\n
                    """
                    if let endRange = startText?.range(of:rangeText) {
                        jsonText = startText?.substring(to: endRange.lowerBound)
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
                            let decoded = try JSONDecoder().decode(PlayersResponse.self, from: jsonData!)
                            for group in decoded.profileGroups {
                                for player in group.profiles {
                                    self.playerArray.append(player)
                                }
                            }
                            DispatchQueue.main.async {
                                self.playerIndicatorBar.increment(by: 100 / 16)
                            }
                        } catch {
                            // TODO: Log error
                        }
                    }
                }
                self.teamArray.append(team)
                var containsAllTeams: Bool = true
                for t in NRLTeam.allCases {
                    if !self.teamArray.contains(t) { containsAllTeams = false }
                }
                
                if containsAllTeams {
                    self.pushUpPlayerInfo()
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Internal functions
    
    private func getCompletedRound(_ eventId: String, completion: @escaping (RoundResultResponse) -> (Void)) {
        let url = URL(string: "https://www.thesportsdb.com/api/v1/json/1/eventresults.php?id=\(eventId)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(RoundResultResponse.self, from: data)
                    completion(result)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    private func pushUpPlayerInfo() {
        // TODO: Complete this
    }
    
    private func pushUpFixtureInformation(_ fixture: FixtureResponse) {
        // TODO: Complete this
    }
    
    private func pushUpRoundResults() {
        // TODO: complete this
        self.roundResultArray = []
    }
}

enum NRLTeam: CaseIterable {
    case BrisbaneBroncos
    case CanberraRaiders
    case CanterburyBulldogs
    case CronullaSharks
    case GoldCoastTitans
    case ManlySeaEagles
    case MelbourneStorm
    case NewcastleKnights
    case NewZealandWarriors
    case NorthQueenslandCowboys
    case ParramattaEels
    case PenrithPanthers
    case SouthSydneyRabbitohs
    case StGeorgeDragons
    case SydneyRoosters
    case WestTigers
    
    var url: String {
        switch self {
            case .BrisbaneBroncos: return "https://www.broncos.com.au/teams/"
            case .CanberraRaiders: return "https://www.raiders.com.au/teams/"
            case .CanterburyBulldogs: return "https://www.bulldogs.com.au/teams/"
            case .CronullaSharks: return "https://www.sharks.com.au/teams/"
            case .GoldCoastTitans: return "https://www.titans.com.au/teams/"
            case .ManlySeaEagles: return "https://www.seaeagles.com.au/teams/"
            case .MelbourneStorm: return "https://www.melbournestorm.com.au/teams/"
            case .NewcastleKnights: return "https://www.newcastleknights.com.au/teams/"
            case .NewZealandWarriors: return "https://www.warriors.kiwi/teams/"
            case .NorthQueenslandCowboys: return "https://www.cowboys.com.au/teams/"
            case .ParramattaEels: return "https://www.parraeels.com.au/teams/"
            case .PenrithPanthers: return "https://www.penrithpanthers.com.au/teams/"
            case .SouthSydneyRabbitohs: return "https://www.rabbitohs.com.au/teams/"
            case .StGeorgeDragons: return "https://www.dragons.com.au/teams/"
            case .SydneyRoosters: return "https://www.roosters.com.au/teams/"
            case .WestTigers: return "https://www.weststigers.com.au/teams/"
        }
    }
}
