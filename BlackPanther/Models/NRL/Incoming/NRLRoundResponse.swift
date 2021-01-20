//
//  NRLRound.swift
//  BlackPanther
//
//  Created by James Furlong on 11/1/21.
//

import Foundation

protocol RoundResult { }

struct NRLRoundResponse: Decodable, RoundResult {
    let roundTitle: String
    let type: String
    let matchMode: String
    let matchState: String
    let venue: String
    let venueCity: String
    let matchCentreUrl: String
    let homeTeam: NRLMatchTeamResponse
    let awayTeam: NRLMatchTeamResponse
    let clock: NRLMatchClockResponse
    
    
    var startDateTime: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd 'T' HH:mm:ss"
        return formatter.date(from: self.clock.kickOffTimeLong) ?? nil
    }
}

struct NRLMatchClockResponse: Decodable {
    let kickOffTimeLong: String
    let gameTime: String
}

