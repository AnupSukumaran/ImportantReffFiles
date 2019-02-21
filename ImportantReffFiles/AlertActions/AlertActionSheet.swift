//
//  AlertActionSheet.swift
//  MultiPayIntegraionTest
//
//  Created by Abraham VG on 06/02/19.
//  Copyright © 2019 TechTonic. All rights reserved.
//

import UIKit

class AlertActionSheet {
    
    static var shared = AlertActionSheet()
    let funcs = ViewControllerFuncs.shared
    //MARK:
    func alertList(mainVC: UIViewController) {
        
        let activity = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "Razor", style: .default) { (_) in
            print("Razor pay")
            self.funcs.showPaymentForm()
        }
        
        let action2 = UIAlertAction(title: "item2", style: .default) { (_) in
            print("Items2")
        }
        
        let action3 = UIAlertAction(title: "item3", style: .default) { (_) in
            print("Items3")
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        activity.addAction(action1)
        activity.addAction(action2)
        activity.addAction(action3)
        activity.addAction(cancelAction)
        mainVC.present(activity, animated: true, completion: nil)
    }
    
    
    
}
