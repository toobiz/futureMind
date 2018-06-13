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
        
//        setupBinding()
//        viewModel.setImage()
        
        if viewModel.item?.image != nil {
            self.itemImage.image = viewModel.item?.image
            print("Image retrieved from cache")
        } else {
            self.itemImage.image = #imageLiteral(resourceName: "placeholder")
            viewModel.repository.getImage(imageUrl: (viewModel.item?.imageUrl)!).subscribe(onNext: { image in
                if self.viewModel.item?.image == nil {
                    self.viewModel.item!.image = image
                }
                DispatchQueue.main.async(execute: {
                        self.itemImage.image = image
                })
            }, onError: { [unowned self] error in
                self.itemImage.image = #imageLiteral(resourceName: "placeholder")
            }).disposed(by: disposeBag)
        }
    }
    
    func setupBinding() {
        viewModel.loadingSuccess.subscribe(onNext: { [unowned self] image in
            self.itemImage.image = image
            self.setNeedsLayout()
        }).disposed(by: disposeBag)
    }
}
