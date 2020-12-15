//
//  AddParticipantViewController.swift
//  AgendaProject
//
//  Created by Alessandro Negrão on 03/12/20.
//

import UIKit
import CoreData

class AddParticipantViewController: UIViewController {
    
    static let shared = AddParticipantViewController() //Singleton da View Controller de adição de participantes
    
    @IBOutlet weak var nameParticipant: UITextField!
    @IBOutlet weak var administratorSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!
    
    var adm: String = ""
    var person: Person?
    var editPerson: Bool = false
    var people: [Person] = []
    var group: Group?
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Verificação de segue, para caso a tela for acionada por um elemento existente da table view, preenchendo com os valores dela
        if editPerson{
            nameParticipant.text = person?.name
            setStateToSwitch() //De acordo com o valor de role, atribui um estado ao switch
        }
    }
    
    //Função de salvar, tanto para o create quanto para o update de prticipante
    @IBAction func saveNewParticipant(_ sender: Any) {
        //Aqui ocorre a verificação para saber se a tela foi iniciada pela table view ou pelo botão "+"
        if !editPerson{
            setStringToSwitchState() //De acordo com o estado do switch, atribuir ma string a role
            let personRepo = PersonRepository.shared //Instância da model de Person
            
            //Salvar um dado, criando um registro
            guard let theGroup = self.group else {
                print("falhou")
                return
            }
            if (personRepo.createPerson(context: self.context, name: nameParticipant.text, role: adm, group: theGroup) != nil) {
                displayAlertWith(title: "Created", message: "Participant created successfully")
            } else {
                displayAlertWith(title: "Failure", message: "Partipant couldn`t be created")

            }
        } else {
            
            //Chamar função para atualizar a task no nosso container e mostrar alerta de sucesso ou err
            guard let lastPerson = person else{
                return
            }
            let personRepo = PersonRepository.shared
            let newPerson = lastPerson
            
            newPerson.name = nameParticipant.text
            setStringToSwitchState()
            newPerson.role = adm
            
            //Realiza a atualização dos dados de um registro pre-existente
            if personRepo.updatePerson(context: self.context, person: newPerson) != nil{
                displayAlertWith(title: "Updated", message: "Participant updated successfully")
                _ = navigationController?.popViewController(animated: true)
            } else {
                displayAlertWith(title: "Failure", message: "Partipant couldn`t be updated")
            }
        }
    }
    
    //Função que, de acordo com o estado do switch, preenche o valor String da variável adm para armazenar em role
    func setStringToSwitchState(){
        if administratorSwitch.isOn == true{
            adm = "Administrator"
        }
        else{
            adm = "User"
        }
    }
    
    //Função utilizada quando um update for solicitado, para preencher corretamente o estado do switch de acordo com o que estiver no banco de dados
    func setStateToSwitch(){
        if person?.role == "Administrator" {
            administratorSwitch.isOn = true
        }
        else{
            administratorSwitch.isOn = false
        }
    }
    
    //Função para mostrar na tela um alerta customizável
    func displayAlertWith(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:  { (action) in
            //self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
