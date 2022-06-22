//
//  FootballStandingsServices.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

import Foundation

protocol  FootballStandingsNetworkServiceProtocol {
    func getFootballStandings(completion: @escaping (Result<NetworkResponse<[Standing]>, NetworkError>) -> Void)
    func getSeasons(id: String, completion: @escaping (Result<NetworkResponse<Seasons>, NetworkError>) -> Void)
    func getLeagues(id: String, season: Int, sort: String, completion: @escaping (Result<NetworkResponse<LeagueModel>, NetworkError>) -> Void)
}

class FootballStandingsNetworkService: FootballStandingsNetworkServiceProtocol {
    
    let service: NetworkManager
    
    init(service: NetworkManager = NetworkManager()) {
        self.service = service
    }
    
    func getFootballStandings(completion: @escaping (Result<NetworkResponse<[Standing]>, NetworkError>) -> Void) {
        service.request(endpoint: FootballStandingsEndPoints.getStandings, completion: completion)
    }
    
    func getSeasons(id: String, completion: @escaping (Result<NetworkResponse<Seasons>, NetworkError>) -> Void) {
        service.request(endpoint: FootballStandingsEndPoints.getSeasons(id: id), completion: completion)
    }
    
    func getLeagues(id: String, season: Int, sort: String, completion: @escaping (Result<NetworkResponse<LeagueModel>, NetworkError>) -> Void) {
        service.request(endpoint: FootballStandingsEndPoints.getLeagues(id: id, season: season, sort: sort), completion: completion)
    }
    
}
