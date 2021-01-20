//
//  NRLRound.swift
//  BlackPanther
//
//  Created by James Furlong on 19/1/21.
//

import Foundation

struct NRLRound: Codable, Round {
    var round: Int
    let roundTitle: String
    let roundStartDateTime: Date
    let roundEndDateTime: Date
    let matches: [NRLMatch]
}
