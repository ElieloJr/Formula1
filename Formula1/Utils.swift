//
//  Utils.swift
//  Formula1
//
//  Created by Usr_Prime on 10/03/22.
//

import Foundation
import UIKit

class Utils {
    static func convertDate(data: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let oldDate = dateFormat.date(from: data)
        let convertData = DateFormatter()
        convertData.dateFormat = "dd/MM/yyyy"
        return convertData.string(from: oldDate!)
    }
//    func createSpinnerView(_ view: UIViewController) {
//        let child = SpinnerLoadViewController()
//
//        // add the spinner view controller
//        addChild(child)
//        child.view.frame = view.frame
//        view.addSubview(child.view)
//        child.didMove(toParent: self)
//
//        // wait two seconds to simulate some work happening
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            // then remove the spinner view controller
//            child.willMove(toParent: nil)
//            child.view.removeFromSuperview()
//            child.removeFromParent()
//        }
//    }
}
