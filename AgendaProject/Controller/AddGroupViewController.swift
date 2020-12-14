//
//  AddGroupViewController.swift
//  AgendaProject
//
//  Created by Alessandro Negrão on 03/12/20.
//

import UIKit

class AddGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var participantTableView: UITableView!
    @IBOutlet weak var addParticipant: UIBarButtonItem!
    
    static let groupSingleton = AddGroupViewController()
    var people: [Person] = []
    let imageSetter = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSetter.delegate = self
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
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantCell", for: indexPath) as! ParticipantCell
        
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
            
            if (deletePeople.deletePerson(person: personDeleted) != nil){
                displayAlertWith(title: "Deleted", message: "Participant deleted succesfully")
            } else {
                displayAlertWith(title: "Failure", message: "Participant couldn`t be updated")

            }
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
    
    func displayAlertWith(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
 
}
