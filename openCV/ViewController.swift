//
//  ViewController.swift
//  openCV
//
//  Created by Cem Comert on 14-04-18.
//  Copyright © 2018 HAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    var imagePickers:UIImagePickerController?
    var image: UIImage?

    @IBOutlet weak var inputImageView: UIImageView!
    @IBOutlet weak var outputImageView: UIImageView!
    @IBOutlet weak var openCVVersionLabel: UILabel!
    
    @IBAction func convertImageButton(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePickers?.takePicture()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImagePickerToContainerView()
        openCVVersionLabel.text = OpenCVWrapper.openCVVersion()
    }
    
    func convertImage() {
        var outputImage: UIImage
        
        //do the image manipulations
        outputImage = OpenCVWrapper.convert(toGray: image)
        outputImage = OpenCVWrapper.gaussianBlur(outputImage, kernelSize: 3)       //kernelsize must be prime number
        outputImage = OpenCVWrapper.binarizeImage(outputImage)
        
        //show the image
        outputImageView.image = outputImage
    }
    
    func addImagePickerToContainerView() {
        imagePickers = UIImagePickerController()
        if UIImagePickerController.isCameraDeviceAvailable( UIImagePickerControllerCameraDevice.front) {
            imagePickers?.delegate = self
            imagePickers?.sourceType = UIImagePickerControllerSourceType.camera
            
            //add as a childviewcontroller
            addChildViewController(imagePickers!)
            
            // Add the child's View as a subview
            self.inputImageView.addSubview((imagePickers?.view)!)
            imagePickers?.view.frame = inputImageView.bounds
            imagePickers?.allowsEditing = false
            imagePickers?.showsCameraControls = false
            imagePickers?.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            image = selectedImage
            convertImage()
        }
        dismiss(animated: true, completion: nil)
    }
}


// https://stackoverflow.com/questions/47752434/displaying-selected-image-on-screen-using-uiiamgepickercontrollerdelegate-in-swi
