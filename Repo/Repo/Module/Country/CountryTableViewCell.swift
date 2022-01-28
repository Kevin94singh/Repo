//
//  HomeTableViewCell.swift
//  Repo
//
//  Created by Kevin Singh on 22.11.2020.
//

import UIKit
import Stevia

final class CountryTableViewCell: UITableViewCell {
    private lazy var countryValueLabel: UILabel = {
        let label = UILabel().style(LabelStyle.regular12Right)
        return label
    }()
    
    private lazy var capitalValueLabel: UILabel = {
        let label = UILabel().style(LabelStyle.regular12Right)
        return label
    }()
    
    private lazy var regionValueLabel: UILabel = {
        let label = UILabel().style(LabelStyle.regular12Right)
        return label
    }()
    
    private lazy var subregionValueLabel: UILabel = {
        let label = UILabel().style(LabelStyle.regular12Right)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        let bgView = UIView()
        bgView.style(ViewStyle.roundedWithShadow)
        
        let countryLabel = UILabel()
        countryLabel.text(Localizable.countryTitle()).style(LabelStyle.regular12LeftBlack80)
        
        let capitalLabel = UILabel()
        capitalLabel.text(Localizable.countryCapital()).style(LabelStyle.regular12LeftBlack80)
        
        let regionLabel = UILabel()
        regionLabel.text(Localizable.countryRegion()).style(LabelStyle.regular12LeftBlack80)
        
        let subregionLabel = UILabel()
        subregionLabel.text(Localizable.countrySubregion()).style(LabelStyle.regular12LeftBlack80)
        
        sv(
            bgView.sv(
                countryLabel,
                countryValueLabel,
                capitalLabel,
                capitalValueLabel,
                regionLabel,
                regionValueLabel,
                subregionLabel,
                subregionValueLabel
            )
        )
        
        layout(
            10,
            |-15-bgView-15-|,
            10
        )
        
        bgView.layout(
            10,
            |-20-countryLabel-(>=20)-countryValueLabel-20-|,
            10,
            |-20-capitalLabel-(>=20)-capitalValueLabel-20-|,
            10,
            |-20-regionLabel-(>=20)-regionValueLabel-20-|,
            10,
            |-20-subregionLabel-(>=20)-subregionValueLabel-20-|,
            10
        )
    }
    
    func set(country: CountryItem) {
        countryValueLabel.text(country.name.common)
        if let capital = country.capital.first {
            capitalValueLabel.text(capital)
        }
        regionValueLabel.text(country.region)
        subregionValueLabel.text(country.subregion)
    }
}
