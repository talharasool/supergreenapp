//
//  ProductRecommendViewController.swift
//  ExampleOfiOSLiDAR
//
//  Created by mac on 27/02/2023.
//

import UIKit
import ARKit

class ProductRecommendViewController: UIViewController {
    
    @IBOutlet weak var headerLabel : UILabel!
    @IBOutlet weak var addBtnOutlet: UIButton!
    @IBOutlet weak var moreBtnOutlet: UIButton!
    @IBOutlet weak var productImgView : UIImageView!
    @IBOutlet weak var productARImgView : UIImageView!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = "Product\nRecommendation"
        productARImgView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        productARImgView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let height = addBtnOutlet.bounds.height
        self.addBtnOutlet.layer.cornerRadius = height/2
        self.moreBtnOutlet.layer.cornerRadius = 10
        
        if count  == 1{
            productImgView.image = UIImage.init(named: "pic_1")
        }else if count == 2 || count == 3{
            productImgView.image = UIImage.init(named: "pic_2")
        }else if count == 4{
            productImgView.image = UIImage.init(named: "pic_4")
            
        }
        
    }

}

extension ProductRecommendViewController{
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        
        let previewController = QLPreviewController()
        previewController.dataSource = self
        present(previewController, animated: true, completion: nil)
      
    }
}


extension ProductRecommendViewController : QLPreviewControllerDataSource {

    override func viewDidAppear(_ animated: Bool) {
 
    }

    func numberOfPreviewItems(in controller: QLPreviewController) -> Int { return 1 }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        
        if count == 1{
            guard let path = Bundle.main.path(forResource: "1_cutoff", ofType: "usdz") else { fatalError("Couldn't find the supported input file.") }
            let url = URL(fileURLWithPath: path)
            return url as QLPreviewItem
            
            
        } else if count == 2 {
            guard let path = Bundle.main.path(forResource: "2_3cutoff", ofType: "usdz") else { fatalError("Couldn't find the supported input file.") }
            let url = URL(fileURLWithPath: path)
            return url as QLPreviewItem
            
        }else if count == 3 {
            
            guard let path = Bundle.main.path(forResource: "2_3cutoff", ofType: "usdz") else { fatalError("Couldn't find the supported input file.") }
            let url = URL(fileURLWithPath: path)
            return url as QLPreviewItem
            
        }else if count == 4{
            guard let path = Bundle.main.path(forResource: "4_offcut", ofType: "usdz") else { fatalError("Couldn't find the supported input file.") }
            let url = URL(fileURLWithPath: path)
            return url as QLPreviewItem
        }else{
            guard let path = Bundle.main.path(forResource: "4_cut", ofType: "usdz") else { fatalError("Couldn't find the supported input file.") }
            let url = URL(fileURLWithPath: path)
            return url as QLPreviewItem
        }
      
    }
}
