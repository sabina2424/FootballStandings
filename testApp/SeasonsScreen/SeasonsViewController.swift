//
//  SeasonsViewController.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

import UIKit

class SeasonsViewController: UIViewController {
    let presenter: SeasonsPresenter
    
    init(presenter: SeasonsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorColor = .blue
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .gray
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        setupView()
        presenter.fetchData()
    }
    
    private func setupView() {
        presenter.setViewDelegate(delegate: self)
        self.view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LeftImageTitlesTableViewCell.self,
                           forCellReuseIdentifier: LeftImageTitlesTableViewCell.identifier)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension SeasonsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.seasons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeftImageTitlesTableViewCell.identifier, for: indexPath) as? LeftImageTitlesTableViewCell else { return UITableViewCell() }
        let items = presenter.seasons?[indexPath.item]
        cell.configure(item: .init(image: presenter.logo ?? "", titleLabel: items?.displayName ?? "", subtitleLabel: "\(items?.year ?? 0)", additionalLabel: items?.onlyDate ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = presenter.seasons?[indexPath.item]
        let vc = LeagueViewController(presenter: LeaguePresenter(id: presenter.id ?? "", year: data?.year ?? 0, seasons: presenter.seasons ?? []))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SeasonsViewController: SeasonsPresenterDelegate {
    func showLoadedData() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func showErrorAlert(error: NetworkError?) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.showError(title: error?.errorDescription,
                           message: error?.failureReason,
                           buttonTitle: "Cancel") { _ in
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

