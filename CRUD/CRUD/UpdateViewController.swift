//
//  UpdateViewController.swift
//  CRUD
//
//  Created by Nitesh Parihar on 09/03/19.
//  Copyright © 2019 Nitesh Parihar. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {

    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var addressTxtView: UITextView!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var mobileTxtFld: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var item: Store!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressTxtView.layer.borderColor = UIColor.lightGray.cgColor
        addressTxtView.layer.borderWidth = 1
        
        configureEntryData(entry: item)
        
    }
    
    @IBAction func updateBtnTapped(_ sender: Any) {
        
        if self.validateFeilds() {
            item.name = nameLbl.text
            item.address = addressTxtView.text
            item.email = emailTxtFld.text
            item.mobile = mobileTxtFld.text
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func configureEntryData(entry: Store) {
        
//        guard let text = entry.name else {
//            return
//        }
        
        nameLbl.text = entry.name
        addressTxtView.text =  entry.address
        emailTxtFld.text =  entry.email
        mobileTxtFld.text =  entry.mobile
        
    }

    func validateFeilds() -> Bool{
        //validatind first name
        if nameLbl.text == ""{
            let alert = UIAlertController(title: "", message: "Please enter name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ (UIAlertAction)in
                self.nameLbl.becomeFirstResponder()
            }))
            self.present(alert, animated: true, completion: {})
            return false
        }else{
            let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
            if nameLbl.text!.rangeOfCharacter(from: characterset.inverted) != nil {
                let alert = UIAlertController(title: "", message: "Please enter valid name", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ (UIAlertAction)in
                    self.nameLbl.becomeFirstResponder()
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
