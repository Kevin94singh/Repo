//
//  CurrenciesTableViewCell.swift
//  Repo
//
//  Created by Kevin Singh on 23.11.2020.
//

import UIKit
import Stevia

final class CurrenciesTableViewCell: UITableViewCell {
    
    private lazy var nameValueLabel: UILabel = {
        let label = UILabel().style(LabelStyle.regular12Right)
        return label
    }()

    private lazy var symbolValueLabel: UILabel = {
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
        let nameLabel = UILabel()
        nameLabel.text(Localizable.currenciesName()).style(LabelStyle.regular12LeftBlack80)
        
        let symbolLabel = UILabel()
        symbolLabel.text(Localizable.currenciesSymbol()).style(LabelStyle.regular12LeftBlack80)
        
        let bgView = UIView()
        bgView.style(ViewStyle.roundedWithShadow)
        
        sv(
            bgView.sv(
                nameLabel,
                nameValueLabel,
                symbolLabel,
                symbolValueLabel
            )
        )
        
        layout(
            10,
            |-15-bgView-15-|,
            10
        )
        
        bgView.layout(
            10,
            |-20-nameLabel-(>=20)-nameValueLabel-20-|,
            10,
            |-20-symbolLabel-(>=20)-symbolValueLabel-20-|,
            10
        )
    }
    
    func set(data: Currencies) {
        nameValueLabel.text(data.name)
        symbolValueLabel.text(data.symbol)
    }
}
