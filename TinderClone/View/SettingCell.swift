//
//  SettingCell.swift
//  TinderClone
//
//  Created by Rizaldi Nur Muhammad on 19/07/20.
//  Copyright © 2020 Rizaldi. All rights reserved.
//

import UIKit

protocol SettingCellDelegate: class {
    func settingCell(_ cell: SettingCell, wantsToUpdateUserWith value: String, for section: SettingsSection)
}

class SettingCell: UITableViewCell {
    
    //MARK: - Properties
    
    weak var delegate: SettingCellDelegate?
    
    var viewModel: SettingsViewModel! {
        didSet { configure() }
    }
    
    lazy var inputField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 50, width: 28)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        tf.addTarget(self, action: #selector(handleUpdateUserInfo), for: .editingDidEnd)
        
        return tf
    }()
    
    var sliderStack = UIStackView()
    
    let minAgeLabel = UILabel()
    let maxAgeLable = UILabel()
    
    lazy var minAgeSlider = createAgeRangeSlider()
    lazy var maxAgeSlider = createAgeRangeSlider()
    
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        minAgeLabel.text = "Min: 18"
        maxAgeLable.text = "Max: 60"
        
        addSubview(inputField)
        inputField.fillSuperview()
        
        let minStack = UIStackView(arrangedSubviews: [minAgeLabel, minAgeSlider])
        minStack.spacing = 24
        
        let maxStack = UIStackView(arrangedSubviews: [maxAgeLable, maxAgeSlider])
        maxStack.spacing = 24
        
        sliderStack = UIStackView(arrangedSubviews: [minStack, maxStack])
        sliderStack.axis = .vertical
        sliderStack.spacing = 16
        
        addSubview(sliderStack)
        sliderStack.centerY(inView: self)
        sliderStack.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 24, paddingRight: 24)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handleValueChange(){
        
    }
    
    @objc func handleUpdateUserInfo(sender: UITextField){
        guard let value = sender.text else {return}
        delegate?.settingCell(self, wantsToUpdateUserWith: value, for: viewModel.section)
    }
    
    //MARK: - Helpers
    
    func configure(){
        inputField.isHidden = viewModel.shouldHideInputField
        sliderStack.isHidden = viewModel.shouldHideSlider
        
        inputField.placeholder = viewModel.placeholderText
        inputField.text = viewModel.value
    }
    
    func createAgeRangeSlider() -> UISlider{
        let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 60
        slider.addTarget(self, action: #selector(handleValueChange), for: .valueChanged)
        return slider
    }
}
