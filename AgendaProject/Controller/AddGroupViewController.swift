//
//  AddGroupViewController.swift
//  AgendaProject
//
//  Created by Alessandro Negrão on 03/12/20.
//

import UIKit
import CoreData

class AddGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var participantTableView: UITableView!
    @IBOutlet weak var addParticipant: UIBarButtonItem!
    @IBOutlet weak var nameGroup: UITextField!
    
    static let groupSingleton = AddGroupViewController()
    var people: [Person] = []
    public let imageSetter = UIImagePickerController()
    
    var group: Group?

    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSetter.delegate = self
        nameGroup.text = self.group?.nameGroup
    }
    
    override func viewWillAppear(_ animated: Bool) {
        participantTableView.reloadData()
    }
    
    func populatePeopleArray(){
        let peopleRepo = PersonRepository.shared //Singleton de novo
        if let fetchedPeople = peopleRepo.fetchPeople(context: self.context){
            people = fetchedPeople
        }else{
            people = []
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let elfs = self.group?.elfsInGroup else { return 0 }
        return elfs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantCell", for: indexPath) as! ParticipantCell
        
        guard let elf = self.group?.elfsInGroup?.allObjects[indexPath.row] as? Person else { return cell }
        cell.fillCellWithTitle(elf.name, elf.role)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            let deletePeople = PersonRepository.shared
            let personDeleted = people[indexPath.row]
            
            people.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
            
            if (deletePeople.deletePerson(context: self.context, person: personDeleted) != nil){
                displayAlertWith(title: "Deleted", message: "Participant deleted succesfully")
            } else {
                displayAlertWith(title: "Failure", message: "Participant couldn`t be updated")

            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let AddParticipantVC = segue.destination as! AddParticipantViewController
        
        AddParticipantVC.group = self.group
        guard let indexPath = self.participantTableView.indexPathForSelectedRow else { return }
        guard let elf = self.group?.elfsInGroup?.allObjects[indexPath.row] as? Person else { return }
        AddParticipantVC.person = elf

        if segue.identifier == "editParticipant" {
            // index da celula da table view que for pressionada
            AddParticipantVC.editPerson = true
        } else {
            AddParticipantVC.editPerson = false
        }
    }
    
    func displayAlertWith(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func saveGroup(_ sender: Any) {
        let groupRepo = GroupRepository.shared //Instância da model de Person
        
        //Salvar um dado, criando um registro
        if (groupRepo.createGroup(context: self.context, nameGroup: nameGroup.text, people: people) != nil){
            displayAlertWith(title: "Created", message: "Group created successfully")
        } else {
            displayAlertWith(title: "Failure", message: "Partipant couldn`t be created")

        }
    }
 
}
