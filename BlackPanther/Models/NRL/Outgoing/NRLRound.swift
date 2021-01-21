//
//  NRLRound.swift
//  BlackPanther
//
//  Created by James Furlong on 19/1/21.
//

import Foundation

struct NRLRound: Codable {
    var round: Int
    let roundTitle: String?
    let roundStartDateTime: Date?
    let roundEndDateTime: Date?
    var matches: [NRLMatch]
    
    init(from fixture: NRLFixtureResponse) {
        let roundResponse: [NRLRoundResponse] = fixture.fixtures
        var matchArray = [NRLMatch]()
        roundResponse.forEach { round in
            matchArray.append(
                NRLMatch(
                    name: "\(round.homeTeam.nickName) vs \(round.awayTeam.nickName)",
                    location: round.venueCity,
                    startDateTime: round.startDateTime,
                    matchMode: NRLMatchMode.init(rawValue: round.matchMode) ?? NRLMatchMode.Pre,
                    matchState: NRLMatchState.init(rawValue: round.matchState) ?? NRLMatchState.Upcoming,
                    venue: round.venue,
                    venueCity: round.venueCity,
                    matchUrl: round.matchCentreUrl,
                    homeTeam: NRLTeam(from: round.homeTeam),
                    homeTeamStats: nil,
                    awayTeam: NRLTeam(from: round.awayTeam),
                    awayTeamStats: nil
                )
            )
        }
        matchArray.sort { $0.startDateTime ?? Date() < $1.startDateTime ?? Date() }
        
        let round: Int? = fixture
            .filterRounds
            .first { $0.name == roundResponse.first?.roundTitle }?
            .value
        
//        let roundString = roundResponse.first?.roundTitle ?? "1"
//        let round = roundString
//            .components(separatedBy: CharacterSet.decimalDigits.inverted)
//            .filter { Int($0) != nil }
//            .first
//
        self.round = round ?? 0
        self.roundTitle = roundResponse.first?.roundTitle
        self.roundStartDateTime = roundResponse.first?.startDateTime
        self.roundEndDateTime = roundResponse.last?.startDateTime?.addingTimeInterval(TimeInterval(60 * 60 * 100))
        self.matches = matchArray
    }
}
