//
//  LocationDetailsVC.swift
//  CoreDataExample
//
//  Created by Ahmet Mucahid Bozkurt on 2.05.2022.
//

import UIKit
import CoreData

class LocationDetailsVC: UIViewController {

    @IBOutlet private weak var imgCity: UIImageView!
    @IBOutlet private weak var lblCity: UITextField!
    @IBOutlet private weak var lblYear: UITextField!
    @IBOutlet private weak var lblFoodName: UITextField!
    @IBOutlet private weak var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recognizeTapGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    private func recognizeTapGestures() {
        // TODO: hide keyboard when clicked anywhere on screen
        let viewTapped = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(viewTapped)
        
        // TODO: select image in phone gallery
        let imageTapped = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imgCity.addGestureRecognizer(imageTapped)
    }
    
    private func setupUI() {
        imgCity.layer.borderWidth = 1.0
        imgCity.layer.cornerRadius = 10.0
        imgCity.layer.borderColor = UIColor.systemGray4.cgColor
        btnSave.layer.cornerRadius = 5.0
    }
    
    @objc private func selectImage() {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = .photoLibrary
        present(imgPicker, animated: true, completion: nil)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction private func btnSaveClicked(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newLocation = NSEntityDescription.insertNewObject(forEntityName: "Locations", into: context)
        
        setValues(newLocation: newLocation)
        saveValues(context: context)
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setValues(newLocation: NSManagedObject) {
        newLocation.setValue(UUID(), forKey: Attributes.id.rawValue)
        newLocation.setValue(lblCity.text, forKey: Attributes.cityName.rawValue)
        newLocation.setValue(lblFoodName.text, forKey: Attributes.foodName.rawValue)
        
        // TODO: Convert string to integer and set year value.
        if let year = Int(lblYear.text!) {
            newLocation.setValue(year, forKey: Attributes.year.rawValue)
        }
        
        // TODO: Convert image to data and set image value.
        let data = imgCity.image?.jpegData(compressionQuality: 0.5)
        newLocation.setValue(data, forKey: Attributes.image.rawValue)
    }
    
    private func saveValues(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("New location was successfully saved.")
        } catch {
            print("ERROR: New location could not be saved!")
        }
    }
    
}

extension LocationDetailsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgCity.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
}
