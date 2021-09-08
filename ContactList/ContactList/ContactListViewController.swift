//
//  ContactListViewController.swift
//  ContactList
//
//  Created by gohpeijin on 07/09/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class ContactListViewController: UITableViewController {
    
    var contacts: [ContactClass]  = []

    @IBOutlet var contactListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

         contactListTableView.register(ContactListTableViewCell.nib(), forCellReuseIdentifier: ContactListTableViewCell.identifier)
//        createContactList()
//        contactListTableView.reloadData()
    }

//    func createContactList() {
//        let contact = ContactClass(name: "Goh Pei Jin", phoneNumber: "123456789")
//        contacts.append(contact)
//    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactListTableViewCell.identifier, for: indexPath) as! ContactListTableViewCell
        let contact = contacts[indexPath.row]
        cell.displayCell(contact.name, contact.phoneNumber)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "viewContactDetailSegue", sender: nil)
    }

    @IBAction func unwindPage(segue: UIStoryboardSegue){
        if let addcontactVC = segue.source as? AddContactViewController{
            //        guard let addcontactVC = segue.source as? AddContactViewController else {return}
            // make sure no empty context
            guard let name = addcontactVC.nameTextField.text, !addcontactVC.nameTextField.text!.isEmpty, let phoneNumber = addcontactVC.phoneNumberTextField.text, !addcontactVC.phoneNumberTextField.text!.isEmpty else {print("Lack Info"); return}
            
            let contact = ContactClass(name: name, phoneNumber: phoneNumber)
            contacts.append(contact)
            
        } else if let viewContactVC = segue.source as? ContactDetailViewController{
            if viewContactVC.isDelete{
                guard let indexPath = contactListTableView.indexPathForSelectedRow else {return}
                contacts.remove(at: indexPath.row)
            }
        }
        contactListTableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewContactDetailSegue"{
            guard let contactDetailVC = segue.destination as? ContactDetailViewController else {return}
            guard let indexPath = contactListTableView.indexPathForSelectedRow else {return}
            let contact = contacts[indexPath.row]
            
            contactDetailVC.contact = contact
            
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
