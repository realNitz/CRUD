//
//  DashboardViewController.swift
//  CRUD
//
//  Created by Nitesh Parihar on 09/03/19.
//  Copyright © 2019 Nitesh Parihar. All rights reserved.
//

import UIKit

class DashTableViewCell : UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        cardView.backgroundColor = UIColor.white
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowRadius = 3
    }
    
}

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var dashTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items: [Store] = []
    var selectedIndex: Int!
    
    var filteredData: [Store] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dashTableView.separatorStyle = .none
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
    }
    
    func fetchData() {
        
        do {
            items = try context.fetch(Store.fetchRequest())
            filteredData = items
            DispatchQueue.main.async {
                self.dashTableView.reloadData()
            }
        } catch {
            print("Couldn't Fetch Data")
        }
        
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "addSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DashTableViewCell
        cell.selectionStyle = .none
        cell.nameLbl.text = filteredData[indexPath.row].name
        cell.addressLbl.text = filteredData[indexPath.row].address
        cell.emailLbl.text = filteredData[indexPath.row].email
        cell.mobileLbl.text = filteredData[indexPath.row].mobile
        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            
            let item = self.filteredData[indexPath.row]
            self.context.delete(item)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            self.filteredData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
        let share = UITableViewRowAction(style: .default, title: "Update") { (action, indexPath) in
            
            self.selectedIndex = indexPath.row
            
            self.performSegue(withIdentifier: "updateSegue", sender: self)
            
        }
        
        delete.backgroundColor = UIColor(red: 54/255, green: 215/255, blue: 183/255, alpha: 1.0)
        share.backgroundColor = UIColor(red: 0/255, green: 177/255, blue: 106/255, alpha: 1.0)
        
        
        return [delete,share]
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateSegue" {
            let updateVC = segue.destination as! UpdateViewController
            updateVC.item = filteredData[selectedIndex!]
        }
    }
    
}
