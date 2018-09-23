//
//  ImageInformationViewController.swift
//  ar-museum
//
//  Created by Gerald Soriano on 9/23/18.
//  Copyright © 2018 Gerald Soriano. All rights reserved.
//

import UIKit

class ImageInformationViewController : UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    
    var imageInformation : ImageInformation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let actualImageInformation = imageInformation {
            self.nameLabel.text = actualImageInformation.name
            self.imageView.image = actualImageInformation.image
            self.descriptionText.text = actualImageInformation.description
        }
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
