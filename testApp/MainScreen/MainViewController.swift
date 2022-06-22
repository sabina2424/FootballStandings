//
//  MainViewController.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorColor = .blue
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let presenter: MainPresenter
    
    init(presenter: MainPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .gray
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        presenter.fetchData()
        setupView()
        view.backgroundColor = .white
    }
    
    private func setupView() {
        self.title = "Last updates on popular football ligas"
        presenter.setViewDelegate(delegate: self)
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


extension MainViewController: MainPresenterDelegate {
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

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeftImageTitlesTableViewCell.identifier, for: indexPath) as? LeftImageTitlesTableViewCell else { return UITableViewCell() }
        let data = presenter.response?[indexPath.item]
        cell.configure(item: .init(image: data?.logos?.light ?? "", titleLabel: data?.name ?? "", subtitleLabel: data?.abbr ?? ""))
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = presenter.response?[indexPath.item]
        let vc = SeasonsViewController(presenter: SeasonsPresenter(id: data?.id ?? "", logo: data?.logos?.light ?? ""))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
