//
//  BigBashPlayer.swift
//  BlackPanther
//
//  Created by James Furlong on 12/1/21.
//

import Foundation

struct BigBashPlayerResponse: Decodable {
    var array: [BigBashPlayer]
    
    private struct DynamicDecodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicDecodingKeys.self)
        var tempArray = [BigBashPlayer]()
        for key in container.allKeys {
            let decodedObject = try container.decode(BigBashPlayer.self, forKey: DynamicDecodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }
        
        array = tempArray
    }
}

struct BigBashPlayer: Decodable {
    let position: String
    let nameFull: String
    let skill: String
    let confirmXI: Bool?
    let matches: String
    let batting: BigBashBatting
    let bowling: BigBashBowling
    
    let playerId: String
    
    enum CodingKeys: String, CodingKey {
        case position = "Position"
        case nameFull = "Name_Full"
        case skill = "Skill"
        case confirmXI = "Confirm_XI"
        case matches = "Matches"
        case batting = "Batting"
        case bowling = "Bowling"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        position = try container.decode(String.self, forKey: .position)
        nameFull = try container.decode(String.self, forKey: .nameFull)
        skill = try container.decode(String.self, forKey: .skill)
        confirmXI = try container.decodeIfPresent(Bool.self, forKey: .confirmXI)
        matches = try container.decode(String.self, forKey: .matches)
        batting = try container.decode(BigBashBatting.self, forKey: .batting)
        bowling = try container.decode(BigBashBowling.self, forKey: .bowling)
        
        playerId = container.codingPath.last!.stringValue
    }
}

struct BigBashBatsman: Codable {
    let batsman: String
    let runs: String
    let balls: String
    let fours: String?
    let sixes: String?
    let dots: String?
    let strikeRate: String?
    let dismissal: String?
    let howOut: String?
    let bowler: String?
    let fielder: String?
    let runScoredInLastBalls: BigBashRunScoredBalls?
    let number: Int?
    let dismissalType: String?
    let dismissalId: String?
    
    enum CodingKeys: String, CodingKey {
        case batsman = "Batsman"
        case runs = "Runs"
        case balls = "Balls"
        case fours = "Fours"
        case sixes = "Sixes"
        case dots = "Dots"
        case strikeRate = "Strikerate"
        case dismissal = "Dismissal"
        case howOut = "Howout"
        case bowler = "Bowler"
        case fielder = "Fielder"
        case runScoredInLastBalls = "RunScoredInLastBalls"
        case number = "Number"
        case dismissalType = "DismissalType"
        case dismissalId = "DismissalId"
    }
}

struct BigBashBowler: Codable {
    let bowler: String
    let overs: String
    let maidens: String
    let runs: String
    let wickets: String
    let economyRate: String
    let noBalls: String
    let wides: String
    let dots: String
    let runGivenInLastBalls: BigBashRunScoredBalls
    let number: Int
    
    enum CodingKeys: String, CodingKey {
        case bowler = "Bowler"
        case overs = "Overs"
        case maidens = "Maidens"
        case runs = "Runs"
        case wickets = "Wickets"
        case economyRate = "Economyrate"
        case noBalls = "Noballs"
        case wides = "Wides"
        case dots = "Dots"
        case runGivenInLastBalls = "RungivenInLastBalls"
        case number = "Number"
    }
}
