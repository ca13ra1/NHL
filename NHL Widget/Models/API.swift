//
//  API.swift
//  NHL
//
//  Created by cole cabral on 2021-04-06.
//

import Foundation

// schedule data
struct Schedule: Codable {
    let dates: [DateElement]
}

struct DateElement: Codable {
    let games: [Game]
}

struct Game: Codable {
    let link: String
    let teams: Team
}

struct Team: Codable {
    let away: Away
    let home: Home
}

struct Away: Codable {
    let leagueRecord: LeagueRecord
    let score: Int
}

struct Home: Codable {
    let leagueRecord: LeagueRecord
    let score: Int
}

struct LeagueRecord: Codable {
    let wins, losses, ot: Int
}

/// live data
struct Live: Codable {
    let gameData: GameData
    var liveData: LiveData
}
struct LiveData: Codable {
    let linescore: Linescore
}

struct Linescore: Codable {
    var periods: [Period]
}

struct Period: Codable {
    let home, away: PeriodAway
    let ordinalNum: String
    let num: Int
}

struct PeriodAway: Codable {
    let goals: Int?
}

struct GameData: Codable {
    let teams: GameDataTeams
    let status: Status
}

struct Status: Codable {
    let statusCode: String
}

struct GameDataTeams: Codable {
    let away: PurpleAway
    let home: PurpleHome
}

struct PurpleAway: Codable {
    let id: Int
    let abbreviation: String
    let name: String
    let teamName: String
}

struct PurpleHome: Codable {
    let id: Int
    let abbreviation: String
    let name: String
    let teamName: String
}
