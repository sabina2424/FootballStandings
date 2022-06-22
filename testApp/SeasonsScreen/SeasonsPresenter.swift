//
//  SeasonsPresenter.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

import Foundation

protocol SeasonsPresenterDelegate: AnyObject {
    func showLoadedData()
    func showErrorAlert(error: NetworkError?)
}

class SeasonsPresenter {
    
    let service: FootballStandingsNetworkServiceProtocol
    weak var delegate: SeasonsPresenterDelegate?
    var seasons: [Season]?
    let id: String?
    let logo: String?
    
    init(service: FootballStandingsNetworkServiceProtocol = FootballStandingsNetworkService(),
         id: String? = nil,
         logo: String? = nil) {
        self.service = service
        self.id = id
        self.logo = logo
    }
    
    func setViewDelegate(delegate: SeasonsPresenterDelegate?){
            self.delegate = delegate
        }
    
   func fetchData() {
       service.getSeasons(id: id ?? "") { [weak self] result in
           guard let self = self else { return }
           switch result {
           case .success(let response):
               self.seasons = response.data?.seasons
               self.delegate?.showLoadedData()
               print("response", response)
           case .failure(let error):
               self.delegate?.showErrorAlert(error: error)
           }
       }
    }
}
