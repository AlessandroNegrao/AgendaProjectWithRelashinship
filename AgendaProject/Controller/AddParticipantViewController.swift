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
            personRepo.createPerson(name: nameParticipant.text, role: adm)
            print("Participant created")
            
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
                print("Atualizado")
            } else {
                print("Oops")
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
    
    
}
