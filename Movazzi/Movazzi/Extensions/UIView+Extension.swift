//
//  UIView+Extension.swift
//  Movazzi
//
//  Created by yeri on 2022/04/24.
//

import Foundation
import UIKit

extension UIView {

  func dropShadow(scale: Bool = true) {
      
      self.layer.borderWidth = 1
      self.layer.borderColor = UIColor.cellGray.cgColor
      self.layer.shadowColor = UIColor.borderGray.cgColor
      self.layer.shadowOpacity = 0.5
      self.layer.shadowRadius = 3.0
      self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
      
  }

    
    
}
