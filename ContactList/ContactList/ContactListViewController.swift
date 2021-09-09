//
//  ContactListViewController.swift
//  ContactList
//
//  Created by gohpeijin on 07/09/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit
import CoreData

class ContactListViewController: UITableViewController {
    
    var contacts: [Contact]  = []
    
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!

    @IBOutlet var contactListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        contactListTableView.register(ContactListTableViewCell.nib(), forCellReuseIdentifier: ContactListTableViewCell.identifier)

        fetch()
    }
    
    func fetch(){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Status: Error in app")
            return
        }
        appDelegate = delegate
        managedContext = appDelegate.persistentContainer.viewContext
        let sort = NSSortDescriptor(key: "name", ascending: true)
        let fetchrequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        fetchrequest.sortDescriptors = [sort]
        do {
            contacts = try managedContext.fetch(fetchrequest)
            contactListTableView.reloadData()
        } catch let error as NSError{
            print(error)
        }
    }

    func saveAdd(_ name: String, _ phoneNumber: String){
        let contact = NSEntityDescription.insertNewObject(forEntityName: "Contact", into:managedContext) as! Contact
        contact.name = name
        contact.phoneNumber = phoneNumber
        do{
            try managedContext.save()
            self.contacts.append(contact)
            print("Status: The data is saved into db")
        } catch let error as NSError{
            print("Status: Error when saving the data")
            print(error)
        }

    }

    func delete(_ indexPath: IndexPath){
        do{
            managedContext.delete(contacts[indexPath.row])
//            contacts.remove(at: indexPath.row)
            try managedContext.save()
            print("Status: The data is deleted")
        } catch let error as NSError{
            print("Status: Error when deleting the data")
            print(error)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactListTableViewCell.identifier, for: indexPath) as! ContactListTableViewCell
        let contact = contacts[indexPath.row]
        cell.displayCell(contact.name!, contact.phoneNumber!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "viewContactDetailSegue", sender: nil)
    }

    @IBAction func unwindToTableView(segue: UIStoryboardSegue){
        if let addcontactVC = segue.source as? AddContactViewController{
            // make sure no empty context
            guard let name = addcontactVC.nameTextField.text, !addcontactVC.nameTextField.text!.isEmpty, let phoneNumber = addcontactVC.phoneNumberTextField.text, !addcontactVC.phoneNumberTextField.text!.isEmpty else {print("Lack Info"); return}
            saveAdd(name, phoneNumber)
            
        } else if let contactDetailVC = segue.source as? ContactDetailViewController{
                guard let indexPath = contactListTableView.indexPathForSelectedRow else {return}
                if contactDetailVC.isEdit{
                contacts[indexPath.row] = contactDetailVC.contact
                contactListTableView.reloadData()
            }
        } else if segue.source is DeleteContactViewController{
            guard let indexPath = contactListTableView.indexPathForSelectedRow else {return}
            delete(indexPath)
        }else if segue.source is EditContactViewController{
           print("yes able to come first page")
            let contactDetailVC = (self.storyboard?.instantiateViewController(withIdentifier: "ContactDetailViewController") as? ContactDetailViewController)!
    
            self.navigationController?.pushViewController(contactDetailVC, animated: true)
//             guard let contactDetailVC = segue.destination as? ContactDetailViewController else {return}
//            print(contactDetailVC)
//            print("........")
//        navigationController?.pushViewController(contactDetailVC, animated: true)
//            print(contactDetailVC)
        }
        fetch()
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
