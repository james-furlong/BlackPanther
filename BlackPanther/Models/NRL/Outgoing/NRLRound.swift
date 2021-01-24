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
    
    var roundUrl: String {
        roundTitle?.replacingOccurrences(of: " ", with: "-").lowercased() ?? ""
    }
    
    init(round: Int, roundTitle: String? = nil, roundStartDateTime: Date? = nil, roundEndDateTime: Date? = nil, matches: [NRLMatch] = []) {
        self.round = round
        self.roundTitle = roundTitle
        self.roundStartDateTime = roundStartDateTime
        self.roundEndDateTime = roundEndDateTime
        self.matches = matches
    }
    
    init(from fixture: NRLFixtureResponse) {
        let roundResponse: [NRLRoundResponse]? = fixture.fixtures
        var matchArray = [NRLMatch]()
        roundResponse?.forEach { round in
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
            .filterRounds?
            .first { $0.name == roundResponse?.first?.roundTitle }?
            .value

        self.round = round ?? 0
        self.roundTitle = roundResponse?.first?.roundTitle ?? ""
        self.roundStartDateTime = roundResponse?.first?.startDateTime
        self.roundEndDateTime = roundResponse?.last?.startDateTime?.addingTimeInterval(TimeInterval(60 * 60 * 100))
        self.matches = matchArray
    }
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, HH:mm"
        let header = "NRL MAATCH RESULT ------------------- \n\n"
        let orderedMatches: [NRLMatch] = matches.sorted { $0.startDateTime ?? Date() < $1.startDateTime ?? Date() }
        var roundString: String = ""
        orderedMatches.forEach { match in
            let startTime: String = match.startDateTime != nil ? formatter.string(from: match.startDateTime!) : "Unknown"
            let matchResult = """
                        Match Name: \(match.name)
                        Home team: \(match.homeTeam.teamNickname)
                        Away team: \(match.awayTeam.teamNickname)
                        Start time: \(startTime)
                        Score: \(match.results?.score ?? "")
            """
            roundString.append("\(matchResult)\n\n")
        }
        return "\(header)\(roundString)"
    }
    
    static func resultString(from rounds: [NRLRound]) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, HH:mm"
        let header = "NRL RESULTS ------------------- \n\n"
        let orderedRounds = rounds.sorted { $0.round < $1.round }
        var roundStrings: String = ""
        orderedRounds.forEach { round in
            let roundHeader = "  ROUND: \(round.round)\n"
            var matchStrings = ""
            round.matches.forEach { match in
                let startTime: String = match.startDateTime != nil ? formatter.string(from: match.startDateTime!) : "Unknown"
                let temp = """
                        Match Name: \(match.name)
                        Home team: \(match.homeTeam.teamNickname)
                        Away team: \(match.awayTeam.teamNickname)
                        Start time: \(startTime)
                        Score: \(match.results?.score ?? "")
                """
                matchStrings.append("\(temp)\n\n")
            }
            roundStrings.append("\(roundHeader)\n\(matchStrings)\n")
        }
        return "\(header)\(roundStrings)"
    }
}
