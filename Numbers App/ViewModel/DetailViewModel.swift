//
//  DetailViewModel.swift
//  Numbers App
//
//  Created by Mac on 8/4/18.
//  Copyright © 2018 C0dimus. All rights reserved.
//

import Foundation

protocol DetailViewModelDelegate: class {
    func onModelDownloadSuccess(_ model: NAModel)
    func onModelDownloadFail()
}

class DetailViewModel {
    private static let modelUrl = "http://dev.tapptic.com/test/json.php?name="
    
    var model: NAModel
    private weak var delegate: DetailViewModelDelegate?
    
    init(model: NAModel, delegate: DetailViewModelDelegate) {
        self.model = model
        self.delegate = delegate
        sendModelDetailRequest()
    }
    
    func sendModelDetailRequest() {
        guard let url = URL(string: DetailViewModel.modelUrl + model.name) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let jsonModel = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary else {
                self.delegate?.onModelDownloadFail()
                return
            }
            let model = NAModel(dictionary: jsonModel as! [String : Any])
            self.delegate?.onModelDownloadSuccess(model)
        }.resume()
    }
    
}
