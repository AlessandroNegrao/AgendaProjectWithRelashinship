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
        participantTableView.reloadData()
    }
    
    func populatePeopleArray(){
        let peopleRepo = PersonRepository.shared //Singleton de novo
        if let fetchedPeople = peopleRepo.fetchPeople(){
            people = fetchedPeople
        }else{
            people = []
        }
    }
    
    @IBAction func addParticipant(_ sender: Any) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! groupCell
        
        let person = people[indexPath.row]
        cell.fillCellWithTitle(person.name, person.role)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            let deletePeople = PersonRepository.shared
            let personDeleted = people[indexPath.row]
            
            people.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
            
            deletePeople.deletePerson(person: personDeleted)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let AddParticipantVC = segue.destination as! AddParticipantViewController
        
        if segue.identifier == "editParticipant" {
            // index da celula da table view que for pressionada
            guard let selectedCellIndexPath = participantTableView.indexPathForSelectedRow else {
                return
            }
            
            let index = selectedCellIndexPath.row
            let selectedTask = people[index]
            
            AddParticipantVC.editPerson = true
            AddParticipantVC.person = selectedTask
        } else {
            AddParticipantVC.editPerson = false
        }
    }
}
