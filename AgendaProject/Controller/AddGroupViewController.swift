//
//  AddGroupViewController.swift
//  AgendaProject
//
//  Created by Alessandro Negrão on 03/12/20.
//

import UIKit

class AddGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var imageGroup: UIImageView!
    @IBOutlet weak var editNameButton: UIButton!
    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var addParticipantButton: UIButton!
    @IBOutlet weak var chooseImageGroupButton: UIButton!
    @IBOutlet weak var participantTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text? = "Joao"
        cell.detailTextLabel?.text = "Adm"
        let person = people[indexPath.row]
        
        return cell
    }

}
