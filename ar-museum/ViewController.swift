//
//  ViewController.swift
//  ar-museum
//
//  Created by Gerald Soriano on 9/23/18.
//  Copyright © 2018 Gerald Soriano. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

struct ImageInformation {
    let name: String
    let description: String
    let image: UIImage
}

class ViewController: UIViewController, ARSKViewDelegate {
    @IBOutlet var sceneView: ARSKView!
    var selectedImage : ImageInformation?
    
    let images = ["sorianog" : ImageInformation(name: "Self Portriat", description: "Gerald Soriano's self portrait from LinkedIn.", image: UIImage(named: "sorianog")!)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "Test AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    
    // MARK: - ARSKViewDelegate
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        
        if let imageAnchor = anchor as? ARImageAnchor,
            let referenceImageName = imageAnchor.referenceImage.name,
            let scannedImage =  self.images[referenceImageName] {
            
            self.selectedImage = scannedImage
            
            self.performSegue(withIdentifier: "showImageInformation", sender: self)
            
            return imageSeenMarker()
        }
        
        return nil
    }
    
    private func imageSeenMarker() -> SKLabelNode {
        let labelNode = SKLabelNode(text: "🤓")
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        
        return labelNode
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImageInformation"{
            if let imageInformationVC = segue.destination as? ImageInformationViewController,
                let actualSelectedImage = selectedImage {
                imageInformationVC.imageInformation = actualSelectedImage
            }
        }
    }
}
