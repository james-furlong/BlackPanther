//
//  BigBashResult.swift
//  BlackPanther
//
//  Created by James Furlong on 13/1/21.
//

import Foundation

struct BigBashResult: Decodable, RoundResult {
    let timestamp: String
    let matchDetail: BigBashMatchDetail?
    let nuggets: [BigBashNugget]
    let innings: [BigBashInnings]
    let teams: BigBashTeamResponse
    let notes: BigBashNotes
    let substitutes: [BigBashSubstitute]
    let result: String?
    
    enum CodingKeys: String, CodingKey {
        case timestamp = "Timestamp"
        case matchDetail = "Matchdetail"
        case nuggets = "Nuggets"
        case innings = "Innings"
        case teams = "Teams"
        case notes = "Notes"
        case substitutes = "Substitutes"
        case result = "Result"
    }
}

