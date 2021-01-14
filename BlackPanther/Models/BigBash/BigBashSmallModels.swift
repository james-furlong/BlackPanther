//
//  BigBashSmallModels.swift
//  BlackPanther
//
//  Created by James Furlong on 14/1/21.
//

import Foundation

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


struct BigBashBatting: Codable {
    let style: String
    let average: String
    let strikeRate: String
    let runs: String
    
    enum CodingKeys: String, CodingKey {
        case style = "Style"
        case average = "Average"
        case strikeRate = "Strikerate"
        case runs = "Runs"
    }
}

struct BigBashBowling: Codable {
    let style: String
    let average: String
    let economyRate: String
    let runs: String?
    
    enum CodingKeys: String, CodingKey {
        case style = "Style"
        case average = "Average"
        case economyRate = "Economyrate"
        case runs = "Runs"
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


struct BigBashNugget: Codable {
    
}

struct BigBashNotes: Codable {

}

struct BigBashSubstitute: Codable {
    
}
