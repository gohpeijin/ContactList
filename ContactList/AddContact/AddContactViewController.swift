//
//  AddContactViewController.swift
//  ContactList
//
//  Created by gohpeijin on 07/09/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var singleScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var occupationTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var additionalNotesTextField: UITextField!
    
    @IBOutlet weak var saveContactButton: UIButton!
    
    let DEFAULTSTATE = 0, EMPTYSTRING = 1
   
    var name = false, phone = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singleScrollView.contentSize = contentView.frame.size
        singleScrollView.backgroundColor = UIColor.clear
        someUIchores()
        assigntag()

        nameTextField.becomeFirstResponder()
    }
    
    @IBAction func saveContactPressed(_ sender: UIButton) {
        if(nameTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            print("name empty")
            setBottomLine_label_color(EMPTYSTRING,nameTextField)
        } else {name = true}
        if(phoneNumberTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            print("phone empty")
            setBottomLine_label_color(EMPTYSTRING,phoneNumberTextField)
        } else {phone = true}
        
        if (name && phone){
            self.performSegue(withIdentifier: "unwindAfterAdding", sender: self)
        }
        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

    //// chores
    override func viewDidAppear(_ animated: Bool) {
        someUIchores()
    }
    func someUIchores(){
        addUnderlineLinetoTextField(nameTextField)
        addUnderlineLinetoTextField(phoneNumberTextField)
        addUnderlineLinetoTextField(emailTextField)
        addUnderlineLinetoTextField(occupationTextField)
        addUnderlineLinetoTextField(addressTextField)
        addUnderlineLinetoTextField(additionalNotesTextField)
        
        saveContactButton.layer.borderColor = UIColor.init(red: 13/255, green: 174/255, blue: 156/255, alpha: 1).cgColor
    }
    
    func assigntag(){
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        occupationTextField.delegate = self
        addressTextField.delegate = self
        additionalNotesTextField.delegate = self
        
        nameTextField.tag = 0
        phoneNumberTextField.tag = 1
        emailTextField.tag = 2
        occupationTextField.tag = 3
        addressTextField.tag = 4
        additionalNotesTextField.tag = 5
    }
    
    // UI design draw the text field with no border but a line
    func chgUnderlineColor(_ textFieldbyUser: UITextField!,_ color: CGColor){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textFieldbyUser.frame.height-2, width: textFieldbyUser.frame.width, height: 1)
        bottomLine.backgroundColor = color
        textFieldbyUser.borderStyle = .none
        textFieldbyUser.layer.addSublayer(bottomLine)
    }
    
    
    func addUnderlineLinetoTextField(_ textFieldbyUser: UITextField!){
        let color = UIColor.init(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        chgUnderlineColor(textFieldbyUser, color)
    }
    
    func setBottomLine_label_color(_ colorType:Int, _ textFieldbyUser: UITextField!){
        var color: CGColor!
        switch colorType {
        case EMPTYSTRING:
            color = UIColor.init(red: 255/255, green: 0/255, blue: 0/255, alpha: 1).cgColor //make the line red color
        default:
            color = UIColor.init(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).cgColor
        }
        chgUnderlineColor(textFieldbyUser, color)
    }
    
    func textField(_ textField: UITextField,shouldChangeCharactersIn range: NSRange,replacementString string: String) -> Bool{
        // change back to grey color when user typing
        if textField == nameTextField{
            setBottomLine_label_color(DEFAULTSTATE, nameTextField)
        } else if textField == phoneNumberTextField{
            setBottomLine_label_color(DEFAULTSTATE, phoneNumberTextField)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField{
            nextField.becomeFirstResponder()
        }else {
            textField.resignFirstResponder()
        }
        return false
    }

}
