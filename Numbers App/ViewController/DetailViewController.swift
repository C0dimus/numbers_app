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
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    private var detailViewModel: DetailViewModel!
    
    var model: NAModel? {
        didSet {
            if let model = self.model {
                clearView()
                detailViewModel = DetailViewModel(model: model, delegate: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        clearView()
    }
    
    private func clearView() {
        if self.indicatorView != nil {
            self.indicatorView.startAnimating()
            self.numberLabel.text = ""
            self.textLabel.text = ""
            self.imageView.image = UIImage()
        }
    }
    
    private func updateView(model: NAModel) {
        self.indicatorView.stopAnimating()
        self.numberLabel.text = model.name
        self.textLabel.text = model.text
        self.imageView.sd_setImage(with: URL(string: model.image), completed: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            self.navigationController?.popViewController(animated: false)
        }
    }

}

extension DetailViewController: DetailViewModelDelegate {
    func onModelDownloadSuccess(_ model: NAModel) {
        DispatchQueue.main.async {
            self.updateView(model: model)
        }
    }
    
    func onModelDownloadFail() {
        let alert = UIAlertController(title: "Error".localized, message: "DownloadDataError".localized, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry".localized, style: .default) { (alert) in
            self.clearView()
            self.detailViewModel.sendModelDetailRequest()
        }
        alert.addAction(retryAction)
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

