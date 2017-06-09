//
//  RegisterViewController.swift
//  GameRecords
//
//  Created by Shun-Ching, Chou on 2017/6/8.
//  Copyright © 2017年 Shun-Ching, Chou. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMsgLabel: UILabel!
    
    // MARK: - Variables
    
    var username: String = ""
    var password: String = ""
    
    // MARK: - UIViewController Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        resetErrorMsg()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func signUpButtonClick(_ sender: Any) {
        if check() {
            // create new account in core data
            let viewContext = CoreDataManager.getViewContext()
            
            let newAccount = NSEntityDescription.insertNewObject(forEntityName: "Users", into: viewContext) as! Users
            
            newAccount.username = username
            newAccount.password = password
            newAccount.emailVerified = false
            
            do{
                try viewContext.save()
            }
            catch{
                print("Could not save \(error)")
            }

            
            
            // TODO: send verify email
//            sendEmail()
            showAlert(alertTitle: "建立帳號成功！", alertMessage: "驗證信已寄至您的電子郵件信箱，請至電子郵件信箱完成驗證動作，謝謝！")
        }
    }
    
    @IBAction func usernameTextFieldClick(_ sender: Any) {
        usernameTextField.layer.borderWidth = 0.0
        resetErrorMsg()
    }
    
    @IBAction func passwordTextFieldClick(_ sender: Any) {
        passwordTextField.layer.borderWidth = 0.0
        resetErrorMsg()
    }
    // MARK: - Functions
    
    func check() -> Bool {
        // check not empty
        guard !usernameTextField.text!.isEmpty else {
            showErrorMsg(msg: "帳號爲必填欄位", textfield: usernameTextField)
            return false
        }
        
        guard !passwordTextField.text!.isEmpty else {
            showErrorMsg(msg: "密碼爲必填欄位", textfield: passwordTextField)
            return false
        }
        
        username = usernameTextField.text!
        password = passwordTextField.text!
        
        // check email format
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = username as NSString
            let results = regex.matches(in: username, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                showErrorMsg(msg: "無效的電子郵件信箱", textfield: usernameTextField)
                return false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
        
        // check password format
        let passwordRegEx = "(?=.*[a-zA-Z])(?=.*[0-9]).{8,}"
        
        do {
            let regex = try NSRegularExpression(pattern: passwordRegEx)
            let nsString = password as NSString
            let results = regex.matches(in: password, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                showErrorMsg(msg: "密碼必須爲8位以上英數字混合", textfield: passwordTextField)
                return false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
        
        // TODO: check not duplicate
        
        return true
    }
    
    func resetErrorMsg() {
        errorMsgLabel.alpha = 0
        errorMsgLabel.text = ""
    }
    
    func showErrorMsg(msg: String, textfield: UITextField) {
        textfield.layer.borderColor = UIColor.red.cgColor
        textfield.layer.borderWidth = 1.0
        errorMsgLabel.alpha = 1
        errorMsgLabel.text = msg
    }
    
    func showAlert (alertTitle: String, alertMessage: String){
        let alert = UIAlertController(title: alertTitle, message: "\(alertMessage)", preferredStyle: UIAlertControllerStyle.alert)
        let ok: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.dismiss(animated: true, completion: nil)
            })
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
