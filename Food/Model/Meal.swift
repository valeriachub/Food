//
//  Meal.swift
//  Food
//
//  Created by Valeria on 20.08.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

class Meal {
    
    var name : String
    var photo : UIImage?
    var rating : Int
    
    //MARK: - Initialization
    
    init?(name : String, photo : UIImage?, rating : Int) {
        guard !name.isEmpty else {
            return nil
        }
        
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    
    
}
