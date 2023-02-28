//
//  myoffcutsViewController.swift
//  ExampleOfiOSLiDAR
//
//  Created by mac on 26/02/2023.
//

import UIKit

class myoffcutsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var headerLabel : UILabel!
    @IBOutlet weak var tableView : UITableView!

    @IBOutlet weak var addBtnOutlet: UIButton!
    @IBOutlet weak var moreBtnOutlet: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    var count : Int  = 0
    
    var urls : [URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        // Do any additional setup after loading the view.

        tableView.delegate = self
        tableView.dataSource = self
        
        moreBtnOutlet.addTarget(self, action: #selector(actionOnAdd(_:)), for: .touchUpInside)
        addBtnOutlet.addTarget(self, action: #selector(actionOnBack(_:)), for: .touchUpInside)
        
        self.count = urls.count
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.tableView.backgroundColor = .clear
        
        
        let height = addBtnOutlet.bounds.height
        self.addBtnOutlet.layer.cornerRadius = height/2
        
        self.moreBtnOutlet.layer.cornerRadius = 10

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        headerLabel.textColor = .black
        view.bringSubviewToFront(headerLabel)
        view.bringSubviewToFront(tableView)
        view.bringSubviewToFront(addBtnOutlet)
        view.bringSubviewToFront(moreBtnOutlet)
      
    }
    
    let viewModel = MenuItemsViewModel()

    
    @objc func actionOnBack(_ sender : UIButton){
        
        
        let storyboard = UIStoryboard(name: "Export", bundle: nil)
        let vc =  storyboard.instantiateViewController(withIdentifier: "PartScanViewController")

        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .crossDissolve
        UIApplication.shared.setRootVC(nav)
        
    }

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urls.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MenuItemCell
        
        let item = viewModel.item(row: indexPath.row)
        cell.update(item: item)
        cell.bgView.layer.cornerRadius = 10
         let obj = self.urls[indexPath.row]
         cell.showScannedObj(url: obj)
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = viewModel.viewController(row: indexPath.row)
//
//        navigationController?.pushViewController(vc, animated: true)
//
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @objc func actionOnAdd(_ sender : UIButton){
        
        let storyboard = UIStoryboard(name: "Export", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductRecommendViewController") as! ProductRecommendViewController
        vc.count = self.count
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}


extension UIApplication {
    
    func setRootVC(_ vc : UIViewController){
        
        self.windows.first?.rootViewController = vc
        self.windows.first?.makeKeyAndVisible()
        
    }
}



