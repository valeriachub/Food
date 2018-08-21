//
//  ViewController.swift
//  Food
//
//  Created by Valeria on 18.08.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var mealTextField: UITextField!
    @IBOutlet weak var mealPicture: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealTextField.delegate = self
    }
    
    //MARK: - TextView Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignTextViewBeResponder()
        return true
    }
    
    //MARK: - Button Methods
    
    @IBAction func selectPictureFromLibrary(_ sender: UITapGestureRecognizer) {
        
        resignTextViewBeResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: - UIPickerControllerDelegate Methods
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismissImagePicker()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        mealPicture.image = selectedImage
        
        dismissImagePicker()
    }
    
    func dismissImagePicker(){
        dismiss(animated: true, completion: nil)
    }
    
    func resignTextViewBeResponder(){
        mealTextField.resignFirstResponder()
    }
}

