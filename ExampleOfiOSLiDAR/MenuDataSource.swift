//
//  MenuDataSource.swift
//  ExampleOfiOSLiDAR
//
//  Created by TokyoYoshida on 2021/01/31.
//

import UIKit

struct MenuItem {
    let title: String
    let description: String
    let prefix: String
    
    func viewController() -> UIViewController {
        let storyboard = UIStoryboard(name: prefix, bundle: nil)
        let vc = storyboard.instantiateInitialViewController()!
        vc.title = title

        return vc
    }
}

class MenuViewModel {
    
    
    
    
    private let dataSource = [
        MenuItem (
            title: "Depth Map",
            description: "Display the depth map on the screen.",
            prefix: "DepthMap"
        ),
        MenuItem (
            title: "Confidence Map",
            description: "Display the confidence on the screen.",
            prefix: "ConfidenceMap"
        ),
        MenuItem (
            title: "Collision",
            description: "Collision detection of objects using LiDAR.",
            prefix: "Collision"
        ),
        MenuItem (
            title: "Export",
            description: "Export scaned object to .obj file.",
            prefix: "Export"
        ),
        MenuItem (
            title: "Scan with Texture",
            description: "Scan object with color texture.",
            prefix: "Scan"
        ),
        MenuItem (
            title: "Point Cloud",
            description: "Point cloud.",
            prefix: "PointCloud"
        )
    ]
    
    var count: Int {
        dataSource.count
    }
    
    func item(row: Int) -> MenuItem {
        dataSource[row]
    }
    
    func viewController(row: Int) -> UIViewController {
        dataSource[row].viewController()
    }
}

class MenuItemsViewModel {
    

    private let dataSource = [
        MenuItem (
            title: "Part 1",
            description: "Approx — 15cm x 36cm x 2cm",
            prefix: "scaned 7.obj"
        ),
        MenuItem (
            title: "Part 2",
            description: "Approx — 9cm x 46cm x 2cm",
            prefix: "scaned 7.obj"
        ),
        MenuItem (
            title: "Part 3",
            description: "Approx — 12cm x 29cm x 1.5cm",
            prefix: "scaned 7.obj"
        ),
        MenuItem (
            title: "Part 4",
            description: "Approx — 26cm x 42cm x 2cm",
            prefix: "scaned 7.obj"
        ),
        MenuItem (
            title: "Part 5",
            description: "Approx — 13cm x 32cm x 1.8cm",
            prefix: "scaned 7.obj"
        ),
    ]
    
    var count: Int {
        dataSource.count
    }
    
    func item(row: Int) -> MenuItem {
        dataSource[row]
    }
    
    func viewController(row: Int) -> UIViewController {
        dataSource[row].viewController()
    }
}
