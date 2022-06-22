//
//  LeagueViewController.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

import UIKit

class LeagueViewController: UIViewController {
    
    let presenter: LeaguePresenter
    
    init(presenter: LeaguePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pickerToolbar: UIToolbar?
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Seasons"
        textField.textAlignment = .center
        textField.delegate = self
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 15)
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var dataPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.isHidden = false
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
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
        presenter.fetchData()
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        presenter.setViewDelegate(delegate: self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ImageTitleTableViewCell.self,
                           forCellReuseIdentifier: ImageTitleTableViewCell.identifier)
        tableView.register(StatsSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "\(StatsSectionHeaderView.self)")
        [textField, tableView, activityIndicator].forEach {
            view.addSubview($0)
        }
        setConstraints()
    }
    
    func addPicker() {
        textField.inputView = dataPicker
        createUIToolBar()
    }
    
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func getStatItems(at indexPath: IndexPath) -> [String] {
        var items: [String] = []
        for index in 0...5 {
            items.append("\(String(describing: presenter.standings?[indexPath.row].stats?[index].value ?? 0))")
        }
        return items
    }
    
    func getStatTitles(at indexPath: IndexPath) -> [String] {
        var items: [String] = []
        for index in 0...5 {
            items.append(presenter.standings?[indexPath.row].stats?[index].abbreviation ?? "")
        }
        return items
    }
    
    func createUIToolBar() {
        pickerToolbar = UIToolbar()
        pickerToolbar?.autoresizingMask = .flexibleHeight
        pickerToolbar?.barStyle = .default
        pickerToolbar?.barTintColor = .white
        pickerToolbar?.backgroundColor = .white
        pickerToolbar?.isTranslucent = false
        
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancelTap))
        cancel.tintColor = .black
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneTap))
        done.tintColor = .black
        
        pickerToolbar?.items = [cancel, flexSpace, done]
        textField.inputAccessoryView = self.pickerToolbar
    }
    
    @objc func onCancelTap() {
        textField.endEditing(true)
    }
    
    @objc func onDoneTap() {
        textField.endEditing(true)
        textField.resignFirstResponder()
        guard presenter.year != presenter.selectedSeasonYear else { return }
        presenter.fetchData()
    }
}

extension LeagueViewController: LeaguePresenterDelegate {
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

extension LeagueViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.seasons?.count ?? 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.seasons?[row].displayName ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter.selectedSeasonYear = presenter.seasons?[row].year ?? 0
        textField.text = presenter.seasons?[row].displayName ?? ""
    }
}

extension LeagueViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = StatsSectionHeaderView()
        view.configure(item: .init(items: getStatTitles(at: IndexPath(row: 0, section: 0))))
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.standings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTitleTableViewCell.identifier, for: indexPath) as? ImageTitleTableViewCell else { return UITableViewCell() }
        let items = presenter.standings?[indexPath.item]
        
        cell.configure(item: .init(image: items?.team?.logos?.first?.href ?? "", titleLabel: items?.team?.shortDisplayName ?? "", items: getStatItems(at: indexPath)))
        return cell
    }
}

extension LeagueViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addPicker()
    }
}
