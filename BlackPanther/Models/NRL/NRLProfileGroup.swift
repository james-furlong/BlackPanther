//
//  NRLProfileGroup.swift
//  BlackPanther
//
//  Created by James Furlong on 10/1/21.
//

import Foundation

struct NRLProfileGroup: Codable {
    let title: String
    let profiles: [NRLPlayer]
}
