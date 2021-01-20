//
//  NRLMatch.swift
//  BlackPanther
//
//  Created by James Furlong on 18/1/21.
//

import Foundation

struct NRLMatchResponse: Decodable {
    let matchId: String
    let updated: String
    let gameSeconds: Int
    let roundNumber: Int
    let startTime: String
    let matchMode: String
    let matchState: String
    let homeTeam: NRLMatchTeamResponse
    let awayTeam: NRLMatchTeamResponse
    let venue: String
    let venueCity: String
    let url: String
    let attendance: Int
    let competition: NRLCompetitionResponse
    let groundConditions: String
    let hasExtraTime: Bool
    let hasOnFieldTracking: Bool
    let officials: [NRLSupportPersonResponse]
    let positionGroups: [NRLPositionGroupResponse]
    let roundTitle: String
    let segmentCount: Int
    let segmentDuration: String
    let showTeamPosition: Bool
    let showPlayerPositions: Bool
    let stats: NRLMatchStatsResponse
    let timeline: [NRLEventResponse]
}

struct NRLMatchTeamResponse: Decodable {
    let teamId: Int
    let nickName: String
    let name: String?
    let score: Int?
    let captainPlayerId: Int?
    let players: [NRLPlayerResponse]?
    let coaches: [NRLSupportPersonResponse]?
    let scoring: NRLScoreResponse?
}

struct NRLSupportPersonResponse: Decodable {
    let firstName: String
    let lastName: String
    let profileId: Int
    let position: String
    let url: String
}

struct NRLScoreResponse: Decodable {
    let tries: NRLScoreSummaryResponse?
    let conversions: NRLScoreSummaryResponse?
    let penaltyGoals: NRLScoreSummaryResponse?
    let fieldGoals: NRLScoreSummaryResponse?
    let halfTimeScore: Int
}

struct NRLScoreSummaryResponse: Decodable {
    let summaries: [String]?
    let attempts: Int?
    let made: Int?
}

struct NRLCompetitionResponse: Decodable {
    let competitionId: Int?
    let name: String
    let value: Int?
}

struct NRLPositionGroupResponse: Decodable {
    let title: String
    let positions: NRLPositionResponse
}

struct NRLPositionResponse: Decodable {
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

struct NRLMatchStatsResponse: Decodable {
    let players: NRLGroupedStatsResponse
}

struct NRLGroupedStatsResponse: Decodable {
    let homeTeam: [NRLPlayerStatsResponse]
    let awayTeam: [NRLPlayerStatsResponse]
}

struct NRLPlayerStatsResponse: Decodable {
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

struct NRLEventResponse: Decodable {
    let title: String
    let type: String
    let gameSeconds: Int
    let playerId: Int
    let teamId: Int
}
