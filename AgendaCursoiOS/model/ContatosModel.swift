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

enum ErrorsToThrow: Error {
    case IndexError

}

class Contatos {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var contatos : [Pessoa] = []
    
    func insertPessoa(_ nome : String, _ sobrenome : String, _ dataNascimento : Date) {

        var pessoas : [Pessoa] = []
        let requisicao : NSFetchRequest<Pessoa> = Pessoa.fetchRequest()
        
        requisicao.predicate = NSPredicate(format: "nome == '\(nome)' && sobrenome == '\(sobrenome)'")
        do{
            pessoas = try context.fetch(requisicao)
            if pessoas.count > 0{
                throw ErrorsToThrow.IndexError
            }
        }catch{
            print("erro \(error)")
        }
        
        let pessoa : Pessoa = Pessoa(context: context)
        pessoa.nome = nome
        pessoa.sobrenome = sobrenome
        pessoa.dataNascimento = dataNascimento
        
        do {
            try context.save()
            
        }catch{
            print("Erro: \(error)")
        }
        
    }
    
    func insertTelefone(_ nome : String, _ sobrenome : String, _ numero : String, _ ddd : Int16, _ ddi : Int16,_ tipo : String) {
        
        var pessoas : [Pessoa] = []
        var contato : Pessoa = Pessoa(context: context)
        //Read
        let requisicao : NSFetchRequest<Pessoa> = Pessoa.fetchRequest()
        
        requisicao.predicate = NSPredicate(format: "nome == '\(nome)' && sobrenome == '\(sobrenome)'")
        do{
            pessoas = try context.fetch(requisicao)
            contato =  pessoas[0]
        }catch{
            print("erro \(error)")
        }
        
        let fone : Fones = Fones(context: context)
        
        fone.telefone = numero
        fone.tipo = tipo
        fone.ddd = ddd
        fone.ddi = ddi
        
        contato.addToFones(fone)
        
        do {
            try context.save()
            
        }catch{
            print("Erro: \(error)")
        }
    }
    
    func insertRedesSociais(_ nome : String, _ sobrenome : String, _ URL : String, tipo : String) {
        
        var pessoas : [Pessoa] = []
        var contato : Pessoa = Pessoa(context: context)
        //Read
        let requisicao : NSFetchRequest<Pessoa> = Pessoa.fetchRequest()
        
        requisicao.predicate = NSPredicate(format: "nome == '\(nome)' && sobrenome == '\(sobrenome)'")
        do{
            pessoas = try context.fetch(requisicao)
            contato =  pessoas[0]
        }catch{
            print("erro \(error)")
        }
        
        let rede : RedesSociais = RedesSociais(context: context)
        
        rede.rede = tipo
        rede.url = URL

        contato.addToRedessociais(rede)
        
        do {
            try context.save()
            
        }catch{
            print("Erro: \(error)")
        }
        print(contato)
    }
    
    func insertEndereco(_ nome : String, _ sobrenome : String, _ rua : String, _ numero : Int16,
                        _ bairro : String, _ cidade : String, _ estado : String, _ pais : String) {
        
        var pessoas : [Pessoa] = []
        var contato : Pessoa = Pessoa(context: context)
        //Read
        let requisicao : NSFetchRequest<Pessoa> = Pessoa.fetchRequest()
        
        requisicao.predicate = NSPredicate(format: "nome == '\(nome)' && sobrenome == '\(sobrenome)'")
        do{
            pessoas = try context.fetch(requisicao)
            contato =  pessoas[0]
        }catch{
            print("erro \(error)")
        }
        
        let Endereco : Enderecos = Enderecos(context: context)
        
        Endereco.numero = numero
        Endereco.rua = rua
        Endereco.bairro = bairro
        Endereco.cidade = cidade
        Endereco.uf = cidade
        Endereco.pais = pais
        
        contato.endereco = Endereco
        
        do {
            try context.save()
            
        }catch{
            print("Erro: \(error)")
        }
        print(contato)
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
        print(contatos[contatos.count-1].nome, (contatos[contatos.count-1].redessociais?.anyObject() as! RedesSociais).rede)
    }
    
    func find(_ nome : String, _ sobrenome : String) -> Pessoa {
        var pessoa : Pessoa
        //Read
        let requisicao : NSFetchRequest<Pessoa> = Pessoa.fetchRequest()

        requisicao.predicate = NSPredicate(format: "nome == '\(nome)' && sobrenome == '\(sobrenome)'")
        do{
            pessoa = try context.fetch(requisicao)[0]
            return pessoa
        }catch{
            print("erro \(error)")
            return Pessoa()
        }
    }
}
