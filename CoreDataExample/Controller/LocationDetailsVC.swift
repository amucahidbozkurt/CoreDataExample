//
//  LocationDetailsVC.swift
//  CoreDataExample
//
//  Created by Ahmet Mucahid Bozkurt on 2.05.2022.
//

import UIKit

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
        
    }
    
}

extension LocationDetailsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgCity.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
}
