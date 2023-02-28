//
//  MenuItemTableViewCell.swift
//  ExampleOfiOSLiDAR
//
//  Created by TokyoYoshida on 2021/01/31.
//

import UIKit
import SceneKit

class MenuItemCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bgView : UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var sceneView: SCNView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(item: MenuItem) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        //itemImageView.image = UIImage.init(named: item.prefix)
        //showScannedObj(named: item.prefix)
    }
    
    func showScannedObj(url : URL){
        
       // let scene = SCNScene(named: named)
        do {
           let documents = ""
           let scene = try SCNScene(url: url, options: nil)
            
            // 2: Add camera node
            let cameraNode = SCNNode()
            cameraNode.camera = SCNCamera()
            // 3: Place camera
            cameraNode.position = SCNVector3(x: 0, y: 10, z: 35)
            // 4: Set camera on scene
            scene.rootNode.addChildNode(cameraNode)
            
            // 5: Adding light to scene
            let lightNode = SCNNode()
            lightNode.light = SCNLight()
            lightNode.light?.type = .omni
            lightNode.position = SCNVector3(x: 0, y: 10, z: 35)
            scene.rootNode.addChildNode(lightNode)
            
            // 6: Creating and adding ambien light to scene
            let ambientLightNode = SCNNode()
            ambientLightNode.light = SCNLight()
            ambientLightNode.light?.type = .ambient
            ambientLightNode.light?.color = UIColor.darkGray
            scene.rootNode.addChildNode(ambientLightNode)
            
            // Allow user to manipulate camera
            sceneView.allowsCameraControl = true
            
            // Show FPS logs and timming
            // sceneView.showsStatistics = true
            
            // Set background color
            sceneView.backgroundColor = UIColor.white
            
            // Allow user translate image
            sceneView.cameraControlConfiguration.allowsTranslation = false
            
            // Set scene settings
            sceneView.scene = scene
            
            
        } catch {}
        
  
        
    }
}
