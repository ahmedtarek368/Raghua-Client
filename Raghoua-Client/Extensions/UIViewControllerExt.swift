//
//  UIViewControllerExt.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 12/10/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    
}
