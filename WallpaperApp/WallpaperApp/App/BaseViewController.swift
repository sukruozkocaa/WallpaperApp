//
//  BaseViewController.swift
//  WallpaperApp
//
//  Created by Şükrü on 5.09.2024.
//

import UIKit

open class BaseViewController: UIViewController {

    private lazy var navBarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_appNavBar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.titleView = navBarImageView
    }
}
