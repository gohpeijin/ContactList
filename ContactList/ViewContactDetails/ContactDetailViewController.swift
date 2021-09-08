//
//  ContactDetailViewController.swift
//  ContactList
//
//  Created by gohpeijin on 08/09/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    var contact: ContactClass!
    var isDelete: Bool = false
    
    @IBOutlet weak var labelPhoneNumber: UILabel!
    @IBOutlet weak var labelContactName: UILabel!
    override func viewDidLoad() {
        labelContactName.text = contact?.name
        labelPhoneNumber.text = contact?.phoneNumber
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        isDelete = true
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContactSegue"{
            guard let editContactVC = segue.destination as? EditContactViewController else {return}
//            guard let indexPath = contactListTableView.indexPathForSelectedRow else {return}
//            let contact = contacts[indexPath.row]
//
//            contactDetailVC.contact = contact
    }
    }


}
