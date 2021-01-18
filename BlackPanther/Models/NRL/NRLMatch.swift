//
//  NRLMatch.swift
//  BlackPanther
//
//  Created by James Furlong on 18/1/21.
//

import Foundation

struct NRLMatch: Decodable {
    let matchId: String
    let updated: String
    let gameSeconds: Int
    let roundNumber: Int
    let startTime: String
    let matchMode: String
    let matchState: String
    let homeTeam: NRLMatchTeam
    let awayTeam: NRLMatchTeam
    let venue: String
    let venueCity: String
    let url: String
    let attendance: Int
    let competition: NRLCompetition
    let groundConditions: String
    let hasExtraTime: Bool
    let hasOnFieldTracking: Bool
    let officials: [NRLSupportPerson]
    let positionGroups: [NRLPositionGroup]
    let roundTitle: String
    let segmentCount: Int
    let segmentDuration: String
    let showTeamPosition: Bool
    let showPlayerPositions: Bool
    let stats: NRLMatchStats
    let timeline: [NRLEvent]
}

struct NRLMatchTeam: Decodable {
    let teamId: Int
    let nickeName: String
    let name: String
    let score: Int
    let captainPlayerId: Int
    let players: [NRLPlayer]
    let coaches: [NRLSupportPerson]
    let scoring: NRLScore
}

struct NRLSupportPerson: Decodable {
    let firstName: String
    let lastName: String
    let profileId: Int
    let position: String
    let url: String
}

struct NRLScore: Decodable {
    let tries: NRLScoreSummary?
    let conversions: NRLScoreSummary?
    let penaltyGoals: NRLScoreSummary?
    let fieldGoals: NRLScoreSummary?
    let halfTimeScore: Int
}

struct NRLScoreSummary: Decodable {
    let summaries: [String]?
    let attempts: Int?
    let made: Int?
}

struct NRLCompetition: Decodable {
    let competitionId: Int
    let name: String
}

struct NRLPositionGroup: Decodable {
    let title: String
    let positions: NRLPosition
}

struct NRLPosition: Decodable {
    let nameString: String
    let homeProfileId: Int
    let awayProfileId: Int
    
    enum CodingKeys: String, CodingKey {
        case nameString = "name"
        case homeProfileId = "homeProfileId"
        case awayProfileId = "awayProfileId"
    }
    
    var position: Position? {
        Position(rawValue: nameString)
    }
    
    enum Position: String {
        case Fullback = "Fullback"
        case Winger = "Winger"
        case Centre = "Centre"
        case FiveEighth = "Five-Eighth"
        case Halfback = "Halfback"
        case Prop = "Prop"
        case Hooker = "Hooker"
        case SecondRow = "2nd Row"
        case Lock = "Lock"
        case Interchange = "Interchange"
        case Coach = "Coach"
        case Referee = "Referee"
        case TouchJudge = "Touch Judge"
        case VideoReferee = "Video Referee"
        case SeniorReviewOfficial = "Senior Review Official"
    }
}

struct NRLMatchStats: Decodable {
    let players: NRLGroupedStats
}

struct NRLGroupedStats: Decodable {
    let homeTeam: [NRLPlayerStats]
    let awayTeam: [NRLPlayerStats]
}

struct NRLPlayerStats: Decodable {
    let playerId: Int
    let allRunMetres: Int
    let allRuns: Int
    let bombKicks: Int
    let crossFieldKicks: Int
    let conversions: Int
    let conversionAttempts: Int
    let dummyHalfRuns: Int
    let dummyHalfRunMetres: Int
    let dummyPasses: Int
    let errors: Int
    let fantasyPointsTotal: Int
    let fieldGoals: Int
    let forcedDropOutKicks: Int
    let fortyTwentyKicks: Int
    let goals: Int
    let goalConversionRate: Int
    let grubberKicks: Int
    let handlingErrors: Int
    let hitUps: Int
    let hitUpRunMetres: Int
    let ineffectiveTackles: Int
    let intercepts: Int
    let kicks: Int
    let kicksDead: Int
    let kicksDefused: Int
    let kickMetres: Int
    let kickReturnMetres: Int
    let lineBreakAssists: Int
    let lineBreaks: Int
    let lineEngagedRuns: Int
    let minutesPlayed: Int
    let missedTackles: Int
    let offloads: Int
    let oneOnOneLost: Int
    let oneOnOneSteal: Int
    let onReport: Int
    let passesToRunRatio: Double
    let passes:  Int
    let playTheBallTotal: Int
    let playTheBallAverageSpeed: Double
    let penalties: Int
    let points: Int
    let penaltyGoals: Int
    let postContactMetres: Int
    let receipts: Int
    let ruckInfringements: Int
    let sendOffs: Int
    let sinBins: Int
    let stintOne: Int
    let tackleBreaks: Int
    let tackleEfficiency: Double
    let tacklesMade: Int
    let tries: Int
    let tryAssists: Int
    let twentyFortyKicks: Int
}

struct NRLEvent: Decodable {
    let title: String
    let type: String
    let gameSeconds: Int
    let playerId: Int
    let teamId: Int
}
