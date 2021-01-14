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
    let venueName: String
    let awayTeamId: String
    let homeTeamId: String
    let roundNumber: String
    let awayTeamName: String?
    let homeTeamName: String?
    let latestOptaId: String?
    let competitionName: String
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
//    id: "018048f9-5a8a-4749-867d-1ba51d2c53ff",
//    gameId: "321011",
//    latestScoreId: "1b28a8b3-f2ab-4ab3-b03f-09a876c693da",
//    competitionId: "3",
//    optaSeasonId: "2021",
//    gameDateTime: "2021-03-11T09:05:00.000Z",
//    status: "Scheduled",
//    result: null,
//    summary: {
//    venueId: "112",
//    venueName: "AAMI Park",
//    awayTeamId: "3700",
//    homeTeamId: "1400",
//    roundNumber: "1",
//    awayTeamName: "Rabbitohs",
//    homeTeamName: "Storm",
//    latestOptaId: "2551405889",
//    competitionName: "NRL"
//    },
//    createdAt: "2020-11-26T12:26:20.838Z",
//    updatedAt: "2021-01-14T07:00:18.828Z",
//    sportId: 5
    
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
