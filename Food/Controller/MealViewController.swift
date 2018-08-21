//
//  ViewController.swift
//  Food
//
//  Created by Valeria on 18.08.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var mealTextField: UITextField!
    @IBOutlet weak var mealPicture: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal : Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealTextField.delegate = self
        updateSaveBittonState()
    }
    
    //MARK: - TextView Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignTextViewBeResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateSaveBittonState()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveBittonState()
        navigationItem.title = mealTextField.text
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
    
    //MARK: - Private Methods
    
    private func dismissImagePicker(){
        dismiss(animated: true, completion: nil)
    }
    
    private func resignTextViewBeResponder(){
        mealTextField.resignFirstResponder()
    }
    
    private func updateSaveBittonState(){
        let title = mealTextField.text ?? ""
        saveButton.isEnabled = !title.isEmpty
    }
    
    //MARK: - Navigation
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log : OSLog.default, type: .debug)
            return
        }
        
        let name = mealTextField.text ?? ""
        let picture = mealPicture.image
        let rating = ratingControl.rating
        
        meal = Meal(name: name, photo: picture, rating: rating)
        
    }
}

