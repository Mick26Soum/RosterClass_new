//
//  DetailViewController.swift
//  RosterClass_Table_Scratch
//
//  Created by Mick Soumphonphakdy on 6/30/15.
//  Copyright (c) 2015 Mick Soum. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    //variable of type Person to hold in object passed in from table view cell
    
    var selectedPerson : Person!
    
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    // -- start of controller functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // self.firstName.text = self.selectedPerson.firstName
       // self.lastName.text = self.selectedPerson.lastName
        
        self.setupTextFields()
        
        self.imageView.image = UIImage(named: "seattle_night.jpg")
    }

    private func setupTextFields(){
        
        self.firstName.delegate = self
        self.lastName.delegate = self
        self.firstName.tag = 0
        self.lastName.tag = 0
        self.firstName.text = self.selectedPerson.firstName
        self.lastName.text = self.selectedPerson.lastName
    }
    
    //dismiss keyboard after return is triggered
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return false
    }
    
    //passing UITextField data back to tableViewController
    func textFieldDidEndEditing(textField: UITextField){
        
        if textField.tag == 0{
            self.selectedPerson.firstName = textField.text
        }
        else{
            self.selectedPerson.lastName = textField.text
        }
        
    }
    
    //ImagePicker Set Up when button is pressed
    
    @IBAction func photoButton(sender: AnyObject) {
      
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePickerController.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            self.presentViewController(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        self.imageView.image = image
        self.selectedPerson.image = image
        
        //dismiss it
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

}
