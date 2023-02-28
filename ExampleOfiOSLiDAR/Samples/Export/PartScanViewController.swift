//
//  PartScanViewController.swift
//  ExampleOfiOSLiDAR
//
//  Created by mac on 28/02/2023.
//

import UIKit

class PartScanViewController: UIViewController {

    @IBOutlet weak var nextBtnOutlet: UIButton!
    @IBOutlet weak var partsTxtFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtnOutlet.addTarget(self, action: #selector(actionOnNextButton(_:)), for: .touchUpInside)
        partsTxtFiled.keyboardType = .numberPad

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let height = nextBtnOutlet.bounds.height
        self.nextBtnOutlet.layer.cornerRadius = height/2
    
    }
    
    @objc func actionOnNextButton(_ sender : UIButton){
    
        self.view.endEditing(true)
        let myInt = Int(partsTxtFiled.text ?? "") ?? 0
        if (myInt > 0 && myInt < 5){
            
            let storyboard = UIStoryboard(name: "Export", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ExportViewController") as! ExportViewController
            vc.numberOfItems = myInt
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else{
            
            let alert = UIAlertController(title: "Alert", message: "Please enter the parts between 1 & 4", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
          
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}
