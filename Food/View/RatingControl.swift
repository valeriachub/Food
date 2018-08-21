//
//  RatingControl.swift
//  Food
//
//  Created by Valeria on 19.08.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet{
            updateButtonSelectionState()
        }
    }
    
    //MARK: - Properties
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: - Private Methods
    
    private func setupButtons(){
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let filledStarImage = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStarImage = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStarImage = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount{
            let button = UIButton()
            
            button.setImage(emptyStarImage, for: .normal)
            button.setImage(filledStarImage, for: .selected)
            button.setImage(highlightedStarImage, for: .highlighted)
            button.setImage(highlightedStarImage, for: [.selected, .highlighted])
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //Accessibility Settings
            button.accessibilityLabel = "Set \(index+1) star rating"
            
            button.addTarget(self, action: #selector(ratingButtonPressed(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            
            ratingButtons.append(button)
        }
    }
    
    //MARK: - Button Action
    
    @objc func ratingButtonPressed(button : UIButton){
        guard let index = ratingButtons.index(of: button) else {
              fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        let selectedRating = index + 1
        if selectedRating == rating {
            rating = 0
        }else{
            rating = selectedRating
        }
    }
    
    private func updateButtonSelectionState(){
        for(index, button) in ratingButtons.enumerated(){
            //* * * * *
            //selected Button =
            //index 1
            //rating 2
            
            button.isSelected = index < rating
            
            let accessibilityHint : String?
            if rating == index + 1 {
                accessibilityHint = "Tap to reset the rating to zero."
            }else{
                accessibilityHint = nil
            }
            
            let accessibilityValue : String
            switch (rating){
            case 0 : accessibilityValue = "No rating set."
            case 1 : accessibilityValue = "1 star set."
            default : accessibilityValue = "\(rating) stars set."
            }
            
            button.accessibilityHint = accessibilityHint
            button.accessibilityValue = accessibilityValue
        }
    }
}
