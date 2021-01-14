//
//  NRLRound.swift
//  BlackPanther
//
//  Created by James Furlong on 11/1/21.
//

import Foundation

protocol RoundResult { }

struct NRLRound: Codable, RoundResult {
    let dateEvent: String?// = "2021-06-06";
    let dateEventLocal: String?// = "2021-06-06";
    let idAwayTeam: String?// = 135183;
    let idEvent: String?// = 1066474;
    let idHomeTeam: String?// = 135198;
    let idLeague: String?// = 4416;
    let intRound: String?// = 13;
    let strAwayTeam: String?// = "Parramatta Eels";
    let strEvent: String?// = "Newcastle Knights  vs Parramatta Eels";
    let strEventAlternate: String?// = "Parramatta Eels @ Newcastle Knights ";
    let strFilename: String?// = "Australian National Rugby League 2021-06-06 Newcastle Knights  vs Parramatta Eels";
    let strHomeTeam: String?// = "Newcastle Knights ";
    let strLeague: String?// = "Australian National Rugby League";
    let strSeason: String?// = 2021;
    let strTime: String?// = "07:05:00";
    let strTimeLocal: String?// = "7:05:00";
    
    var startDateTime: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = self.dateEvent else { return nil }
        guard let time = self.strTime else { return nil }
        let dateTimeString: String = "\(date) \(time)"
        
        return formatter.date(from: dateTimeString) ?? nil
    }
    
    var startDateTimeLocal: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = self.dateEventLocal else { return nil }
        guard let time = self.strTimeLocal else { return nil }
        let dateTimeString: String = "\(date) \(time)"
        
        return formatter.date(from: dateTimeString) ?? nil
    }
}
