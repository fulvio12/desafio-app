//
//  SecondTableViewController.swift
//  Tabela_FIPE
//
//  Created by fgrmac on 02/04/17.
//  Copyright © 2017 fgrmac. All rights reserved.
//

import Foundation
import UIKit

class SecondTableViewController: UITableViewController {
    
    //MARK:- Class Instances
    let obj2_Parser = Parser()
    var brand_chosen : String = String()
    
    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        //Call the Parser with the correct URL based on what brand is chosen
        
        //print("Brand chosen = \(brand_chosen)") // Came from the prepare for segue
        
        var path : URL!
        path = (fipe_url?.appendingPathComponent("/brand/" + brand_chosen))!
        
        //In case I need to test for checking errors
        //path = (fipe_url?.appendingPathComponent("/brand/teste/" + brand_chosen))!
        
        //print("fipe2 url = \(String(describing: path.absoluteString))")
        
        obj2_Parser.get_data((path.absoluteString))
        
        // Reload the table
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reload, object: nil)


    }
    
    
    //MARK:- Support Functions
    func reloadTableData(_ notification: Notification) {
        tableView.reloadData()
    }

    //MARK:- TableView Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return obj2_Parser.list_Carros.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as UITableViewCell

        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as! SecondTableViewCell
        

        
        //cell.textLabel?.text =  obj2_Parser.list_Carros[indexPath.row].modelo + " / " + obj2_Parser.list_Carros[indexPath.row].ano

        cell.lbl_Modelo.text =  obj2_Parser.list_Carros[indexPath.row].modelo
            
        cell.lbl_Ano.text = obj2_Parser.list_Carros[indexPath.row].ano

        return cell
    }
    
    
    //MARK:- Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
        let destViewController = segue.destination as! DetailsViewController
        
        
        destViewController.codigo_fipe = obj2_Parser.list_Carros[indexPath.row].codigo_fipe
        destViewController.ano = obj2_Parser.list_Carros[indexPath.row].ano
        
        
        //Change the Back Button of the next Table View
        let backItem = UIBarButtonItem()
        navigationItem.backBarButtonItem = backItem
        
    }
    
    
}
