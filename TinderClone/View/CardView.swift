 //
//  CardView.swift
//  TinderClone
//
//  Created by Rizaldi Nur Muhammad on 13/07/20.
//  Copyright © 2020 Rizaldi. All rights reserved.
//

import UIKit
import SDWebImage
 
 enum SwipeDirection: Int {
    case left =  -1
    case right = 1
 }
 
class CardView: UIView {
    //MARK: - Properties
    
    private let gradientLayer = CAGradientLayer()
    private let barStackView = UIStackView()
    
    private let viewModel: CardViewModel
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    private lazy var infoLabel: UILabel = {
        let label =  UILabel()
        label.numberOfLines = 2
        label.attributedText = viewModel.userInfoText

        return label
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    //MARK: - Lifecycle
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        imageView.sd_setImage(with: viewModel.imageUrl)
        
        configureGestureRecognizers()
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        configureGradientLayer()
        
        addSubview(infoLabel)
        infoLabel.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
        addSubview(infoButton)
        infoButton.setDimensions(height: 40, width: 40)
        infoButton.centerY(inView: infoLabel)
        infoButton.anchor(right: rightAnchor, paddingRight: 16)
        configureBarStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    //MARK: - Actions
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
            
        case .began:
            superview?.subviews.forEach({ $0.layer.removeAllAnimations() })
        case .changed:
            panCard(sender: sender)
        case .ended:
            resetCardPosition(sender: sender)
        default:
            break
        }
    }
    
    @objc func handleChangePhoto(sender: UITapGestureRecognizer) {
        let location = sender.location(in: nil).x
        let shouldShowNextPhoto = location > self.frame.width / 2
        
        if shouldShowNextPhoto {
            viewModel.showNextPhoto()
        } else {
            viewModel.showPreviousPhoto()
        }
        
        imageView.sd_setImage(with: viewModel.imageUrl)
        
        barStackView.arrangedSubviews.forEach({ $0.backgroundColor = .barDeselectedColor })
        barStackView.arrangedSubviews[viewModel.index].backgroundColor = .white
    }
    
    //MARK: - Helpers
    
    func panCard(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationalTransform = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransform.translatedBy(x: translation.x, y: translation.y)
    }
    
    func configureGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
    }
    
    func configureBarStackView(){
        (0..<viewModel.imageURLs.count).forEach { _ in
            let barview = UIView()
            barview.backgroundColor = .barDeselectedColor
            barStackView.addArrangedSubview(barview)
        }
        barStackView.arrangedSubviews.first?.backgroundColor = .white
        addSubview(barStackView)
        barStackView.anchor(top: topAnchor, left:leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8, height: 4)
        barStackView.spacing = 4
        barStackView.distribution = .fillEqually
    }
    
    func configureGestureRecognizers(){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangePhoto))
        addGestureRecognizer(tap)
    }
    
    func resetCardPosition(sender: UIPanGestureRecognizer){
        let direction: SwipeDirection = sender.translation(in: nil).x > 100 ? .right : .left
        let shouldDismissCard = abs(sender.translation(in: nil).x) > 100
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            
            if shouldDismissCard {
                let xTranslation = CGFloat(direction.rawValue) * 1000
                let offScreenTransform = self.transform.translatedBy(x: xTranslation, y: 0)
                self.transform = offScreenTransform
                return
            }
            
            self.transform = .identity
        }) { _ in
            if shouldDismissCard {
                self.removeFromSuperview()
            }
        }
    }
 }
