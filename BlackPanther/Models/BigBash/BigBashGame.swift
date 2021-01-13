//
//  BigBashGame.swift
//  BlackPanther
//
//  Created by James Furlong on 12/1/21.
//

import Foundation

struct BigBashParticipant: Decodable {
    let name: String
    let shortName: String
    let id: String
    let value: String?
    let highlight: String?
    let firstUp: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case shortName = "short_name"
        case id = "id"
        case value = "value"
        case highlight = "highlight"
        case firstUp = "firstup"
    }
}

struct BigBashGame: Decodable {
    let event_day: String?
    let event_status_id: String
    let event_islinkable: String
    let league_id: String
    let event_livecoverage: String
    let participants: [BigBashParticipant]
    let parent_series_id: String
    let event_status: String
    let has_standings: String?
    let event_coverage_level_id: String
    let event_name: String
    let venue_name: String
    let event_sub_status: String
    let tour_id: String
    let parent_series_name: String
    let event_priority: String?
    let end_date: String
    let venue_gmt_offset: String
    let game_id: String
    let start_date: String
    let event_duration_left: String?
    let event_group: String?
    let tour_name: String
    let result_sub_code: String?
    let event_stage: String
    let event_state: String?
    let series_start_date: String
    let event_coverage_level: String?
    let event_session: String?
    let result_code: String?
    let sport: String
    let event_thisover: String?
    let series_name: String
    let event_format: String
    let league_code: String
    let winning_margin: String?
    let series_end_date: String
    let venue_id: String
    let event_is_daynight: String
    let series_id: String
    
    var startDateTime: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'hh:mmZ"
        
        return formatter.date(from: start_date)
    }
    
    var matchStatus: BigBashMatchStatus? {
        return BigBashMatchStatus.init(rawValue: Int(event_status_id) ?? BigBashMatchStatus.Scheduled.rawValue)
    }
}

enum BigBashMatchStatus: Int {
    case Completed = 114
    case Scheduled = 115
}
