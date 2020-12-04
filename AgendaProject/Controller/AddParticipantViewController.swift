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
            
            if person?.role == "Administrator" {
                administratorSwitch.isOn = true
            }
            else{
                administratorSwitch.isOn = false
            }
            
        }
        

    }
    
    @IBAction func saveNewParticipant(_ sender: Any) {
        
        if administratorSwitch.isOn == true{
            adm = "Administrator"
        }
        else{
            adm = "User"
        }
        
        PersonRepository.shared.createPerson(name: nameParticipant.text, role: adm)
        print("Participant created")
    }
    
}
