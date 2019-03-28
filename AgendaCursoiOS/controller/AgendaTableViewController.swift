//
//  AgendaTableViewController.swift
//  AgendaCursoiOS
//
//  Created by PUCPR on 15/03/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

class AgendaTableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var agenda : Contatos = Contatos()
//    let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var unique : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        agenda.load()
        tableView.reloadData()
    }
    // MARK: - Table view data source


    
    override func numberOfSections(in tableView: UITableView) -> Int {
        var char : [String] = []
        for pessoa in agenda.contatos{
            char.append(String((pessoa.nome)!.prefix(1)))
        }
        self.unique = Array(Set(char))
        return self.unique.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.unique[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return agenda.contatos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contatos", for: indexPath)
        cell.textLabel?.text = " \(agenda.contatos[indexPath.row].nome!) \(agenda.contatos[indexPath.row].sobrenome!)"
        return cell

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as! CadastroViewController
        
        if segue.identifier == "addContato"{
            next.owner = self
//
            
        }else if segue.identifier == "editContato"{
            next.owner = self
            let index = tableView.indexPathForSelectedRow
            let currentCell = tableView.cellForRow(at: index!)
            let name = agenda.contatos[(index?.row)!].nome!
            let sobrenome = agenda.contatos[(index?.row)!].sobrenome!
            let pessoa = self.agenda.find(String(name),String(sobrenome))
            next.fillContatoFields(pessoa)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
