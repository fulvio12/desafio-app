//
//  DetailsViewController.swift
//  Tabela_FIPE
//
//  Created by fgrmac on 03/04/17.
//  Copyright © 2017 fgrmac. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController : UIViewController
{
    //MARK:- Class Instances
    let obj3_Parser = Parser()
    
    var ano : String = String()
    var codigo_fipe : String = String()
    
    
    //MARK:- @IBOutlet
    @IBOutlet weak var lbl_Marca: UILabel!
    @IBOutlet weak var lbl_modelo: UILabel!
    @IBOutlet weak var lbl_Ano: UILabel!
    @IBOutlet weak var lbl_Valor: UILabel!
    
    //MARK:-
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        var path : URL!
        
        path = (fipe_url?.appendingPathComponent(codigo_fipe + "/" + ano))!
        
        //print("codigo fipe = \(String(describing: path.absoluteString))")
        
        obj3_Parser.get_data((path.absoluteString))
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(_:)), name: .reload, object: nil)

        
        //print("depois da notificacao")
        //dump(obj3_Parser.list_Carros)
        
        
    }
    
    
    //MARK:- Support Functions
    func reloadData(_ notification: Notification) {
        print("after notification")
        dump(obj3_Parser.list_Carros)
        loadLabels()
    }

    func loadLabels() {
        var valor: Float = Float()
        var txt_valor : String = String()
        
        lbl_Marca.text = obj3_Parser.list_Carros[0].marca
        lbl_modelo.text = obj3_Parser.list_Carros[0].modelo
        lbl_Ano.text = obj3_Parser.list_Carros[0].ano
        //lbl_Valor.text = String(describing: (obj3_Parser.list_Carros[0].valor))
        valor = Float(obj3_Parser.list_Carros[0].valor)
        txt_valor = valor.asLocaleCurrency
        lbl_Valor.text = String(describing: (txt_valor))
        print(txt_valor)
    }
    
}
