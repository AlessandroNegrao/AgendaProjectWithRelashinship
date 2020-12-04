//
//  AddParticipantViewController.swift
//  AgendaProject
//
//  Created by Alessandro Negrão on 03/12/20.
//

import UIKit

class AddParticipantViewController: UIViewController {
    
    @IBOutlet weak var nameParticipant: UITextField!
    @IBOutlet weak var administratorSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!
    
    var adm: String = ""
    var people: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()

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
