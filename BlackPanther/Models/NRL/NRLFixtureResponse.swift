//
//  NRLFixtureResponse.swift
//  BlackPanther
//
//  Created by James Furlong on 11/1/21.
//

import Foundation

protocol Fixture { }

struct NRLFixtureResponse: Codable, Fixture {
    let events: [NRLRound]
}
