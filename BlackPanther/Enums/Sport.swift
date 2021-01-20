//
//  Sport.swift
//  BlackPanther
//
//  Created by James Furlong on 12/1/21.
//

import Foundation

enum Sport: String, CaseIterable, Codable {
    case NRL
    case AFL
    case BigBashCricket
    case TestCricket
    case EPL
    
    var leagueId: String {
        switch self {
            case .NRL: return "4416"
            case .AFL: return "4456"
            case .BigBashCricket: return "4461"
            case .TestCricket: return "4844"
            case .EPL: return "4328"
        }
    }
    
    var title: String {
        switch self {
            case .NRL: return "NRL"
            case .AFL: return "AFL"
            case .BigBashCricket: return "Big Bash"
            case .TestCricket: return "Test Cricket"
            case .EPL: return "EPL"
        }
    }
    
    var fixtureURL: String {
        switch self {
            case .BigBashCricket: return "https://cricket.yahoo.net/sifeeds/multisport/?methodtype=3&client=24&sport=1&league=0&timezone=0530&language=en&tournament=1638"
            default: return ""
        }
    }
}
