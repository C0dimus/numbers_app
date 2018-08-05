//
//  DetailViewController.swift
//  Numbers App
//
//  Created by Mac on 8/4/18.
//  Copyright © 2018 C0dimus. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
   
    private var detailViewModel: DetailViewModel!
    
    var model: NAModel? {
        didSet {
            if let model = self.model {
                detailViewModel = DetailViewModel(model: model, delegate: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
//        if let model = self.model {
//            detailViewModel = DetailViewModel(model: model, delegate: self)
//        }
    }
    
    private func updateView(model: NAModel) {
        self.textLabel.text = model.text
        self.imageView.sd_setImage(with: URL(string: model.image), completed: nil)
    }

}

extension DetailViewController: DetailViewModelDelegate {
    func onModelDownloadSuccess(_ model: NAModel) {
        DispatchQueue.main.async {
            self.updateView(model: model)
        }
    }
    
    func onModelDownloadFail() {
        let alert = UIAlertController(title: "Error", message: "Unable to download data. Try again.", preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { (alert) in
            self.detailViewModel.sendModelDetailRequest()
        }
        alert.addAction(retryAction)
        present(alert, animated: true, completion: nil)
    }
    
    
}

