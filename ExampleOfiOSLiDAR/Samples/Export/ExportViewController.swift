//
//  ExportViewController.swift
//  ExampleOfiOSLiDAR
//
//  Created by TokyoYoshida on 2021/02/10.
//

import RealityKit
import ARKit

class ExportViewController: UIViewController, ARSessionDelegate {
    
    @IBOutlet weak var scanningLbl: UILabel!
    @IBOutlet var arView: ARView!
    @IBOutlet weak var nextBtnOutlet: UIButton!
    @IBOutlet weak var exportBtnOutlet: UIButton!
    @IBOutlet weak var backBtnOutlet: UIButton!
    
    var numberOfItems : Int!
    
    var listOfURL : [URL] = []
    
    var currentItem : Int  = 1
    
    var orientation: UIInterfaceOrientation {
        guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation else {
            fatalError()
        }
        return orientation
    }
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    lazy var imageViewSize: CGSize = {
        CGSize(width: view.bounds.size.width, height: imageViewHeight.constant)
    }()

    override func viewDidLoad() {
    
  
        arView.session.delegate = self
        super.viewDidLoad()
        initARView()
        showScanningLbl()
       
        
    }

    func showScanningLbl(item : Int = 1){
        self.scanningLbl.text = "Scaning \(item)"
    }
    
    func setARViewOptions() {
        arView.debugOptions.insert(.showSceneUnderstanding)
    }
    func buildConfigure() -> ARWorldTrackingConfiguration {
        let configuration = ARWorldTrackingConfiguration()

        configuration.environmentTexturing = .automatic
        configuration.sceneReconstruction = .meshWithClassification
        if type(of: configuration).supportsFrameSemantics(.sceneDepth) {
           configuration.frameSemantics = .sceneDepth
        }

        return configuration
    }
    func initARView() {
        setARViewOptions()
        let configuration = buildConfigure()
        arView.session.run(configuration)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    
        let height = backBtnOutlet.bounds.height
        let height_1 = exportBtnOutlet.bounds.height
        self.nextBtnOutlet.layer.cornerRadius = height/2
        self.backBtnOutlet.layer.cornerRadius =  height/2
        self.exportBtnOutlet.layer.cornerRadius =  height_1/2

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        arView.session.pause()
//        print("Dissappearing session" )

        
    }
    
    

    @IBAction func tappedExportButton(_ sender: UIButton) {
        
//
//        let storyboard = UIStoryboard(name: "Export", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "myoffcutsViewController") as! myoffcutsViewController
//        vc.modalPresentationStyle = .overFullScreen
//        self.present(UINavigationController(rootViewController: vc),animated: true,completion: nil)
//
   
        guard let camera = arView.session.currentFrame?.camera else {return}

        func convertToAsset(meshAnchors: [ARMeshAnchor]) -> MDLAsset? {
            guard let device = MTLCreateSystemDefaultDevice() else {return nil}

            let asset = MDLAsset()

            for anchor in meshAnchors {
                let mdlMesh = anchor.geometry.toMDLMesh(device: device, camera: camera, modelMatrix: anchor.transform)
                asset.add(mdlMesh)
            }

            return asset
        }
        func export(asset: MDLAsset) throws -> URL {
            let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let url = directory.appendingPathComponent("scaned.obj")

            try asset.export(to: url)

            return url
        }
        func share(url: URL) {
        
            if numberOfItems > 1{
                self.listOfURL.append(url)
                numberOfItems -= 1
                currentItem += 1
                arView.session.pause()
                self.showScanningLbl(item: currentItem)
                print(self.listOfURL)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.initARView()
                })
            }else{
                self.listOfURL.append(url)
                let storyboard = UIStoryboard(name: "Export", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "myoffcutsViewController") as! myoffcutsViewController
                vc.modalPresentationStyle = .overFullScreen
                vc.urls = listOfURL
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav,animated: true,completion: nil)
                
                
                
            }
            
//            let vc = UIActivityViewController(activityItems: [url],applicationActivities: nil)
//            vc.popoverPresentationController?.sourceView = sender
//            self.present(vc, animated: true, completion: nil)
        }
        if let meshAnchors = arView.session.currentFrame?.anchors.compactMap({ $0 as? ARMeshAnchor }),
           let asset = convertToAsset(meshAnchors: meshAnchors) {
            do {
                let url = try export(asset: asset)
                share(url: url)
            } catch {
                print("export error")
            }
        }
    }
}
