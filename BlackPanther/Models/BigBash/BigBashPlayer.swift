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
        
        playerId = container.codingPath.first!.stringValue
    }
}

struct BigBashBatting: Codable {
    let style: String
    let average: String
    let strikeRate: String
    let runs: String
    
    enum CodingKeys: String, CodingKey {
        case style = "Style"
        case average = "Average"
        case strikeRate = "Strikerate"
        case runs = "Runs"
    }
}

struct BigBashBowling: Codable {
    let style: String
    let average: String
    let economyRate: String
    let runs: String?
    
    enum CodingKeys: String, CodingKey {
        case style = "Style"
        case average = "Average"
        case economyRate = "Economyrate"
        case runs = "Runs"
    }
}
