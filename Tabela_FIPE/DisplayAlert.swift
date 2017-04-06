//
//  File.swift
//  Tabela_FIPE
//
//  Created by fgrmac on 04/04/17.
//  Copyright © 2017 fgrmac. All rights reserved.
//

import Foundation
import UIKit

//func displayAlertWithMessage(title: String, message: String){
//    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
//    ac.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
//    let rootVC = UIApplication.shared.keyWindow?.rootViewController
//    rootVC?.present(ac, animated: true){}
//}


func displayAlertWithMessage(title: String, message: String, onClick:(()->())? = nil){
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    ac.addAction(UIAlertAction(title: "Ok", style: .default) { (button) in
        onClick?()
    })
    
    let rootVC = UIApplication.shared.keyWindow?.rootViewController
    rootVC?.present(ac, animated: true){}
}
