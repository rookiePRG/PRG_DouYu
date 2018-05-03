//
//  BaseViewController.swift
//  DouYuZB
//
//  Created by belief on 2018/5/2.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    //MARK: -定义属性
    var contentView: UIView?
    
    //MARK: -lazy
    fileprivate lazy var animImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

extension BaseViewController {
   @objc func setupUI() {
    
        contentView?.isHidden = true
        view.addSubview(animImageView)
        animImageView.startAnimating()
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250, a: 1);
    }
    
    func loadDataFinished() {
        animImageView.stopAnimating()
        animImageView.isHidden = true
        contentView?.isHidden = false
    }
}
