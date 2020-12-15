//
//  ViewController.swift
//  AgendaProject
//
//  Created by Alessandro Negrão on 03/12/20.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var addGroup: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var groups: [Group] = []
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        populateGroupsArray()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupCell
        
        let group = groups[indexPath.row]
        cell.fillCellWithTitle(group.nameGroup)
        
        return cell
    }
    
    func populateGroupsArray(){
        let groupRepo = GroupRepository.shared //Singleton de novo
        if let fetchedGroups = groupRepo.fetchGroups(context: self.context){
            groups = fetchedGroups
        }else{
            groups = []
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "groupSegue" {
            if let controller = segue.destination as? AddGroupViewController {
                guard let selectedCellIndexPath = self.tableView.indexPathForSelectedRow?.row else { return }
                controller.group = self.groups[selectedCellIndexPath]
            }
        }
    }

}

