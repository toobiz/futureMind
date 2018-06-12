//
//  PrototypeCell.swift
//  FutureMind
//
//  Created by Michal Tubis on 12.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import UIKit
import RxSwift

class PrototypeCell: UITableViewCell {

    static let reuseIdentifier = "prototypeCell"
    var viewModel: PrototypeCellViewModel!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    func setup(withViewModel viewModel: PrototypeCellViewModel) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.item?.title
        self.descriptionLabel.text = viewModel.item?.desc
        self.dateLabel.text = viewModel.item?.modificationDate
        
        setupBinding()
        viewModel.getImage()
    }
    
    func setupBinding() {
        viewModel.loadingSuccess.subscribe(onNext: { [unowned self] _ in
            print("Loading image success")
            self.itemImage.image = self.viewModel.image
        }).disposed(by: disposeBag)
    }
}
