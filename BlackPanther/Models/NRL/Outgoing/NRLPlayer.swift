//
//  NRLPlayer.swift
//  BlackPanther
//
//  Created by James Furlong on 22/1/21.
//

import Foundation

struct NRLPlayer: Encodable {
    let firstName: String
    let lastName: String
    let position: NRLPosition?
    let team: NRLTeam
    
    init(from response: NRLPlayerResponse, team: NRLTeam ) {
        self.firstName = response.firstName
        self.lastName = response.lastName
        self.position = NRLPosition(rawValue: response.position)
        self.team = team
    }
    
    func toString() -> String {
        return """

        Name: \(firstName) \(lastName)
        Team: \(team.teamNickname)
        Position: \(position?.rawValue ?? "Unknown")
        """
    }
}

enum NRLPosition: String, Encodable {
    case Prop
    case SecondRow = "2ndRow"
    case Lock
    case Hooker
    case FiveEighth = "Five-Eighth"
    case Halfback
    case Centre
    case Winger
    case Fullback
}
