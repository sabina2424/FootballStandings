//
//  MainPresenter.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

import Foundation

protocol MainPresenterDelegate: AnyObject {
    func showLoadedData()
    func showErrorAlert(error: NetworkError?)
}

class MainPresenter  {
    
    let service: FootballStandingsNetworkServiceProtocol
    weak var delegate: MainPresenterDelegate?
    var response: [Standing]?
    
    init(service: FootballStandingsNetworkServiceProtocol = FootballStandingsNetworkService()) {
        self.service = service
    }
    
    func setViewDelegate(delegate: MainPresenterDelegate?){
            self.delegate = delegate
        }
    
   func fetchData() {
        service.getFootballStandings { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.response = response.data
                self.delegate?.showLoadedData()
            case .failure(let error):
                self.delegate?.showErrorAlert(error: error)
            }
        }
    }
}
