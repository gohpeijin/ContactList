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
            
        } else if let contactDetailVC = segue.source as? ContactDetailViewController{
            guard let indexPath = contactListTableView.indexPathForSelectedRow else {return}
            if contactDetailVC.isDelete{
                contacts.remove(at: indexPath.row)
            } else if contactDetailVC.isEdit{
                contacts[indexPath.row] = contactDetailVC.contact
                contactListTableView.reloadData()
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

}
