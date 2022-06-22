//
//  FootballStandingsEndPoints.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

import Foundation

enum FootballStandingsEndPoints: EndPoint {
    case getStandings
    case getSeasons(id: String)
    case getLeagues(id: String, season: Int, sort: String)
    
    var scheme: HTTPScheme {
        return .https
    }
    
    var baseURL: String {
        return "api-football-standings.azharimm.site"
    }
    
    var path: String {
        switch self {
        case .getStandings:
            return "/leagues"
        case .getSeasons(let id):
            return "/leagues/\(id)/seasons"
        case .getLeagues(let id, _, _):
            return "/leagues/\(id)/standings"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getLeagues(_, let season, let sort):
            return [URLQueryItem(name: "season", value: String(season)),
            URLQueryItem(name: "sort", value: sort)]
        default:
            return []
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getStandings, .getSeasons, .getLeagues:
            return .get
        }
    }
    
    var headers: [HTTPHeaders : String] {
        let headers: [HTTPHeaders : String] = [.contentType : "application/json"]
        return headers
        
    }
    
    var body: Data? { return nil }
}

