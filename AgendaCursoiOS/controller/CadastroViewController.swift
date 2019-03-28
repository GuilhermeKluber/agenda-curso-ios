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
import PhoneNumberKit

class CadastroViewController: FormViewController {
    
    @IBOutlet weak var userPhoto: UIImageView!
    var owner : AgendaTableViewController?
    
    var data : [String:Any]!
    
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
                                        return self.tipoNumero(index)
                                    }
                                    $0 <<< self.tipoNumero(0)
            }
            
            +++ Section("Endereço")
            
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
                                        return self.redesSociais(index)
                                    }
                                    
                                    $0 <<< self.redesSociais(0)
                                    
                                    
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.form.setValues(data)
        print(form.values())
        //self.tableView?.reloadData()
    }
    
    func redesSociais(_ index : Int) -> SplitRow<PushRow<String>,TextRow> {
        let row = SplitRow<PushRow<String>,TextRow>("rede_\(index)"){
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

    func tipoNumero(_ index : Int) -> SplitRow<PushRow<String>,PhoneRow> {
        let row = SplitRow<PushRow<String>,PhoneRow>("fone_\(index)"){
            $0.rowLeftPercentage = 0.35
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
                }.onChange {
                    $0.cell.textField.text =  self.formatAsPhoneNumber($0.cell.textField.text!)
            }
            
        }
        return row
    }
    
    func formatAsPhoneNumber(_ textField: String) -> String {
        
//        let textField = PhoneNumberTextField()

        return PartialFormatter().formatPartial(textField)
    }
    
    func fillContatoFields(_ contato : Pessoa){
        
        let cidadeUf = SplitRowValue<String, String>(left: contato.endereco?.cidade, right: contato.endereco?.uf)
        let ruaNumero = SplitRowValue<String, String>(left: contato.endereco?.rua, right: contato.endereco?.uf)
        
        data = ["nome": contato.nome,
//                    "telefones": numeros,
                    "sobrenome": contato.sobrenome,
//                    "redes": redes,
                    "bairro": contato.endereco?.bairro,
                    "cidadeUf": cidadeUf,
                    "dataNascimento": contato.dataNascimento,
                    "pais": contato.endereco?.pais,
                    "ruaNumero":ruaNumero] as [String : Any]

    for (i,telefone) in contato.fones!.enumerated(){
        data["fone_\(i)"] = SplitRowValue<String, String>(left: (telefone as! Fones).tipo, right: (telefone as! Fones).telefone)
    }
    
    for (i,rede) in contato.redessociais!.enumerated(){
         data["rede_\(i)"] = SplitRowValue<String, String>(left: (rede as! RedesSociais).rede, right: (rede as! RedesSociais).url)
        }
    }
    
    @IBAction func save(_ sender: Any) {

        
        let valuesDictionary = form.values()
        print(valuesDictionary)
        
        let nome : TextRow? = form.rowBy(tag: "nome")
        let sobrenome : TextRow? = form.rowBy(tag: "sobrenome")
        let dataNascimento : DateRow? = form.rowBy(tag: "dataNascimento")
        
        let telefones = (form.values()["telefones"]!! as! [Any]).compactMap { $0 }
        let ruaNumero = form.values()["ruaNumero"]!! as! SplitRowValue<String,String>
        let cidadeUf = form.values()["cidadeUf"]!! as! SplitRowValue<String,String>
        let pais : TextRow? = form.rowBy(tag: "pais")
        
        let redeSociais  = (form.values()["redes"]!! as! [Any]).compactMap { $0 }
        
        owner?.agenda.insertPessoa((nome?.value)!,(sobrenome?.value)!, dataNascimento!.value!)
        
        for fone in telefones{
            
            let fone = fone as! SplitRowValue<String,String>
            if fone.right == nil{continue}
            let tipo = fone.left
            let numero = fone.right
            
            owner?.agenda.insertTelefone((nome?.value)!,(sobrenome?.value)!, (numero)!, 55, 41, (tipo)!)
        }
        
        for rede in redeSociais{
            let rede = rede as! SplitRowValue<String,String>
            if rede.right == nil{continue}
            let tipo = rede.left
            let URL = rede.right
            
            owner?.agenda.insertRedesSociais((nome?.value)!,(sobrenome?.value)!, (URL)! , tipo: (tipo)!)
            
        }
    
        
        if (ruaNumero.left != nil) && (pais != nil ) && (cidadeUf.left != nil) {
            owner?.agenda.insertEndereco((nome?.value)! ,(sobrenome?.value)! ,ruaNumero.left ?? "" , Int16(ruaNumero.right!)!,
                                                 "bairro", cidadeUf.left!, cidadeUf.right!, (pais?.value)!)
        }
    }
}

