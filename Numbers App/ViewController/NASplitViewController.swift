//
//  NASplitViewController.swift
//  Numbers App
//
//  Created by Mac on 8/5/18.
//  Copyright © 2018 C0dimus. All rights reserved.
//

import UIKit

class NASplitViewController: UIViewController {
    private static let masterToDetailRatio: CGFloat = 1.0 / 3.0
    private static let collapseAnimationDuration = 0.5
   
    @IBOutlet weak var masterWidthConstraint: NSLayoutConstraint!
    
    private var fullscreenMasterWidth: CGFloat {
        return self.view.bounds.size.width
    }
    private var splittedMasterWidth: CGFloat {
        return self.fullscreenMasterWidth * NASplitViewController.masterToDetailRatio
    }
    static var shouldSplitViewControllers: Bool {
        return UIDevice.current.orientation.isPortrait ||
            UIScreen.main.bounds.size.width <= 667 // iPhone 6 or smaller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateMasterWidth(isAnimating: false)
    }
    
    private func updateMasterWidth(isAnimating: Bool) {
        self.masterWidthConstraint.constant = NASplitViewController.shouldSplitViewControllers ? fullscreenMasterWidth : splittedMasterWidth
        if isAnimating {
            UIView.animate(withDuration: NASplitViewController.collapseAnimationDuration, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateMasterWidth(isAnimating: true)
    }
    


}
