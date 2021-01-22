//
//  NRLTeamResponse.swift
//  BlackPanther
//
//  Created by James Furlong on 22/1/21.
//

import Foundation

struct NRLTeamResponse: Decodable {
    struct NRLTeam: Decodable {
        let name: String
        let value: Int
    }
    let filterTeams: [NRLTeam]
}
