//
//  BigBashGame.swift
//  BlackPanther
//
//  Created by James Furlong on 12/1/21.
//

import Foundation

struct BigBashGame: Codable {
    let event_day: String?// "",
    let event_status_id: String// "114",
    let event_islinkable: String// "true",
    let league_id: String// "6",
    let event_livecoverage: String// "true",
    let participants: [BigBashTeam]// [
//    {
//    name: "Hobart Hurricanes",
//    short_name: "HOH",
//    id: "1264",
//    value: "178/8 (20.0)",
//    highlight: "true",
//    firstup: "true",
//    players_involved: [ ]
//    },
//    {
//    name: "Sydney Sixers",
//    short_name: "SYS",
//    id: "1268",
//    value: "162/6 (20.0)",
//    players_involved: [ ],
//    now: "true"
//    }
//    ],
    let parent_series_id: String// "123",
    let event_status: String// "Match Ended",
    let has_standings: String?// "true",
    let event_coverage_level_id: String// "8",
    let event_name: String// "Match 1",
    let venue_name: String// "Bellerive Oval, Hobart",
    let event_sub_status: String// "Hobart Hurricanes beat Sydney Sixers by 16 runs",
    let tour_id: String// "1638",
    let parent_series_name: String// "Big Bash League",
    let event_priority: String?// "",
    let end_date: String// "2020-12-10T17:45+05:30",
    let venue_gmt_offset: String// "+11:00",
    let game_id: String// "hhsy12102020196671",
    let start_date: String//"2020-12-10T13:45+05:30",
    let event_duration_left: String?// "",
    let event_group: String?// "",
    let tour_name: String// "Big Bash League, 2020/21",
    let result_sub_code: String?// "",
    let event_stage: String// "league",
    let event_state: String?// "R",
    let series_start_date: String// "2020-12-10",
    let event_coverage_level: String?// "Live Scorecard, Ball-by-Ball and Commentary",
    let event_session: String?// "",
    let result_code: String?// "R",
    let sport: String// "cricket",
    let event_thisover: String?// "1,w,1,1,4,1",
    let series_name: String// "Big Bash League, 2020/21",
    let event_format: String// "t20",
    let league_code: String// "australian_domestic",
    let winning_margin: String?// "16 runs",
    let series_end_date: String// "2021-02-06",
    let venue_id: String// "16",
    let event_is_daynight: String// "true",
    let series_id: String//"3946"
}
