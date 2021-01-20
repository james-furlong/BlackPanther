//
//  NRLPlayerStats.swift
//  BlackPanther
//
//  Created by James Furlong on 19/1/21.
//

import Foundation

protocol Stats { }

struct NRLPlayerStats: Codable {
    let playerId: Int
    let playerName: String
    let allRunMetres: Int
    let allRuns: Int
    let bombKicks: Int
    let crossFieldKicks: Int
    let conversions: Int
    let conversionAttempts: Int
    let dummyHalfRuns: Int
    let dummyHalfRunMetres: Int
    let dummyPasses: Int
    let errors: Int
    let fantasyPointsTotal: Int
    let fieldGoals: Int
    let forcedDropOutKicks: Int
    let fortyTwentyKicks: Int
    let goals: Int
    let goalConversionRate: Int
    let grubberKicks: Int
    let handlingErrors: Int
    let hitUps: Int
    let hitUpRunMetres: Int
    let ineffectiveTackles: Int
    let intercepts: Int
    let kicks: Int
    let kicksDead: Int
    let kicksDefused: Int
    let kickMetres: Int
    let kickReturnMetres: Int
    let lineBreakAssists: Int
    let lineBreaks: Int
    let lineEngagedRuns: Int
    let minutesPlayed: Int
    let missedTackles: Int
    let offloads: Int
    let oneOnOneLost: Int
    let oneOnOneSteal: Int
    let onReport: Int
    let passesToRunRatio: Double
    let passes:  Int
    let playTheBallTotal: Int
    let playTheBallAverageSpeed: Double
    let penalties: Int
    let points: Int
    let penaltyGoals: Int
    let postContactMetres: Int
    let receipts: Int
    let ruckInfringements: Int
    let sendOffs: Int
    let sinBins: Int
    let stintOne: Int
    let tackleBreaks: Int
    let tackleEfficiency: Double
    let tacklesMade: Int
    let tries: Int
    let tryAssists: Int
    let twentyFortyKicks: Int
}
