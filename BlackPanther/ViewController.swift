//
//  ViewController.swift
//  BlackPanther
//
//  Created by James Furlong on 10/1/21.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
    private let leagueId: String = "4416"
    
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
    
    
    @IBAction func fixtureButtonTapped(_ sender: Any) {
        let Url = String(format: "https://www.thesportsdb.com/api/v1/json/1/eventsseason.php?id=\(leagueId)&s=2021")
            guard let serviceUrl = URL(string: Url) else { return }
//            let parameters: [String: Any] = [
//                "request": [
//                        "xusercode" : "YOUR USERCODE HERE",
//                        "xpassword": "YOUR PASSWORD HERE"
//                ]
//            ]
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "GET"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
//            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
//                return
//            }
//            request.httpBody = httpBody
            request.timeoutInterval = 20
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        let fixture = try JSONDecoder().decode(FixtureResponse.self, from: data)
                        print(fixture)
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        
//        if let baseGETURL = URL(string: "https://www.thesportsdb.com/api/v1/json/1/eventsseason.php?id=\(leagueId)&s=2021") {
//            self.fetch(requestURL: baseGETURL, requestType: "GET", parameter: nil) { result in
//                switch result {
//                    case .success(_):
//                        print(response)
//                        do {
//                            let decoder = JSONDecoder()
//                            if let jsonData = result.data {
//
//                            }
//                        } catch {
//                            // TODO: Log error
//                        }
//                    case .failure(let error):
//                        print("ERROR: \(error)")
//                }
//            }
//        }
        
        
//        if let baseGETURL = URL(string:"https://postman-echo.com/get?foo1=bar1&foo2=bar2"){
//                    self.fetch(requestURL: baseGETURL, requestType: "GET", parameter: nil) { (result) in
//                              switch result{
//                              case .success(let response) :
//                                print("Hello World \(response)")
//                              case .failure(let error) :
//                                print("Hello World \(error)")
//
//                              }
//                          }
//                }
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
    
//    func call<T>(type: EndPointType, params: Parameters? = nil, handler: @escaping (Swift.Result<T, Error>) -> Void) where T: Codable {
//        self.sessionManager.request(type.url,
//            method: type.httpMethod,
//            parameters: params,
//            encoding: type.encoding,
//            headers: type.headers).validate().responseJSON { (data) in
//                do {
//                    guard let jsonData = data.data else {
//                        throw AlertMessage(title: "Error", body: "No data")
//                    }
//                    let result = try JSONDecoder().decode(T.self, from: jsonData)
//                    handler(.success(result))
//                    self.resetNumberOfRetries()
//                } catch {
//                    return handler(.failure(error))
//                }
//            }
//    }
    
    func fetch(requestURL:URL,requestType:String,parameter:[String:AnyObject]?,completion:@escaping (Result<Any, Error>) -> () ){
            //Check internet connection as per your convenience
            //Check URL whitespace validation as per your convenience
            //Show Hud
            var urlRequest = URLRequest.init(url: requestURL)
            urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
            urlRequest.timeoutInterval = 60
            urlRequest.httpMethod = String(describing: requestType)
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            
            //Post URL parameters set as URL body
            if let params = parameter{
                do {
                    let parameterData = try JSONSerialization.data(withJSONObject:params, options:.prettyPrinted)
                    urlRequest.httpBody = parameterData
                } catch {
                   //Hide hude and return error
                    completion(.failure(error))
                }
            }
            //URL Task to get data
            URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
                //Hide Hud
                //fail completion for Error
                if let objError = error{
                    completion(.failure(objError))
                }
                //Validate for blank data and URL response status code
                if let objData = data,let objURLResponse = response as? HTTPURLResponse{
                    //We have data validate for JSON and convert in JSON
                    do {
                        let objResposeJSON = try JSONSerialization.jsonObject(with: objData, options: .mutableContainers)
                        //Check for valid status code 200 else fail with error
                        if objURLResponse.statusCode == 200{
                            completion(.success(objResposeJSON))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                }
            }.resume()
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
