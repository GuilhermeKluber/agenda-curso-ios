//
//  ContatosModel.swift
//  AgendaCursoiOS
//
//  Created by PUCPR on 18/03/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Contatos {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var contatos : [Pessoa] = []
    
    func insert(_ data : [String : String]) {
        let pessoa : Pessoa = Pessoa(context: context)
        pessoa.nome = data["nome"]
        pessoa.sobrenome = data["sobrenome"]
        pessoa.dataNascimento = data["dataNascimento"]
        
        do {
            try context.save()
            
        }catch{
            print("Erro: \(error)")
        }
        
    }
    
    func remove() {
        //data here
    }
    
    func update() {
        //data here
    }
    
    func load(){
        var pessoas : [Pessoa] = []
        //Read
        let requisicao : NSFetchRequest<Pessoa> = Pessoa.fetchRequest()
        
        requisicao.predicate = NSPredicate(format: "nome LIKE '*'")
        do{
            pessoas = try context.fetch(requisicao)
            self.contatos =  pessoas
        }catch{
            print("erro \(error)")
            self.contatos = []
        }
    }
    
    func find(_ data : String, _ type : String) -> [Pessoa] {
        var pessoas : [Pessoa] = []
        //Read
        let requisicao : NSFetchRequest<Pessoa> = Pessoa.fetchRequest()

        requisicao.predicate = NSPredicate(format: "nome LIKE '*{\(data)}*'")
        do{
            pessoas = try context.fetch(requisicao)
            return pessoas
        }catch{
            print("erro \(error)")
            return []
        }
    }
}
