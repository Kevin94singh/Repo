//
//  ViewController.swift
//  Repo
//
//  Created by Kevin Singh on 15/11/2020.
//

import UIKit
import Stevia
import QExtensions

final class CountryViewController: BaseViewController<CountryViewModel> {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CountryTableViewCell.self)
        tableView.register(CurrenciesTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func loadView() {
        super.loadView()
        
        view.sv(tableView)
        tableView.fillContainer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.tintColor = .black
        bind()
        viewModel.countryAction.execute()
    }
    
    override func bind() {
        super.bind()
        bindAction()
    }
    
    // MARK:- SET STYLE
    override func setStyle() {
        super.setStyle()
        setDefaultAttributesFor(style: .repoApp, for: self, title: Localizable.countryTitle())
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
        
        switch indexPath.section {
        case 0:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier) as? CountryTableViewCell, let country = viewModel.country.value else { return UITableViewCell() }
        cell.set(country: country)
        return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrenciesTableViewCell.identifier) as? CurrenciesTableViewCell, let currencies = viewModel.country.value?.currencies.first else { return UITableViewCell() }
            cell.set(data: currencies)
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
                guard let self = self else { return }
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel
            .isExecuting
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .asDriver()
            .drive(viewModel.countryAction.inputs)
            .disposed(by: disposeBag)
        
        viewModel
            .error
            .asDriver()
            .drive(onNext: { [weak self] (error) in
                guard let self = self, let _ = error else { return }
                let errorVC = ErrorViewController(viewModel: Q.NoViewModel())
                errorVC.dismissTapped = { [weak self] in
                    self?.navigationController?.dismiss(animated: true, completion: nil)
                }
                errorVC.modalTransitionStyle = .crossDissolve
                errorVC.modalPresentationStyle = .overFullScreen
                self.navigationController?.present(errorVC, animated: true, completion: nil)
                
            })
            .disposed(by: disposeBag)
    }
}
