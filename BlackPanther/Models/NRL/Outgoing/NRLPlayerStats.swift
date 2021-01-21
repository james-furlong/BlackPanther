//
//  NRLPlayerStats.swift
//  BlackPanther
//
//  Created by James Furlong on 19/1/21.
//

import Foundation

protocol Stats { }

struct NRLPlayerStats: Codable {
    let playerId: Int?
    var playerName: String?
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
    let goalConversionRate: Decimal
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
    
    static func statsArray(from response: NRLMatchResponse, team: NRLMatchTeam) -> [NRLPlayerStats] {
        var stats: [NRLPlayerStats] = [NRLPlayerStats]()
        let values: [NRLPlayerStatsResponse] = team == .Home ? response.stats.players.homeTeam : response.stats.players.awayTeam
        let players: [NRLPlayerResponse]? = team == .Home ? response.homeTeam.players : response.awayTeam.players
        values.forEach { value in
            let name: String? = players?.filter { $0.playerId == value.playerId }.first.map { "\($0.firstName) \($0.lastName)" }
            stats.append(
                NRLPlayerStats(
                    playerId: value.playerId,
                    playerName: name,
                    allRunMetres: value.allRunMetres,
                    allRuns: value.allRuns,
                    bombKicks: value.bombKicks,
                    crossFieldKicks: value.crossFieldKicks,
                    conversions: value.conversions,
                    conversionAttempts: value.conversionAttempts,
                    dummyHalfRuns: value.dummyHalfRuns,
                    dummyHalfRunMetres: value.dummyHalfRunMetres,
                    dummyPasses: value.dummyPasses,
                    errors: value.errors,
                    fantasyPointsTotal: value.fantasyPointsTotal,
                    fieldGoals: value.fieldGoals,
                    forcedDropOutKicks: value.forcedDropOutKicks,
                    fortyTwentyKicks: value.fortyTwentyKicks,
                    goals: value.goals,
                    goalConversionRate: value.goalConversionRate,
                    grubberKicks: value.grubberKicks,
                    handlingErrors: value.handlingErrors,
                    hitUps: value.hitUps,
                    hitUpRunMetres: value.hitUpRunMetres,
                    ineffectiveTackles: value.ineffectiveTackles,
                    intercepts: value.intercepts,
                    kicks: value.kicks,
                    kicksDead: value.kicksDead,
                    kicksDefused: value.kicksDefused,
                    kickMetres: value.kickMetres,
                    kickReturnMetres: value.kickReturnMetres,
                    lineBreakAssists: value.lineBreakAssists,
                    lineBreaks: value.lineBreaks,
                    lineEngagedRuns: value.lineEngagedRuns,
                    minutesPlayed: value.minutesPlayed,
                    missedTackles: value.missedTackles,
                    offloads: value.offloads,
                    oneOnOneLost: value.oneOnOneLost,
                    oneOnOneSteal: value.oneOnOneSteal,
                    onReport: value.onReport,
                    passesToRunRatio: value.passesToRunRatio,
                    passes: value.passes,
                    playTheBallTotal: value.playTheBallTotal,
                    playTheBallAverageSpeed: value.playTheBallAverageSpeed,
                    penalties: value.penalties,
                    points: value.points,
                    penaltyGoals: value.penaltyGoals,
                    postContactMetres: value.postContactMetres,
                    receipts: value.receipts,
                    ruckInfringements: value.ruckInfringements,
                    sendOffs: value.sendOffs,
                    sinBins: value.sinBins,
                    stintOne: value.stintOne,
                    tackleBreaks: value.tackleBreaks,
                    tackleEfficiency: value.tackleEfficiency,
                    tacklesMade: value.tacklesMade,
                    tries: value.tries,
                    tryAssists: value.tryAssists,
                    twentyFortyKicks: value.twentyFortyKicks
                )
            )
        }
        
        
        return stats
    }
}
