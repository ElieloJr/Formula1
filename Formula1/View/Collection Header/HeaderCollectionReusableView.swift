//
//  HeaderCollectionReusableView.swift
//  Formula1
//
//  Created by Usr_Prime on 11/03/22.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var fundoAnoView: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fundoAnoView.layer.cornerRadius = 10
        fundoAnoView.layer.shadowColor = UIColor.lightGray.cgColor
        fundoAnoView.layer.shadowOpacity = 0.8
        fundoAnoView.layer.shadowRadius = 10
    }
    func setYear(_ year: String) {
        yearLabel.text = year
    }
}
