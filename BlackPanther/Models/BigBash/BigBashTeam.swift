//
//  BigBashTeam.swift
//  BlackPanther
//
//  Created by James Furlong on 12/1/21.
//

import Foundation

struct BigBashTeam: Codable {
    let name: String
    let short_name: String
    let id: String
    let value: String?
    let highlight: String?
    let firstup: String?
    let players_involved: [BigBashPlayer]?
}
