//
//  NRLPlayer.swift
//  BlackPanther
//
//  Created by James Furlong on 10/1/21.
//

import Foundation

struct NRLPlayerResponse: Decodable {
    let firstName: String
    let lastName: String
    let position: String
    let playerId: Int
    let url: String
    let number: Int
    let isOnField: Bool
}
