//
//  BigBashTeam.swift
//  BlackPanther
//
//  Created by James Furlong on 12/1/21.
//

import Foundation

struct BigBashTeamResponse: Decodable {
    var array: [BigBashTeam]
    
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
        var tempArray = [BigBashTeam]()
        for key in container.allKeys {
            let decodedObject = try container.decode(BigBashTeam.self, forKey: DynamicDecodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }
        
        array = tempArray
    }
    
}

struct BigBashTeam: Decodable {
    let name: String
    let nameShort: String
    let players: BigBashPlayerResponse
    
    let teamId: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name_Full"
        case nameShort = "Name_Short"
        case players = "Players"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: CodingKeys.name)
        nameShort = try container.decode(String.self, forKey: CodingKeys.nameShort)
        players = try container.decode(BigBashPlayerResponse.self, forKey: .players)
        
        teamId = container.codingPath.first!.stringValue
    }
}
