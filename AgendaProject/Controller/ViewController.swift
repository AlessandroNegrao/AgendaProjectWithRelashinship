//
//  ViewController.swift
//  AgendaProject
//
//  Created by Alessandro Negrão on 03/12/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var addGroup: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var groups: [Group] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(groups.count)
//        let paths = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
//        print("\(paths[0])")
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
//      cell.nameGroup.text = "Teste"
        cell.fillCellWithTitle(group.nameGroup)
        
        return cell
    }
    
    func populateGroupsArray(){
        let groupRepo = GroupRepository.shared //Singleton de novo
        if let fetchedGroups = groupRepo.fetchGroups(){
            groups = fetchedGroups
        }else{
            groups = []
        }
    }

}

