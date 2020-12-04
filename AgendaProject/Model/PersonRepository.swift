//  PersonRepository.swift
//  AgendaProject
//
//  Created by Alessandro Negrão on 03/12/20.
//

import Foundation
import CoreData

public class PersonRepository { 
    static let shared = PersonRepository() // Singleton
    
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "AgendaProject")
        container.loadPersistentStores{
        storeDescription, error in
            
            if let foundError = error{
                fatalError("Error: \(foundError)") //crasha o codigo e mostra no console (nao recomendado em etapa de desenvolvimento avançada, na loja ou afins)
            }
        }
            
        return container
    }()
    
    func createPerson(name: String?, role: String?) -> Person? {
        let context = persistentContainer.viewContext
        let newPerson = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as! Person
        
        newPerson.name = name
        newPerson.role = role
        do {
            try context.save()
            return newPerson
        } catch let createError{
            print("failed to create: \(createError)")
        }
        return nil

    }
    
    func fetchTasks() -> [Person]? {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
       
        do {
            let people = try context.fetch(fetchRequest)
            return people
        } catch let fetchError{
            print("failed to fetch: \(fetchError)")
        }
        return nil
    }
    
    func updateTask(person: Person) -> Person?{
        let context = persistentContainer.viewContext
        
        do{
            try context.save()
            return person
        }catch let updateError{
            print("Failed to update: \(updateError)")
        }
        return nil
    }
    
    func deleteTask(person: Person){
        let context = persistentContainer.viewContext
        context.delete(person)
        do{
            try context.save()
        }catch let deleteError{
            print("Failed to delete: \(deleteError)")
        }
    }

}
