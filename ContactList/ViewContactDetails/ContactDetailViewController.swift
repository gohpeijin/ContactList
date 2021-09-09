//
//  ContactDetailViewController.swift
//  ContactList
//
//  Created by gohpeijin on 08/09/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    var contact: Contact!
    
    @IBOutlet weak var buttonDone: UIButton!
    @IBOutlet weak var labelPhoneNumber: UILabel!
    @IBOutlet weak var labelPhoneNumber1: UILabel!
    @IBOutlet weak var labelContactName: UILabel!
    @IBOutlet weak var labelOccupation: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelNotes: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayContent()
        UIchores()
    }
    
    func UIchores(){
        scrollView.contentSize = contentView.frame.size
        buttonDone.layer.borderColor = UIColor.init(red: 13/255, green: 174/255, blue: 156/255, alpha: 1).cgColor
    }
    
    func displayContent(){
        labelContactName.text = contact?.name
        labelPhoneNumber.text = contact?.phoneNumber
        labelPhoneNumber1.text = contact?.phoneNumber
        labelOccupation.text = contact.occupation!.isEmpty ? "N/A" : contact.occupation!
        labelEmail.text = contact.email!.isEmpty ? "N/A" : contact.email!
        labelAddress.text = contact.address!.isEmpty ? "N/A" : contact.address!
        labelNotes.text = contact.notes!.isEmpty ? "N/A" : contact.notes!
    }
    
    @IBAction func unwindToViewContact(segue: UIStoryboardSegue){
       guard let editContactVC = segue.source as? EditContactViewController else {return}
        let name = editContactVC.nameTextField.text!.isEmpty  ? contact?.name: editContactVC.nameTextField.text
        let phoneNumber = editContactVC.phoneNumberTextField.text!.isEmpty  ? contact?.name: editContactVC.phoneNumberTextField.text
        let email = editContactVC.emailTextField.text
        let occupation = editContactVC.occupationTextField.text
        let address = editContactVC.addressTextField.text
        let notes = editContactVC.additionalNotesTextField.text
        
        contact.name = name!
        contact.phoneNumber = phoneNumber!
        contact.email = email!
        contact.occupation = occupation!
        contact.address = address!
        contact.notes = notes!
        displayContent()
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContactSegue"{
            guard let editContactVC = segue.destination as? EditContactViewController else {return}
            editContactVC.contactedit = contact
    }
    }


}
