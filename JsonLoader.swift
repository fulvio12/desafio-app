//
//  JsonLoader.swift
//  JsonData
//
//  Created by fgrmac on 29/03/17.
//  Copyright © 2017 com.kaleidosstudio. All rights reserved.
//

import Foundation
import UIKit

//var fipe_url = URL(string: "http://") // Teste para verificar se há erro na url
var fipe_url = URL(string: "http://fipe-api.herokuapp.com/cars")



public class Parser {
    
    var list_Carros:[CARRO] = [CARRO]()
    
    struct CARRO
    {
        
        var marca = ""
        var modelo = ""
        var codigo_fipe = ""
        var ano = ""
        //var valor = ""
        var valor = 0
        
        //init (_ marca: String, _ modelo: String, _ codigo_fipe: String, _ ano: String, _ valor: String)
        init (_ marca: String, _ modelo: String, _ codigo_fipe: String, _ ano: String, _ valor: Int)
        {
            self.marca = marca
            self.modelo = modelo
            self.codigo_fipe = codigo_fipe
            self.ano = ano
            self.valor = valor
        }
    }
    
    func get_data(_ link:String)
    {
        let url:URL = URL(string: link)!
        let session = URLSession.shared
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            self.extract_data(data)
            
        })
        
        task.resume()
        
                
    }
    
    
    func extract_data(_ data:Data?)
    {
        let json:Any?
        
        if(data == nil)
        {
            displayAlertWithMessage(title: "URL não encontrada", message: "Não foi possível extrair os dados da URL")
            return
        }
        
        
        
        do{
            json = try JSONSerialization.jsonObject(with: data!, options: [])
        }
        catch
        {
            displayAlertWithMessage(title: "Erro", message: "Não foi possível extrair os dados da URL") {
                if let rootVC = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                    rootVC.popViewController(animated: true)
                }
            }
            return
        }
        
        guard let data_array = json as? NSArray else
        {
            return
        }
        
        
        
        
        for i in 0 ..< data_array.count
        {
            if let data_object = data_array[i] as? NSDictionary
            {
                
                let marca = data_object["marca"] as? String ?? ""
                let modelo = data_object["modelo"] as? String ?? ""
                let codigo_fipe = data_object["codigo_fipe"] as? String ?? ""
                let ano = data_object["ano"] as? String ?? ""
                let valor = data_object["valor"] as? Int ?? 0
                //let valor = data_object["valor"] as? String ?? ""
                
                                
                //list_Carros.append(CARRO(marca,modelo,codigo_fipe,ano,String(describing: valor)))
                list_Carros.append(CARRO(marca,modelo,codigo_fipe,ano,valor))
                
                
            }
        }
        
        DispatchQueue.main.async(
            execute:
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)

        })
    }
    
}

