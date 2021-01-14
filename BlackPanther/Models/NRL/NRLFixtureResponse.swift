//
//  NRLFixtureResponse.swift
//  BlackPanther
//
//  Created by James Furlong on 11/1/21.
//

import Foundation

protocol Fixture { }

struct NRLFixtureResponse: Decodable, Fixture {
    let rounds: [NRLRound]
    
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
        var tempArray = [NRLRound]()
        for key in container.allKeys {
            let decodedObject = try container.decode(NRLRound.self, forKey: DynamicDecodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }
        rounds = tempArray
    }
}
