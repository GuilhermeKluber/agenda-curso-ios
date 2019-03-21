//
//  CadastroViewController.swift
//  AgendaCursoiOS
//
//  Created by PUCPR on 15/03/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import Eureka
import SplitRow

class CadastroViewController: FormViewController {
    
    @IBOutlet weak var userPhoto: UIImageView!
    var owner : AgendaTableViewController?
    
    override func viewDidLoad() {
            super.viewDidLoad()
            form
                +++ Section("Dados Pessoais")
                
                    <<< TextRow(){ row in
                        row.title = "Nome"
                        row.placeholder = ""
                        row.tag = "nome"
                    }
                
                    <<< TextRow(){ row in
                        row.title = "Sobrenome"
                        row.placeholder = ""
                        row.tag = "sobrenome"
                    }


                    <<< DateRow(){
                        $0.title = "Data de Nascimento"
                        $0.value = Date(timeIntervalSinceReferenceDate: 0)
                        $0.tag = "dataNascimento"
                    }
        
                +++ MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
                                   header: "Números de telefone",
                                   footer: "") {
                                    $0.tag = "telefones"
                                    $0.addButtonProvider = { section in
                                        return ButtonRow(){
                                            $0.title = "Adicionar novo número de telefone"
                                        }
                                    }
                                    $0.multivaluedRowToInsertAt = { index in
                                        return self.tipoNumero()
                                    }
                                    $0 <<< self.tipoNumero()
                    }
        
                +++ Section("Endereços")
                
                    <<< SplitRow<TextRow,TextRow>(){
                        $0.tag = "ruaNumero"
                        $0.rowLeftPercentage = 0.7
                        $0.rowLeft = TextRow(){
                            $0.placeholder = "Rua"
                            $0.tag = "rua"
                        }
                        
                        $0.rowRight = TextRow(){
                            $0.title = ""
                            $0.placeholder = "Numero"
                            $0.tag = "numero"
                            }.cellUpdate { cell, row in
                                cell.textField.textAlignment = .left
                            }
                        }
                
                    <<< TextRow(){
                        $0.placeholder = "Bairro"
                        $0.tag = "bairro"
                    }
                
                    <<< SplitRow<TextRow,PushRow<String>>(){
                        $0.tag = "cidadeUf"
                        $0.rowLeftPercentage = 0.80
                        $0.rowLeft = TextRow(){
                            $0.placeholder = "Cidade"
                            $0.tag = "cidade"
                        }
                        
                        $0.rowRight = PushRow<String>(){
                            $0.selectorTitle = "UF"
                            $0.tag = "uf"
                            $0.value = "AC"
                            $0.options = ["AC","AL","AP","AM","BA","CE","DF","ES","GO","MA","MT","MS","MG","PA",
                                          "PB","PR","PE","PI","RJ","RN","RS","RO","RR","SC","SP","SE","TO"]
                        }
                    }
                
                    <<< TextRow(){
                        $0.placeholder = "País"
                        $0.tag = "pais"
                        }.cellUpdate { cell, row in
                            cell.textField.textAlignment = .left
                    }
                    // Bolar location Row
        
                 +++ MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
                                       header: "Redes Sociais",
                                       footer: "") {
                                        $0.tag = "redes"
                                        $0.addButtonProvider = { section in
                                            return ButtonRow(){
                                                $0.title = "Adicionar novo contato"
                                            }
                                        }
                                        $0.multivaluedRowToInsertAt = { index in
                                            return self.redesSociais()
                                        }
                                        
                                        $0 <<< self.redesSociais()


                }
        
        }
        func redesSociais() -> SplitRow<PushRow<String>,TextRow> {
            let row = SplitRow<PushRow<String>,TextRow>(){
                $0.rowLeftPercentage = 0.5
                $0.rowLeft = PushRow<String>(){
                    $0.selectorTitle = "Redes Sociais"
                    $0.value = "Facebook"
                    $0.options = ["Facebook","Twitter","Linkedin"]
                    $0.tag = "redesSociais"
                }
                
                $0.rowRight = TextRow(){
                    $0.title = ""
                    $0.placeholder = "www.seulinkdo.com"
                    $0.tag = "url"
                }
                
            }
            return row
        }

        func tipoNumero() -> SplitRow<PushRow<String>,PhoneRow> {
            let row = SplitRow<PushRow<String>,PhoneRow>(){
                $0.rowLeftPercentage = 0.5
                $0.rowLeft = PushRow<String>(){
                    $0.selectorTitle = "Tipo"
                    $0.value = "Celular"
                    $0.options = ["Celular","Residencial"]
                    $0.tag = "celular"
                }
                
                $0.rowRight = PhoneRow(){
                    $0.title = ""
                    $0.placeholder = "(XX) XXXXX-XXXX"
                    $0.tag = "numero"
                }
                
            }
            return row
        }
    
    @IBAction func save(_ sender: Any) {

        let nome : TextRow? = form.rowBy(tag: "nome")
        let sobrenome : TextRow? = form.rowBy(tag: "sobrenome")
        let dataNascimento : DateRow? = form.rowBy(tag: "dataNascimento")
        
        let telefones : SplitRow<PushRow<String>,PhoneRow>? = form.rowBy(tag: "telefones")
        let ruaNumero : TextRow? = form.rowBy(tag: "ruaNumero")
        let cidadeUf : TextRow? = form.rowBy(tag: "cidadeUf")
        let pais : TextRow? = form.rowBy(tag: "pais")
        
        let redeSociais : SplitRow<PushRow<String>,TextRow>? = form.rowBy(tag: "redeSociais")
        
        do{
            try owner?.agenda.insertPessoa((nome?.value)!,(sobrenome?.value)!, dataNascimento!.value!)
        }catch{
            print("\(error)")
        }
        
    }
    
    
}
