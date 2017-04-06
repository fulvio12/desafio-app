//
//  SecondTableViewCell.swift
//  Tabela_FIPE
//
//  Created by fgrmac on 06/04/17.
//  Copyright © 2017 fgrmac. All rights reserved.
//

import UIKit

class SecondTableViewCell: UITableViewCell {

    //MARK:- @IBOutlet
    @IBOutlet weak var lbl_Modelo: UILabel!
    @IBOutlet weak var lbl_Ano: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
