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

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData()
        setupBindings()
    }
    
    func setupBindings() {
        viewModel.loadingSuccess.subscribe(onNext: { [weak self] _ in
            print("Loading success")
        }).disposed(by: disposeBag)
    }

}

