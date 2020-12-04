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
    var people: [Person] = []

        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        populatePeopleArray()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! groupCell
        
        cell.textLabel?.text? = "Joao"
        cell.detailTextLabel?.text = "Adm"
        
        let person = people[indexPath.row]
        cell.fillCellWithTitle(person.name, person.role)
        
        return cell
    }
    
    func populatePeopleArray(){
        let peopleRepo = PersonRepository.shared //Singleton de novo
        if let fetchedPeople = peopleRepo.fetchTasks(){
            people = fetchedPeople
        }else{
            people = []
        }
    }

}
