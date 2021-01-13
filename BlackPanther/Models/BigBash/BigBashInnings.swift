//
//  BigBashInnings.swift
//  BlackPanther
//
//  Created by James Furlong on 13/1/21.
//

import Foundation

struct BigBashInnings: Decodable {
    let number: String
    let battingTeam: String
    let bowlingTeam: String
    let total: String
    let wickets: String
    let overs: String
    let runrate: String
    let byes: String
    let legByes: String
    let wides: String
    let noBalls: String
    let penalty: String
    let allottedOvers: String
    let batsmen: [BigBashBatsman]
    let currentPartnership: BigBashPartnership
    let bowlers: [BigBashBowler]
    let fallOfWickets: [BigBashWicket]
    let partnerships: [BigBashPartnership]
    let powerPlay: BigBashSurgeOvers
    let powerPlayDetails: [BigBashPowerPlay]
    let lastOvers: BigBashLastOvers
    let statusId: Int?
    let reviewDetails: BigBashReview?
    let startTimeStamp: String
    
    enum CodingKeys: String, CodingKey {
        case number = "Number"
        case battingTeam = "Battingteam"
        case bowlingTeam = "Bowlingteam"
        case total = "Total"
        case wickets = "Wickets"
        case overs = "Overs"
        case runrate = "Runrate"
        case byes = "Byes"
        case legByes = "Legbyes"
        case wides = "Wides"
        case noBalls = "Noballs"
        case penalty = "Penalty"
        case allottedOvers = "AllottedOvers"
        case batsmen = "Batsmen"
        case currentPartnership = "Partnership_Current"
        case bowlers = "Bowlers"
        case fallOfWickets = "FallofWickets"
        case partnerships = "Partnerships"
        case powerPlay = "PowerPlay"
        case powerPlayDetails = "PowerPlayDetails"
        case lastOvers = "LastOvers"
        case statusId = "StatusId"
        case reviewDetails = "ReviewDetails"
        case startTimeStamp = "StartTimeStamp"
    }
}

struct BigBashBatsman: Codable {
    let batsman: String
    let runs: String
    let balls: String
    let fours: String?
    let sixes: String?
    let dots: String?
    let strikeRate: String?
    let dismissal: String?
    let howOut: String?
    let bowler: String?
    let fielder: String?
    let runScoredInLastBalls: BigBashRunScoredBalls?
    let number: Int?
    let dismissalType: String?
    let dismissalId: String?
    
    enum CodingKeys: String, CodingKey {
        case batsman = "Batsman"
        case runs = "Runs"
        case balls = "Balls"
        case fours = "Fours"
        case sixes = "Sixes"
        case dots = "Dots"
        case strikeRate = "Strikerate"
        case dismissal = "Dismissal"
        case howOut = "Howout"
        case bowler = "Bowler"
        case fielder = "Fielder"
        case runScoredInLastBalls = "RunScoredInLastBalls"
        case number = "Number"
        case dismissalType = "DismissalType"
        case dismissalId = "DismissalId"
    }
}

struct BigBashPartnership: Codable {
    let runs: String
    let balls: String
    let batsmen: [BigBashBatsman]
    let forWicket: Int
    let runRate: String?
    
    enum CodingKeys: String, CodingKey {
        case runs = "Runs"
        case balls = "Balls"
        case batsmen = "Batsmen"
        case forWicket = "ForWicket"
        case runRate = "Runrate"
    }
}

struct BigBashBowler: Codable {
    let bowler: String
    let overs: String
    let maidens: String
    let runs: String
    let wickets: String
    let economyRate: String
    let noBalls: String
    let wides: String
    let dots: String
    let runGivenInLastBalls: BigBashRunScoredBalls
    let number: Int
    
    enum CodingKeys: String, CodingKey {
        case bowler = "Bowler"
        case overs = "Overs"
        case maidens = "Maidens"
        case runs = "Runs"
        case wickets = "Wickets"
        case economyRate = "Economyrate"
        case noBalls = "Noballs"
        case wides = "Wides"
        case dots = "Dots"
        case runGivenInLastBalls = "RungivenInLastBalls"
        case number = "Number"
    }
}

struct BigBashWicket: Codable {
    let batsman: String
    let score: String
    let overs: String
    let wicketNo: String?
    
    enum CodingKeys: String, CodingKey {
        case batsman = "Batsman"
        case score = "Score"
        case overs = "Overs"
        case wicketNo = "Wicket_no"
    }
}

struct BigBashSurgeOvers: Codable {
    let pp1: String
    let pp2: String?
    
    enum CodingKeys: String, CodingKey {
        case pp1 = "PP1"
        case pp2 = "PP2"
    }
}

struct BigBashPowerPlay: Codable {
    let name: String?
    let overs: String?
    let runs: String?
    let wickets: String?
    let isSurge: Bool?
    
    enum codingKeys: String, CodingKey {
        case name = "Name"
        case overs = "Overs"
        case runs = "Runs"
        case wickets = "Wickets"
        case isSurge = "Isbatting_powerplay"
    }
}

struct BigBashLastOvers: Decodable {
    let five: BigBashOver
    let ten: BigBashOver
    
    enum CodingKeys: String, CodingKey {
        case five = "5"
        case ten = "10"
    }
}

struct BigBashOver: Decodable {
    let score: String
    let wicket: String
    let runrate: String
    
    enum CodingKeys: String, CodingKey {
        case score = "Score"
        case wicket = "Wicket"
        case runrate = "Runrate"
    }
}

struct BigBashReview: Codable {
    
}

struct BigBashRunScoredBalls: Codable {
    let ten: String?
    let twenty: String?
    
    enum CodingKeys: String, CodingKey {
        case ten = "10"
        case twenty = "20"
    }
}
