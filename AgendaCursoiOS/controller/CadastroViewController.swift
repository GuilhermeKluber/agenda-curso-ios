//
//  CadastroViewController.swift
//  AgendaCursoiOS
//
//  Created by PUCPR on 15/03/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import Eureka

class CadastroViewController: FormViewController {
    
    @IBOutlet weak var userPhoto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Dados Pessoais")
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
        
        form +++
            MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
                               header: "Números de telefone",
                               footer: "") {
                                $0.addButtonProvider = { section in
                                    return ButtonRow(){
                                        $0.title = "Adicionar novo número de telefone"
                                    }
                                }
                                $0.multivaluedRowToInsertAt = { index in
                                    return PhoneRow(){
                                        $0.title = "Número de telefone"
                                        $0.placeholder = "(XX) XXXXX-XXXX"
                                    }
                                }
                                $0 <<< PhoneRow(){
                                    $0.title = "Número de telefone"
                                    $0.placeholder = "(XX) XXXXX-XXXX"
                                }
        }
        
        form +++ Section("Endereços")
            <<< SwitchRow("Adicionar Endereço"){
                $0.title = "Show message"
            }
            
            <<< TextRow(){ row in
                row.hidden = Condition.function(["Adicionar Endereço"], { form in
                    return !((form.rowBy(tag: "Adicionar Endereço") as? SwitchRow)?.value ?? false)
                })
                row.title = "Rua"
                row.placeholder = ""
            }
            <<< TextRow(){ row in
                row.hidden = Condition.function(["Adicionar Endereço"], { form in
                    return !((form.rowBy(tag: "Adicionar Endereço") as? SwitchRow)?.value ?? false)
                })
                row.title = "Numero"
                row.placeholder = ""
            }
            <<< TextRow(){ row in
                row.hidden = Condition.function(["Adicionar Endereço"], { form in
                    return !((form.rowBy(tag: "Adicionar Endereço") as? SwitchRow)?.value ?? false)
                })
                row.title = "Bairro"
                row.placeholder = ""
            }
            <<< TextRow(){ row in
                row.hidden = Condition.function(["Adicionar Endereço"], { form in
                    return !((form.rowBy(tag: "Adicionar Endereço") as? SwitchRow)?.value ?? false)
                })
                row.title = "Cidade"
                row.placeholder = ""
            }
            <<< TextRow(){ row in
                row.hidden = Condition.function(["Adicionar Endereço"], { form in
                    return !((form.rowBy(tag: "Adicionar Endereço") as? SwitchRow)?.value ?? false)
                })
                row.title = "País"
                row.placeholder = ""
            }
            // Bolar location Row
        
        
            form +++
                MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
                                   header: "Redes Sociais",
                                   footer: "") {
                                    $0.addButtonProvider = { section in
                                        return ButtonRow(){
                                            $0.title = "Adicionar novo contato"
                                        }
                                    }
                                    $0.multivaluedRowToInsertAt = { index in
                                        return URLRow(){
                                            $0.title = "URL"
                                            $0.placeholder = "www.seulinkdoface.com"
                                        }
                                    }
                                    $0 <<< URLRow(){
                                        $0.title = "URL"
                                        $0.placeholder = "www.seulinkdoface.com"
                                    }
            }
//            <<< LabelRow(){
//
//                $0.hidden = Condition.function(["switchRowTag"], { form in
//                    return !((form.rowBy(tag: "switchRowTag") as? SwitchRow)?.value ?? false)
//                })
//                $0.title = "Switch is on!"
//            }

}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
