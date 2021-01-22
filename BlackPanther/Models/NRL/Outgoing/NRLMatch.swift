//
//  NRLMatch.swift
//  BlackPanther
//
//  Created by James Furlong on 21/1/21.
//

import Foundation

struct NRLMatch: Codable {
    let name: String
    let location: String
    let startDateTime: Date?
    let matchMode: NRLMatchMode
    let matchState: NRLMatchState
    let venue: String
    let venueCity: String
    let matchUrl: String
    let homeTeam: NRLTeam
    let homeTeamStats: NRLStats?
    let awayTeam: NRLTeam
    let awayTeamStats: NRLStats?
    let results: NRLMatchResult?
    
    init(
        name: String,
        location: String,
        startDateTime: Date?,
        matchMode: NRLMatchMode,
        matchState: NRLMatchState,
        venue: String,
        venueCity: String,
        matchUrl: String,
        homeTeam: NRLTeam,
        homeTeamStats: NRLStats?,
        awayTeam: NRLTeam,
        awayTeamStats: NRLStats?,
        results: NRLMatchResult? = nil
    ) {
        self.name = name
        self.location = location
        self.startDateTime = startDateTime
        self.matchMode = matchMode
        self.matchState = matchState
        self.venue = venue
        self.venueCity = venueCity
        self.matchUrl = matchUrl
        self.homeTeam = homeTeam
        self.homeTeamStats = homeTeamStats
        self.awayTeam = awayTeam
        self.awayTeamStats = awayTeamStats
        self.results = results
    }
    
    init(from matchResponse: NRLMatchResponse, with matchData: NRLMatch) {
        self.name = matchData.name
        self.location = matchData.location
        self.startDateTime = matchData.startDateTime
        self.matchMode = matchData.matchMode
        self.matchState = matchData.matchState
        self.venue = matchData.venue
        self.venueCity = matchData.venueCity
        self.matchUrl = matchData.matchUrl
        self.homeTeam = matchData.homeTeam
        self.homeTeamStats = NRLStats(from: matchResponse, team: .Home, teamId: matchData.homeTeam.teamId)
        self.awayTeam = matchData.awayTeam
        self.awayTeamStats = NRLStats(from: matchResponse, team: .Away, teamId: matchData.awayTeam.teamId)
        self.results = NRLMatchResult(from: matchResponse)
    }
}

enum NRLMatchMode: String, Codable {
    case Post = "Post"
    case Pre = "Pre"
    case Mid = "Mid"
}

enum NRLMatchTeam {
    case Home
    case Away
}

enum NRLMatchState: String, Codable {
    case Fulltime = "FullTime"
    case Upcoming = "Upcoming"
    case Ongoing = "Ongoing"
}

struct NRLStats: Codable {
    let teamId: Int
    let playerStats: [NRLPlayerStats]
    
    init(from response: NRLMatchResponse, team: NRLMatchTeam, teamId: Int) {
        self.teamId = teamId
        self.playerStats = NRLPlayerStats.statsArray(from: response, team: team)
    }
}

struct NRLTeam: Codable {
    let teamId: Int
    let teamName: String?
    let teamNickname: String
    let teamPosition: Int?
    
    init(from response: NRLMatchTeamResponse) {
        self.teamId = response.teamId
        self.teamName = response.name
        self.teamNickname = response.nickName
        self.teamPosition = nil
    }
    
    init(from response: NRLTeamResponse.NRLTeam) {
        self.teamId = response.value
        self.teamName = nil
        self.teamNickname = response.name
        self.teamPosition = nil
    }
}

struct NRLMatchResult: Codable {
    let score: String
    let teamCaptainHome: String?
    let teamCaptainHomeId: Int?
    let teamCaptainAway: String?
    let teamCaptainAwayId: Int?
    let gameSeconds: Int
    let homeScore: Int
    let homeHalfTimeScore: Int
    let awayScore: Int
    let awayHalfTimeScore: Int
    let homeTries: Int
    let awayTries: Int
    let homeConversions: Int
    let awayConversions: Int
    let homeConversionAttempts: Int
    let awayConversionAttempts: Int
    let homePenaltyGoals: Int
    let awayPenaltyGoals: Int
    let homePenaltyGoalAttempts: Int
    let awayPenaltyGoalAttempts: Int
    let homeFieldGoals: Int
    let awayFieldGoals: Int
    let homeFieldGoalAttempts: Int
    let awayFieldGoalAttempts: Int
    let homeSinBins: Int
    let awaySinBins: Int
    let homeSendOffs: Int
    let awaySendOffs: Int
    let events: [NRLEvent]
    
