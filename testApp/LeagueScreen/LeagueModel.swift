//
//  LeagueModel.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

import Foundation

struct LeagueModel: Codable {
    let name, abbreviation, seasonDisplay: String?
    let season: Int?
    let standings: [StandingResponse]?
}

struct StandingResponse: Codable {
    let team: Team?
    let note: Note?
    let stats: [Stat]?
}

struct Note: Codable {
    let color, noteDescription: String?
    let rank: Int?

    enum CodingKeys: String, CodingKey {
        case color
        case noteDescription = "description"
        case rank
    }
}

struct Stat: Codable {
    let name, displayName, shortDisplayName, statDescription: String?
    let abbreviation, type: String?
    let value: Int?
    let displayValue: String?

    enum CodingKeys: String, CodingKey {
        case name, displayName, shortDisplayName
        case statDescription = "description"
        case abbreviation, type, value, displayValue
    }
}

struct Team: Codable {
    let id, uid, location, name: String?
    let abbreviation, displayName, shortDisplayName: String?
    let isActive: Bool?
    let logos: [Logo]?
}

struct Logo: Codable {
    let href: String?
    let width, height: Int?
    let alt: String?
    let rel: [String]?
    let lastUpdated: String?
}
