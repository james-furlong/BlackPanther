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
