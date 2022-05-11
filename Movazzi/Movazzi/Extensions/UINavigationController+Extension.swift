//
//  UINavigationController+Extension.swift
//  Movazzi
//
//  Created by yeri on 2022/04/27.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func popViewControllerWithHandler(animated:Bool = true, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: animated)
        CATransaction.commit()
    }
    
    var previousViewController: UIViewController? {
       viewControllers.count > 1 ? viewControllers[viewControllers.count - 2] : nil
    }




}
