//
//  BigBashMatchDetail.swift
//  BlackPanther
//
//  Created by James Furlong on 13/1/21.
//

import Foundation

struct BigBashMatchDetail: Codable {
    let awards: [BigBashMatchAwards]
    let teamHome: String
    let teamAway: String
    let match: BigBashMatch
    let series: BigBashSeries
    let venue: BigBashVenue
    let officials: BigBashOfficials
    let weather: String
    let tossWonBy: String
    let tossElectedTo: String
    let status: String
    let statusId: String
    let playerMatch: String
    let playerMatchId: String
    let playerMatchTeamId: String
    let result: String
    let winningTeam: String
    let winMargin: String
    let equation: String
    let rawMatchResult: String
    let rawMarginValue: String
    let rawResultExtras: String?
    let requiredRunrate: String?
    let verificationCompleted: Bool
    
    enum CodingKeys: String, CodingKey {
        case awards = "Awards"
        case teamHome = "Team_Home"
        case teamAway = "Team_Away"
        case match = "Match"
        case series = "Series"
        case venue = "Venue"
        case officials = "Officials"
        case weather = "Weather"
        case tossWonBy = "Tosswonby"
        case tossElectedTo = "Toss_elected_to"
        case status = "Status"
        case statusId = "Status_Id"
        case playerMatch = "Player_Match"
        case playerMatchId = "Player_Match_Id"
        case playerMatchTeamId = "Player_Match_TeamId"
        case result = "Result"
        case winningTeam = "Winningteam"
        case winMargin = "Winmargin"
        case equation = "Equation"
        case rawMatchResult = "Raw_matchresult"
        case rawMarginValue = "Raw_margin_value"
        case rawResultExtras = "Raw_results_extras"
        case requiredRunrate = "Required_runrate"
        case verificationCompleted = "Verification_Completed"
    }
}

struct BigBashOfficials: Codable {
    let umpires: String
    let referee: String
    
    enum CodingKeys: String, CodingKey {
        case umpires = "Umpires"
        case referee = "Referee"
    }
}

struct BigBashVenue: Codable {
    let id: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
    }
}

struct BigBashSeries: Codable {
    let id: String
    let name: String
    let shortName: String
    let seriesStartDate: String
    let seriesEndDate: String
    let seriesType: String
    let status: String
    let tour: String
    let tourName: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case shortName = "Series_short_display_name"
        case seriesStartDate = "Series_start_date"
        case seriesEndDate = "Series_end_date"
        case seriesType = "Series_type"
        case status = "Status"
        case tour = "Tour"
        case tourName = "Tour_name"
    }
}

struct BigBashMatchAwards: Codable {
    let playerId: String
    let playerName: String
    let teamId: String
    let awardType: Int
    
    enum CodingKeys: String, CodingKey {
        case playerId = "Player_Id"
        case playerName = "Player_Name"
        case teamId = "Team_Id"
        case awardType = "Award_Type"
    }
}

struct BigBashMatch: Codable {
    let liveCoverage: String
    let id: String
    let code: String
    let league: String
    let leagueId: String
    let number: String
    let type: String
    let date: String
    let time: String
    let offset: String
    let group: String
    let coverageLevelId: String
    let coverageLevel: String
    let matchOrdinal: String
    let dayNight: String
    let compTypeId: String
    let endDate: String
    let endTime: String
    
    enum CodingKeys: String, CodingKey {
        case liveCoverage = "Livecoverage"
        case id = "Id"
        case code = "Code"
        case league = "League"
        case leagueId = "League_Id"
        case number = "Number"
        case type = "Type"
        case date = "Date"
        case time = "Time"
        case offset = "Offset"
        case group = "Group"
        case coverageLevelId = "Coverage_level_id"
        case coverageLevel = "Coverage_level"
        case matchOrdinal = "Match_ordinal"
        case dayNight = "Daynight"
        case compTypeId = "Comp_type_id"
        case endDate = "End_date"
        case endTime = "End_time"
    }
}