    init(from results: NRLMatchResponse) {
        let homeScore = results.homeTeam.score ?? 0
        let awayScore = results.awayTeam.score ?? 0
        let homeCaptain: String? = results.homeTeam.players?
            .first { $0.playerId == results.homeTeam.captainPlayerId }
            .map { player in "\(player.firstName) \(player.lastName)" }
        let awayCaptain: String? = results.awayTeam.players?
            .first { $0.playerId == results.awayTeam.captainPlayerId }
            .map { player in "\(player.firstName) \(player.lastName)" }
        let events: [NRLEvent] = NRLEvent.from(response: results)
        
        self.score = "\(homeScore) - \(awayScore)"
        self.teamCaptainHome = homeCaptain
        self.teamCaptainHomeId = results.homeTeam.captainPlayerId
        self.teamCaptainAway = awayCaptain
        self.teamCaptainAwayId = results.awayTeam.captainPlayerId
        self.gameSeconds = results.gameSeconds
        self.homeScore = homeScore
        self.homeHalfTimeScore = results.homeTeam.scoring?.halfTimeScore ?? 0
        self.awayScore = awayScore
        self.awayHalfTimeScore = results.awayTeam.scoring?.halfTimeScore ?? 0
        self.homeTries = results.homeTeam.scoring?.tries?.made ?? 0
        self.awayTries = results.awayTeam.scoring?.tries?.made ?? 0
        self.homeConversions = results.homeTeam.scoring?.conversions?.made ?? 0
        self.homeConversionAttempts = results.homeTeam.scoring?.conversions?.attempts ?? 0
        self.awayConversions = results.awayTeam.scoring?.conversions?.made ?? 0
        self.awayConversionAttempts = results.awayTeam.scoring?.conversions?.attempts ?? 0
        self.homePenaltyGoals = results.homeTeam.scoring?.penaltyGoals?.made ?? 0
        self.homePenaltyGoalAttempts = results.homeTeam.scoring?.penaltyGoals?.attempts ?? 0
        self.awayPenaltyGoals = results.awayTeam.scoring?.penaltyGoals?.made ?? 0
        self.awayPenaltyGoalAttempts = results.awayTeam.scoring?.penaltyGoals?.attempts ?? 0
        self.homeFieldGoals = results.homeTeam.scoring?.fieldGoals?.made ?? 0
        self.homeFieldGoalAttempts = results.homeTeam.scoring?.fieldGoals?.attempts ?? 0
        self.awayFieldGoals = results.awayTeam.scoring?.fieldGoals?.made ?? 0
        self.awayFieldGoalAttempts = results.awayTeam.scoring?.fieldGoals?.attempts ?? 0
        self.homeSinBins = results.homeTeam.discipline?.sinBin?.summaries.count ?? 0
        self.homeSendOffs = results.homeTeam.discipline?.sendOff?.summaries.count ?? 0
        self.awaySinBins = results.awayTeam.discipline?.sinBin?.summaries.count ?? 0
        self.awaySendOffs = results.awayTeam.discipline?.sendOff?.summaries.count ?? 0
        self.events = events
    }
}

struct NRLEvent: Codable {
    enum EventType: String, Codable {
        case Try
        case PenaltyTry
        case Conversion
        case PenaltyGoal
        case FieldGoal
        case SinBin
        case SendOff
    }
    
    let type: EventType
    let time: String
    let playerName: String
    let playerId: Int
    
    static func from(response: NRLMatchResponse) -> [NRLEvent] {
        var eventArray: [NRLEvent] = []
        func convert(summary: String, type: NRLEvent.EventType) -> [NRLEvent] {
            let array: [NRLEvent] = []
            let bits = summary.components(separatedBy: " ")
            let playerName = "\(bits[0]) \(bits[1])"
            eventArray.append(
                NRLEvent(
                    type: .Try,
                    time: bits.last ?? "",
                    playerName: playerName,
                    playerId: response.awayTeam.players?.first { $0.firstName == bits[0] && $0.lastName == bits[1] }.map { $0.playerId ?? 0 } ?? 0
                )
            )
            
            return array
        }
        response.homeTeam.scoring?.tries?.summaries?.forEach { eventArray.append(contentsOf: convert(summary: $0, type: .Try)) }
        response.awayTeam.scoring?.tries?.summaries?.forEach { eventArray.append(contentsOf: convert(summary: $0, type: .Try)) }
        response.homeTeam.scoring?.conversions?.summaries?.forEach { eventArray.append(contentsOf: convert(summary: $0, type: .Conversion)) }
        response.awayTeam.scoring?.conversions?.summaries?.forEach { eventArray.append(contentsOf: convert(summary: $0, type: .Conversion)) }
        response.homeTeam.scoring?.penaltyGoals?.summaries?.forEach { eventArray.append(contentsOf: convert(summary: $0, type: .PenaltyGoal)) }
        response.awayTeam.scoring?.penaltyGoals?.summaries?.forEach { eventArray.append(contentsOf: convert(summary: $0, type: .PenaltyGoal)) }
        response.homeTeam.scoring?.fieldGoals?.summaries?.forEach { eventArray.append(contentsOf: convert(summary: $0, type: .FieldGoal)) }
        response.awayTeam.scoring?.fieldGoals?.summaries?.forEach { eventArray.append(contentsOf: convert(summary: $0, type: .FieldGoal)) }
        response.homeTeam.discipline?.sinBin?.summaries.forEach { eventArray.append(contentsOf: convert(summary: $0, type: .SinBin)) }
        response.awayTeam.discipline?.sinBin?.summaries.forEach { eventArray.append(contentsOf: convert(summary: $0, type: .SinBin)) }
        response.homeTeam.discipline?.sendOff?.summaries.forEach { eventArray.append(contentsOf: convert(summary: $0, type: .SendOff)) }
        response.awayTeam.discipline?.sendOff?.summaries.forEach { eventArray.append(contentsOf: convert(summary: $0, type: .SendOff)) }
        
        return eventArray
    }
}

