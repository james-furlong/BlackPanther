//
//  NRLFixture.swift
//  BlackPanther
//
//  Created by James Furlong on 19/1/21.
//

import Foundation

struct NRLFixture: Encodable, Fixture {
    let sport: Sport
    var rounds: [Round]
}
