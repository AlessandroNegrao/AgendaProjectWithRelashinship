//  Group Repository.swift
//  AgendaProject
//
//  Created by Alessandro Negrão on 03/12/20.
//

import Foundation
import CoreData

public class GroupRepository {
    static let shared = GroupRepository() // Singleton
    
    //Inicialização da unidade de persistência com o persistent container
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
    
    // Função de criação de objeto e armazenamento no banco de dados
    func createGroup(nameGroup: String?) -> Group?{
        let context = persistentContainer.viewContext //Declarção do context, uma das unidades do persistent container
        let newGroup = NSEntityDescription.insertNewObject(forEntityName: "Group", into: context) as! Group
        
        newGroup.nameGroup = nameGroup
        
        do {
            try context.save() //Através do context, utilizamos a função save, que envia dados para o Coordinator e persiste
            return newGroup
        } catch let createError{
            
            print("failed to create: \(createError)")
        }
        return nil
    }
    
    // Função de retorno de dados do banco de dados
    func fetchGroups() -> [Group]? {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Group>(entityName: "Group") //Através do fetch request uma lista é preparada para receber os valores armazenados no banco
        
        do {
            let groups = try context.fetch(fetchRequest) //Trás os valores do banco para a lista people, para que possam ser mostrados...
            return groups
        } catch let fetchError{
            print("failed to fetch: \(fetchError)")
        }
        return nil
    }
    
    // Função de atualização de dados de group no banco de dados
    func updateGroup(group: Group) -> Group?{
        let context = persistentContainer.viewContext
        
        do{
            try context.save()
            return group
        }catch let updateError{
            print("Failed to update: \(updateError)")
        }
        return nil
    }
    
    // Função de remoção de dados de group no banco de dados
    func deleteGroup(group: Group) -> Group?{
        let context = persistentContainer.viewContext
        context.delete(group) //Função de deleção de dados através do context, removendo os mesmos do banco após realizar o save()
        do{
            try context.save()
            return group
        }catch let deleteError{
            print("Failed to delete: \(deleteError)")
        }
        return nil
    }
    
}
