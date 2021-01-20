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
}

enum NRLMatchMode: String, Codable {
    case Post = "Post"
    case Pre = "Pre"
}

enum NRLMatchState: String, Codable {
    case Fulltime = "FullTime"
    case Upcoming = "Upcoming"
    case Ongoing = "Ongoing"
}

struct NRLStats: Codable {
    let teamId: Int
    let playerStats: [NRLPlayerStats]
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
}
