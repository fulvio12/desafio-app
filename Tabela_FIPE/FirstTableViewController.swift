//
//  ViewController.swift
//  Tabela_FIPE
//
//  Created by fgrmac on 02/04/17.
//  Copyright © 2017 fgrmac. All rights reserved.
//

import UIKit



class FirstTableViewController: UITableViewController {
    
    
    //MARK:- @IBAction
    @IBAction func unwindToFirstViewController(segue: UIStoryboardSegue) {}
    

    //MARK:- Class Instances
    let obj_Parser = Parser()
    
    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        //obj_Parser.get_data("http://fipe-api.herokuapp.com/cars/brand")
        //obj_Parser.get_data("http://fipe-api.herokuapp.com/cars/brand/Fiat")
        //obj_Parser.get_data("http://fipe-api.herokuapp.com/cars/001124-0/1986")
        
        
        var path : URL!
        
        path = (fipe_url?.appendingPathComponent("/brand"))!
        
        //print((fipe_url?.absoluteString)!)
        
        obj_Parser.get_data((path.absoluteString))
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reload, object: nil)

        
    }
    
    //MARK:- Support Functions
    func reloadTableData(_ notification: Notification) {
        tableView.reloadData()
    }
    
    
    
    //MARK:- TableView Functions
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return obj_Parser.list_Carros.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        
        cell.textLabel?.text = obj_Parser.list_Carros[indexPath.row].marca
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Index path será o item selecionado
        performSegue(withIdentifier: "FirstToSecondSegue", sender: indexPath)
    }
    
    
    
    //MARK:- Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
        
        guard let indexPath = sender as? NSIndexPath else {
            displayAlertWithMessage(title: "Erro", message: "Não foi possível carregar a URL")
            return
        }

        let destViewController = segue.destination as! SecondTableViewController
        
        destViewController.brand_chosen = obj_Parser.list_Carros[indexPath.row].marca
        
        
        //Change the Back Button of the next Table View
        let backItem = UIBarButtonItem()
        backItem.title = obj_Parser.list_Carros[indexPath.row].marca
        navigationItem.backBarButtonItem = backItem
    }


    //MARK:- didReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

