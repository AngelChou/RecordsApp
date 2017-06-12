//
//  RegisterViewController.swift
//  GameRecords
//
//  Created by Shun-Ching, Chou on 2017/6/8.
//  Copyright © 2017年 Shun-Ching, Chou. All rights reserved.
//

import UIKit

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
        errorMsgLabel.alpha = 0
        errorMsgLabel.text = ""

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonClick(_ sender: Any) {
        if validateTextFieldContent() {
            // create new account in core data
            if CoreDataManager.createNewUser(username: username, password: password) {
                showAlert(alertTitle: "建立帳號成功！", alertMessage: "驗證信已寄至您的電子郵件信箱，請至電子郵件信箱完成驗證動作，謝謝！")
                // TODO: send verify email
            }
        }
    }
    
    @IBAction func usernameTextFieldClick(_ sender: Any) {
        usernameTextField.layer.borderWidth = 0.0
        errorMsgLabel.alpha = 0
        errorMsgLabel.text = ""
    }
    
    @IBAction func passwordTextFieldClick(_ sender: Any) {
        passwordTextField.layer.borderWidth = 0.0
        errorMsgLabel.alpha = 0
        errorMsgLabel.text = ""
    }
    
    // MARK: - Functions
    
    func validateTextFieldContent() -> Bool {
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
        guard CommonFunction.checkEmailFormat(username) else {
            showErrorMsg(msg: "無效的電子郵件信箱", textfield: usernameTextField)
            return false
        }
        
        // check password format
        guard CommonFunction.checkPasswordFormat(password) else {
            showErrorMsg(msg: "密碼必須爲8位以上英數字混合", textfield: passwordTextField)
            return false
        }
        
        
        // check email is not duplicate
        if CoreDataManager.isEmailExist(username) {
            showErrorMsg(msg: "此帳號已註冊", textfield: usernameTextField)
            return false
        }
       
        return true
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
