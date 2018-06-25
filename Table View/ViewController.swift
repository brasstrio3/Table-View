//
//  ViewController.swift
//  Table View
//
//  Created by Administrator on 6/25/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var animals: [animalList] = []
    
    struct animalList {
        var name: String
        var image: UIImage?
    }
    
    var cat = animalList(name: "Cat", image: UIImage(named: "Cat.jpg"))
    
    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        animals.append(cat)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        cell.textLabel?.text = self.animals[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            animals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {
            
        }
    }
    
    @IBAction func doAddAnimal(_ sender: Any) {
        let alertController = UIAlertController(title: "New Animal", message: "Please add your new animal below:", preferredStyle:UIAlertControllerStyle.alert)
        
        //Text Field that pops up
        alertController.addTextField(configurationHandler: {(nameField) in
            nameField.text = ""
            nameField.placeholder = "Animal Name:"
            nameField.isSecureTextEntry = false
        })
        
        //When ok is clicked
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak alertController] (_) in
            let nameField = alertController?.textFields![0]
            let name = nameField?.text
            self.animals[0].name.append(name!)
            self.tableView.reloadData()
        }))
        present(alertController, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

