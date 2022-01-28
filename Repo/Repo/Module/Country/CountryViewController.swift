//
//  ViewController.swift
//  Repo
//
//  Created by Kevin Singh on 15/11/2020.
//

import UIKit
import Stevia

final class CountryViewController: BaseViewController<CountryViewModel> {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CountryTableViewCell.self)
        tableView.register(CurrenciesTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        tableView.separatorStyle = .none
        return tableView
    }()
    
    weak var delegate: CountryViewControllerDelegate?
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        return refreshControl
    }()
        
    override func loadView() {
        super.loadView()
        view.sv(tableView)
        tableView.fillContainer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        /// code for testing only
        viewModel.countryAction.execute("sk")
    }
    
    override func bind() {
        super.bind()
        bindAction()
    }
    
    // MARK: - SET STYLE
    override func setStyle() {
        super.setStyle()
        setDefaultAttributesFor(style: .repoApp, for: self, title: Localizable.countryNavigationTitle())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Localizable.countryNavigationButtonUpdate(), style: .plain, target: self, action: #selector(updateTapped))
    }
    
    @objc
    private func updateTapped() {
        /// Czech code
        viewModel.countryAction.execute("cz")
    }
}

extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .white
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier) as? CountryTableViewCell, let country = viewModel.country.value.first else { return cell }
            cell.set(country: country)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrenciesTableViewCell.identifier) as? CurrenciesTableViewCell, let currencies = viewModel.country.value.first else { return cell }
            if let currencies = currencies.currencies.first?.value {
                cell.set(data: currencies)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = TableHeaderView()
        header.titleLabel.style(LabelStyle.regular14Black)
        switch section {
        case 0:
            header.titleLabel.text(Localizable.countryGeneralTitle().uppercased())
        case 1:
            header.titleLabel.text(Localizable.countryCurrenciesTitle().uppercased())
        default:
            return nil
        }
        return header
    }
}

extension CountryViewController {
    func bindAction() {
        viewModel
            .country
            .asDriver()
            .drive(onNext: { [weak self] (country) in
                guard let _ = country.first else { return }
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel
            .isExecuting
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .asDriver()
            .drive(onNext: { [weak self] () in
                /// India code
                self?.viewModel.countryAction.execute("in")
            }).disposed(by: disposeBag)
        
        viewModel
            .error
            .asDriver()
            .drive(onNext: { [weak self] (error) in
                guard let _ = error else { return }
                self?.delegate?.countryViewControllerDelegateShowError()
            })
            .disposed(by: disposeBag)
    }
}
