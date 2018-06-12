//
//  MainViewController.swift
//  FutureMind
//
//  Created by Michal Tubis on 10.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {
    
    var viewModel: MainViewModel!
    let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData()
        setupBindings()
    }
    
    func setupBindings() {
        viewModel.loadingSuccess.subscribe(onNext: { [weak self] _ in
            print("Loading success")
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PrototypeCell.reuseIdentifier, for: indexPath)
        
        if let prototypeCell = cell as? PrototypeCell {
            if viewModel.items.count > 0 {
                let item = viewModel.items[indexPath.row]
                let cellViewModel = PrototypeCellViewModel(withItem: item)
                cellViewModel.repository = viewModel.repository
                prototypeCell.setup(withViewModel: cellViewModel)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

