//
//  ErrorViewController.swift
//  Repo
//
//  Created by Kevin Singh on 23.11.2020.
//

import UIKit
import Stevia

final class ErrorViewController: BaseViewController<NoViewModel> {
    
    // MARK: - Variables
    
    var dismissTapped: (() -> Void)?
    
    private lazy var dismissButton: AnimatedButton = {
        let dismissButton = AnimatedButton()
        dismissButton.setTitle(Localizable.errorSampleButton(), for: .normal)
        dismissButton.backgroundColor = .red
        dismissButton.tintColor = .blue
        return dismissButton
    }()
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        
        let backgroundView = UIView()
        backgroundView.style(ViewStyle.roundedWithShadow)
        
        let blurredBackgroundView = UIVisualEffectView()
        blurredBackgroundView.frame = view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        blurredBackgroundView.alpha = 0.7
        view.addSubview(blurredBackgroundView)
        
        let titleLabel = UILabel()
        titleLabel.text(Localizable.errorSampleTitle()).style(LabelStyle.bold24Center)
        let subtitleLabel = UILabel()
        subtitleLabel.text(Localizable.errorSampleDescription()).style(LabelStyle.regular16Center)
        let imageView = UIImageView(image: Images.error())
        imageView.contentMode = .scaleAspectFit
        
        view.sv(
            backgroundView.sv(
                titleLabel,
                subtitleLabel,
                imageView,
                dismissButton
            )
        )
        
        backgroundView.centerInContainer()
        backgroundView.width(90%)
        
        backgroundView.layout(
            20,
            |-40-imageView.height(80).centerHorizontally()-40-|,
            17,
            |-35-titleLabel-35-|,
            10,
            |-27-subtitleLabel.centerHorizontally()-27-|,
            50,
            |-27-dismissButton.height(50)-27-|,
            20
        )
    }
    
    override func bind() {
        super.bind()
        bindAction()
    }
    
}

extension ErrorViewController {
    func bindAction() {
        dismissButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.dismissTapped?()
            }).disposed(by: disposeBag)
    }
}
