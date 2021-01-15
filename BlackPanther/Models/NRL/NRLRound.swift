//
//  NRLRound.swift
//  BlackPanther
//
//  Created by James Furlong on 11/1/21.
//

import Foundation

protocol RoundResult { }

struct NRLRoundSummary: Codable {
    let venueId: String
    let subStatus: String
    let venueName: String
    let awayTeamId: String
    let homeTeamId: String
    let roundNumber: String
    let awayTeamName: String?
    let homeTeamName: String?
    let latestOptaId: String?
    let competitionName: String
    let awayTeamScore: String?
    let homeTeamScore: String?
}

struct NRLRound: Codable, RoundResult {
    let id: String
    let gameId: String
    let latestScoreId: String
    let competitionId: String
    let optaSeasonId: String
    let gameDateTime: String
    let status: String
    let result: String?
    let summary: NRLRoundSummary
    let createdAt: String
    let updatedAt: String
    let sportId: Int
    
    var startDateTime: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd 'T' HH:mm:ss"
        return formatter.date(from: self.gameDateTime) ?? nil
    }
    
    var createdDateTime: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd 'T' HH:mm:ss"
        return formatter.date(from: self.createdAt) ?? nil
    }
    
    var updatedDateTime: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd 'T' HH:mm:ss"
        return formatter.date(from: self.updatedAt) ?? nil
    }
}
