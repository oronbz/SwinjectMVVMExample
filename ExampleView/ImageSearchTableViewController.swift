//
//  ImageSearchTableViewController.swift
//  SwinjectMVVMExample
//
//  Created by Oron Ben Zvi on 12/19/16.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import ReactiveSwift
import ReactiveCocoa
import ExampleViewModel

public final class ImageSearchTableViewController: UITableViewController {
    private var autoSearchStarted = false
    
    public var viewModel: ImageSearchTableViewModeling? {
        didSet {
            
            if let viewModel = viewModel {
                viewModel.cellModels.producer
                    .on(value: { _ in self.tableView.reloadData() })
                    .start()
            }
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !autoSearchStarted {
            autoSearchStarted = true
            viewModel?.startSearch()
        }
    }
}

// MARK: UITableViewDataSource

extension ImageSearchTableViewController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = viewModel {
            return viewModel.cellModels.value.count
        }
        return 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageSearchTableViewCell", for: indexPath) as! ImageSearchTableViewCell
        if let viewModel = viewModel {
            cell.viewModel = viewModel.cellModels.value[indexPath.row]
        } else {
            cell.viewModel = nil
        }
        
        return cell
    }
}
