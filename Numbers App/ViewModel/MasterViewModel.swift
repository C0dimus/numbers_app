//
//  MasterViewModel.swift
//  Numbers App
//
//  Created by Mac on 8/4/18.
//  Copyright © 2018 C0dimus. All rights reserved.
//

import Foundation
protocol MasterViewModelDelegate: class {
    func onModelsUpdateSuccess()
    func onModelsUpdateFail()
}

class MasterViewModel {
    private static let modelsUrl = URL(string: "http://dev.tapptic.com/test/json.php")!
    
    var models = [NAModel]()
    private weak var delegate: MasterViewModelDelegate?
    
    init(delegate: MasterViewModelDelegate) {
        self.delegate = delegate
        sendModelsRequest()
    }
    
    func sendModelsRequest() {
        URLSession.shared.dataTask(with: MasterViewModel.modelsUrl) { (data, response, error) in
            guard let data = data,  let jsonModels = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [NSDictionary] else {
                DispatchQueue.main.async {
                    self.delegate?.onModelsUpdateFail()
                }
                return
            }
            
            jsonModels?.forEach {
                let model = NAModel(dictionary: $0 as! [String : Any])
                self.models.append(model)
            }
            
            DispatchQueue.main.async {
                self.delegate?.onModelsUpdateSuccess()
                
            }
            
        }.resume()
    }
}
