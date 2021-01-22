//
//  NRL_Protocols.swift
//  BlackPanther
//
//  Created by James Furlong on 21/1/21.
//

import Foundation

class Fixture: Codable {
    let sport: Sport
    let rounds: [Round]
    
    init(sport: Sport, rounds: [Round]) {
        self.sport = sport
        self.rounds = rounds
    }
}

struct Match: Codable {
    let name: String
    let location: String
    let startDateTime: Date
    let homeTeamId: Int?
    let homeTeamName: String?
    let awayTeamId: Int?
    let awayTeamName: String?
    let homeTeamScore: Int?
    let awayTeamScore: Int?
    let matchEvents: [Event]
}

struct Round: Codable {
    let roundTitle: String
    let round: Int
    let matches: [Match]
}

struct Event: Codable { }
