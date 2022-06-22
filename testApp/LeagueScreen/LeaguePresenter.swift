//
//  LeaguePresenter.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

protocol LeaguePresenterDelegate: AnyObject {
    func showLoadedData()
    func showErrorAlert(error: NetworkError?)
}

class LeaguePresenter {
    
    let service: FootballStandingsNetworkServiceProtocol
    weak var delegate: LeaguePresenterDelegate?
    var standings: [StandingResponse]?
    var seasons: [Season]?
    let id: String?
    let year: Int?
    var selectedSeasonYear: Int?
    
    init(service: FootballStandingsNetworkServiceProtocol = FootballStandingsNetworkService(),
         id: String? = nil,
         year: Int? = nil,
         seasons: [Season]? = nil
    ) {
        self.service = service
        self.id = id
        self.year = year
        self.seasons = seasons
    }
    
    func setViewDelegate(delegate: LeaguePresenterDelegate?){
            self.delegate = delegate
        }
    
   func fetchData() {
       let seasonYear = selectedSeasonYear == nil ? year : selectedSeasonYear
       service.getLeagues(id: id ?? "", season: seasonYear ?? 2020, sort: "asc", completion: { [weak self] result in
           guard let self = self else { return }
           switch result {
           case .success(let response):
               self.standings = response.data?.standings
               self.delegate?.showLoadedData()
           case .failure(let error):
               self.delegate?.showErrorAlert(error: error)
           }
       })
    }
}
