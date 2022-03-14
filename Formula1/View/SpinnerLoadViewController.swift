//
//  SpinnerLoadViewController.swift
//  Formula1
//
//  Created by Usr_Prime on 14/03/22.
//

import UIKit

class SpinnerLoadViewController: UIViewController {

    var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 100, alpha: 0.9)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
