//
//  Sport.swift
//  BlackPanther
//
//  Created by James Furlong on 12/1/21.
//

import Foundation

enum Sport: String, CaseIterable, Codable {
    case NRL
    case NRLW
    case StateOfOrigin
    case StateOfOriginWomens
    case AFL
    case AFLW
    case BigBashCricket
    case BigBashWomens
    case TestCricket
    case EPL
    
    var title: String {
        switch self {
            case .NRL: return "NRL"
            case .NRLW: return "NRLW"
            case .StateOfOrigin: return "State of Origin - Mens"
            case .StateOfOriginWomens: return "State of Origin - Womens"
            case .AFL: return "AFL"
            case .AFLW: return "AFLW"
            case .BigBashCricket: return "Big Bash Cricker - Mens"
            case .BigBashWomens: return "Big Bash Cricket - Womens"
            case .TestCricket: return "Test Cricket"
            case .EPL: return "EPL"
        }
    }
    
    var nrlComp: NRLComp? {
        switch self {
            case .NRL: return .PremiershipMens
            case .NRLW: return .PremiershipWomens
            case .StateOfOrigin: return .StateOfOriginMens
            case .StateOfOriginWomens: return .StateOfOriginWomens
            default: return nil
        }
    }
    
    var fixtureURL: String {
        switch self {
            case .BigBashCricket: return "https://cricket.yahoo.net/sifeeds/multisport/?methodtype=3&client=24&sport=1&league=0&timezone=0530&language=en&tournament=1638"
            default: return ""
        }
    }
}
