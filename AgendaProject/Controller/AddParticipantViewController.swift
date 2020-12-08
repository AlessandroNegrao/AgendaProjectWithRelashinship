//
//  AddParticipantViewController.swift
//  AgendaProject
//
//  Created by Alessandro Negrão on 03/12/20.
//

import UIKit

class AddParticipantViewController: UIViewController {
    
    static let shared = AddParticipantViewController()
    
    @IBOutlet weak var nameParticipant: UITextField!
    @IBOutlet weak var administratorSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!
    
    var adm: String = ""
    
    var person: Person?
    var editPerson: Bool = false
    
    var people: [Person] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if editPerson{
            nameParticipant.text = person?.name
            setStateToSwitch()
        }
    }
    
    @IBAction func saveNewParticipant(_ sender: Any) {
        if !editPerson{
            
            setStringToSwitchState()
            let personRepo = PersonRepository.shared
            
            if (personRepo.createPerson(name: nameParticipant.text, role: adm) != nil){
                displayAlertWith(title: "Created", message: "Participant created successfully")
            } else {
                displayAlertWith(title: "Failure", message: "Partipant couldn`t be created")

            }
        } else {
            
            //Chamar função para atualizar a task no nosso container e mostrar alerta de sucesso ou erro
            
            guard let lastPerson = person else{
                return
            }
            let personRepo = PersonRepository.shared
            let newPerson = lastPerson
            
            newPerson.name = nameParticipant.text
            setStringToSwitchState()
            newPerson.role = adm
            
            if personRepo.updatePerson(person: newPerson) != nil{
                displayAlertWith(title: "Updated", message: "Participant updated successfully")
                _ = navigationController?.popViewController(animated: true)
            } else {
                displayAlertWith(title: "Failure", message: "Partipant couldn`t be updated")
            }
        }
    }
    
    func setStringToSwitchState(){
        if administratorSwitch.isOn == true{
            adm = "Administrator"
        }
        else{
            adm = "User"
        }
    }
    
    func setStateToSwitch(){
        if person?.role == "Administrator" {
            administratorSwitch.isOn = true
        }
        else{
            administratorSwitch.isOn = false
        }
    }
    
    func displayAlertWith(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:  { (action) in
            //self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
