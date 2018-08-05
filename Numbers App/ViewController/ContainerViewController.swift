//
//  ContainerViewController.swift
//  Numbers App
//
//  Created by Mac on 8/5/18.
//  Copyright © 2018 C0dimus. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        performOverrideTraitCollection()
    }
    
    private func performOverrideTraitCollection() {
        for childVC in self.childViewControllers {
            setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: .compact), forChildViewController: childVC)
        }
    }

}
