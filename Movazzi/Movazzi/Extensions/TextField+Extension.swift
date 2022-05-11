//
//  TextField+Extension.swift
//  Movazzi
//
//  Created by yeri on 2022/03/22.
//

import Foundation
import UIKit

extension UITextField {

    func setUnderLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.bounds.height + 1, width: self.bounds.width, height: 0.5)
        bottomLine.backgroundColor = UIColor.black.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }

}

