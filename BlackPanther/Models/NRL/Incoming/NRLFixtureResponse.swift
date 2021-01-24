//
//  NRLFixtureResponse.swift
//  BlackPanther
//
//  Created by James Furlong on 11/1/21.
//

import Foundation

struct NRLFixtureResponse: Decodable {
    let fixtures: [NRLRoundResponse]?
    let filterCompetitions: [NRLFilterResponse]?
    let filterSeasons: [NRLFilterResponse]?
    let filterRounds: [NRLFilterResponse]?
    let filterTeams: [NRLFilterResponse]?
    let selectedCompetitionId: Int?
    let selectedSeasonId: Int?
    let selectedRoundId: Int?
    let selectedTeamId: Int?
}

struct NRLFilterResponse: Decodable {
    let name: String
    let value: Int
}

enum NRLComp: Int {
    case PremiershipMens = 111
    case PremiershipWomens = 161
    case StateOfOriginMens = 116
    case StateOfOriginWomens = 156
}
