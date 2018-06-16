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
    let refreshControl = UIRefreshControl()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        viewModel.getData()
        setupBindings()
    }
    
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refreshData() {
        viewModel.refreshData()
    }
    
    func setupBindings() {
        viewModel.loadingSuccess.subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }).disposed(by: disposeBag)
        
        viewModel.isLoading.asObservable().subscribe(onNext: { [unowned self]  value in
            self.progressHUDVisible = value
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
                cellViewModel.interactor = viewModel.interactor
                prototypeCell.setup(withViewModel: cellViewModel)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let webView = storyboard?.instantiateViewController(withIdentifier: viewModel.webViewIdentifier) as! WebViewController
        let item = viewModel.items[indexPath.row]
        webView.viewModel.urlString.value = item.link
        
        navigationController?.pushViewController(webView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

