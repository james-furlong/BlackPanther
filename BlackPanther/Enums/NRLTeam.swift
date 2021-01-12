//
//  NRLTeam.swift
//  BlackPanther
//
//  Created by James Furlong on 12/1/21.
//

import Foundation

enum NRLTeam: CaseIterable {
    case BrisbaneBroncos
    case CanberraRaiders
    case CanterburyBulldogs
    case CronullaSharks
    case GoldCoastTitans
    case ManlySeaEagles
    case MelbourneStorm
    case NewcastleKnights
    case NewZealandWarriors
    case NorthQueenslandCowboys
    case ParramattaEels
    case PenrithPanthers
    case SouthSydneyRabbitohs
    case StGeorgeDragons
    case SydneyRoosters
    case WestTigers
    
    var url: String {
        switch self {
            case .BrisbaneBroncos: return "https://www.broncos.com.au/teams/"
            case .CanberraRaiders: return "https://www.raiders.com.au/teams/"
            case .CanterburyBulldogs: return "https://www.bulldogs.com.au/teams/"
            case .CronullaSharks: return "https://www.sharks.com.au/teams/"
            case .GoldCoastTitans: return "https://www.titans.com.au/teams/"
            case .ManlySeaEagles: return "https://www.seaeagles.com.au/teams/"
            case .MelbourneStorm: return "https://www.melbournestorm.com.au/teams/"
            case .NewcastleKnights: return "https://www.newcastleknights.com.au/teams/"
            case .NewZealandWarriors: return "https://www.warriors.kiwi/teams/"
            case .NorthQueenslandCowboys: return "https://www.cowboys.com.au/teams/"
            case .ParramattaEels: return "https://www.parraeels.com.au/teams/"
            case .PenrithPanthers: return "https://www.penrithpanthers.com.au/teams/"
            case .SouthSydneyRabbitohs: return "https://www.rabbitohs.com.au/teams/"
            case .StGeorgeDragons: return "https://www.dragons.com.au/teams/"
            case .SydneyRoosters: return "https://www.roosters.com.au/teams/"
            case .WestTigers: return "https://www.weststigers.com.au/teams/"
        }
    }
}
