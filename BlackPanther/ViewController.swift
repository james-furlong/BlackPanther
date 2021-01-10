//
//  ViewController.swift
//  BlackPanther
//
//  Created by James Furlong on 10/1/21.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
    var playerArray: [NRLPlayer] = []
    var teamArray: [NRLTeam] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
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
    
    private func pushUpPlayerInfo() {
        // TODO: Complete this
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
