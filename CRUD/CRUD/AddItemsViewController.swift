//
//  AddItemsViewController.swift
//  CRUD
//
//  Created by Nitesh Parihar on 09/03/19.
//  Copyright © 2019 Nitesh Parihar. All rights reserved.
//

import UIKit

class AddItemsViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var nameTxtFld: UITextField!
    @IBOutlet weak var addressTxtView: UITextView!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var mobileTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressTxtView.layer.borderColor = UIColor.lightGray.cgColor
        addressTxtView.layer.borderWidth = 1
        
    }
    

    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        
        if self.validateFeilds() {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newEntry = Store(context: context)
            newEntry.name = nameTxtFld.text
            newEntry.address = addressTxtView.text
            newEntry.email = emailTxtFld.text
            newEntry.mobile = mobileTxtFld.text
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            dismiss(animated: true, completion: nil)
        }
        

       
    }
    
    func validateFeilds() -> Bool{
        //validatind first name
        if nameTxtFld.text == ""{
            let alert = UIAlertController(title: "", message: "Please enter name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ (UIAlertAction)in
                self.nameTxtFld.becomeFirstResponder()
            }))
            self.present(alert, animated: true, completion: {})
            return false
        }else{
            let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
            if nameTxtFld.text!.rangeOfCharacter(from: characterset.inverted) != nil {
                let alert = UIAlertController(title: "", message: "Please enter valid name", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ (UIAlertAction)in
                    self.nameTxtFld.becomeFirstResponder()
                }))
                self.present(alert, animated: true, completion: {})
                return false
            }else{
                //validatind email
                if emailTxtFld.text == ""{
                    let alert = UIAlertController(title: "", message: "Please enter email", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ (UIAlertAction)in
                        self.emailTxtFld.becomeFirstResponder()
                    }))
                    self.present(alert, animated: true, completion: {})
                    return false
                }else {
                    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
                    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                    if !emailTest.evaluate(with:emailTxtFld.text!){
                        let alert = UIAlertController(title: "", message: "Please enter valid email", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ (UIAlertAction)in
                            self.emailTxtFld.becomeFirstResponder()
                        }))
                        self.present(alert, animated: true, completion: {})
                        return false
                    }else{
                        //validatind mobile
                        if mobileTxtFld.text == ""{
                            let alert = UIAlertController(title: "", message: "Please enter mobile number", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ (UIAlertAction)in
                                self.mobileTxtFld.becomeFirstResponder()
                            }))
                            self.present(alert, animated: true, completion: {})
                            return false
                        }else{
                            if mobileTxtFld.text!.characters.count != 10 {
                                let alert = UIAlertController(title: "", message: "Please enter 10 digit mobile number", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ (UIAlertAction)in
                                    self.mobileTxtFld.becomeFirstResponder()
                                }))
                                self.present(alert, animated: true, completion: {})
                                return false
                            }
                            else{
                                
                                    
                                }
                            }
                        }
                    }
                }
            }
         return true
        }
    
    }

