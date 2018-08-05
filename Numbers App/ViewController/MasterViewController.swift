//
//  MasterViewController.swift
//  Numbers App
//
//  Created by Mac on 8/4/18.
//  Copyright © 2018 C0dimus. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    private var masterViewModel: MasterViewModel!
    private var selectedRow = 0
    private var detailVC: DetailViewController? {
        let splitVC = self.parent?.parent as! NASplitViewController
        let splitChildren = splitVC.childViewControllers
        let detailNavigationController = splitChildren.last as? UINavigationController
        return detailNavigationController?.topViewController as? DetailViewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        masterViewModel = MasterViewModel(delegate: self)
        self.tableView.register(UINib(nibName: NAModelCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: NAModelCell.cellId)
    }
    
    //MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAModelCell.cellId, for: indexPath) as! NAModelCell
        let model = masterViewModel.models[indexPath.row]
        let isSelected = selectedRow == indexPath.row
        cell.fillWith(model: model, isSelected: isSelected)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return masterViewModel.models.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousSelectedIndexPath = IndexPath(row: selectedRow, section: 0)
        selectedRow = indexPath.row
        tableView.reloadRows(at: [previousSelectedIndexPath, indexPath], with: .none)
        if NASplitViewController.shouldSplitViewControllers {
            performSegue(withIdentifier: "MasterToDetailSegue", sender: nil)
        }
        detailVC?.model = masterViewModel.models[selectedRow]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MasterToDetailSegue" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.model = masterViewModel.models[selectedRow]
        }
    }

}

extension MasterViewController: MasterViewModelDelegate {
    func onModelsUpdateSuccess() {
        self.tableView.reloadData()
        self.detailVC?.model = self.masterViewModel.models.first
    }
    
    func onModelsUpdateFail() {
        let alert = UIAlertController(title: "Error".localized, message: "DownloadDataError".localized, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry".localized, style: .default) { (alert) in
            self.masterViewModel.sendModelsRequest()
        }
        alert.addAction(retryAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

}

