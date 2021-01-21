//
//  NRLFixture.swift
//  BlackPanther
//
//  Created by James Furlong on 19/1/21.
//

import Foundation

struct NRLFixture: Codable {
    let rounds: [NRLRound]
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, HH:mm"
        let header = "NRL FIXTURE:\n\n"
        var roundStrings: String = ""
        rounds.forEach { round in
            let roundHeader = "  ROUND: \(round.round)\n"
            var matchStrings = ""
            round.matches.forEach { match in
                let startTime: String = match.startDateTime != nil ? formatter.string(from: match.startDateTime!) : "Unknown"
                let temp = """
                        Match Name: \(match.name)
                        Venue: \(match.venue)
                        Home team: \(match.homeTeam.teamNickname)
                        Away team: \(match.awayTeam.teamNickname)
                        Kickoff: \(startTime)
                """
                matchStrings.append("\(temp)\n\n")
            }
            roundStrings.append("\(roundHeader)\n\(matchStrings)\n")
        }
        return "\(header)\(roundStrings)"
    }
}
