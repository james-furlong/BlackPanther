//
//  NRL_Protocols.swift
//  BlackPanther
//
//  Created by James Furlong on 21/1/21.
//

import Foundation

protocol Fixture {
    var sport: Sport { get }
    var rounds: [Round] { get }
}

protocol Match {
    var name: String { get }
    var location: String { get }
    var startDateTime: Date { get }
}

protocol Round {
    var roundTitle: String { get }
    var round: Int { get }
    var matches: [Match] { get }
}
