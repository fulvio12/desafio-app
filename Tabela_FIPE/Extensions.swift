//
//  Extensions.swift
//  Tabela_FIPE
//
//  Created by fgrmac on 05/04/17.
//  Copyright © 2017 fgrmac. All rights reserved.
//

import Foundation

extension Float {
    var asLocaleCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(for: self)!
    }
}


//MARK:- Notification(reload)
extension Notification.Name {
    static let reload = Notification.Name("reload")
}
