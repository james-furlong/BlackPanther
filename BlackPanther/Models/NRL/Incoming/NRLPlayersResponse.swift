//
//  NRLPlayersResponse.swift
//  BlackPanther
//
//  Created by James Furlong on 10/1/21.
//

import Foundation

struct NRLPlayersResponse: Decodable {
    let profileGroups: [NRLProfileGroupResponse]
}
