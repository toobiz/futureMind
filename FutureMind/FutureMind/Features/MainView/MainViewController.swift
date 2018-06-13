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
                
                prototypeCell.titleLabel.text = item.title
                prototypeCell.descriptionLabel.text = item.desc
                prototypeCell.dateLabel.text = item.modificationDate
                
//                prototypeCell.setup(withViewModel: cellViewModel)
                
                if item.image != nil {
                    prototypeCell.itemImage.image = item.image
                    print("Image retrieved from cache")
                } else {
                    prototypeCell.itemImage.image = #imageLiteral(resourceName: "placeholder")
                    viewModel.repository.getImage(imageUrl: (item.imageUrl)!).subscribe(onNext: { image in
                        if item.image != image {
                            item.image = image
                        }
                        DispatchQueue.main.async(execute: {
                            if prototypeCell.itemImage.image == #imageLiteral(resourceName: "placeholder") {
                                prototypeCell.itemImage.image = image
                            }
                        })
                    }, onError: { [unowned self] error in
                        prototypeCell.itemImage.image = #imageLiteral(resourceName: "placeholder")
                    }).disposed(by: disposeBag)
                    
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

