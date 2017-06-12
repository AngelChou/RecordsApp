//
//  LoginViewController.swift
//  GameRecords
//
//  Created by Shun-Ching, Chou on 2017/6/8.
//  Copyright © 2017年 Shun-Ching, Chou. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMsgLabel: UILabel!
    
    // MARK: - Variable
    var isLoginSuccess = false
    
    // MARK: - UIViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorMsgLabel.alpha = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        errorMsgLabel.alpha = 0
        errorMsgLabel.text = ""
        usernameTextField.text = ""
        passwordTextField.text = ""
        usernameTextField.layer.borderWidth = 0.0
        passwordTextField.layer.borderWidth = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func loginButtonClicked(_ sender: Any) {
        if validateLoginInfo() {
            
            // check if email has been verified
            guard CoreDataManager.isEmailVerified(usernameTextField.text!) else {
                showErrorMsg(msg: "電子郵件信箱尚未驗證", textfield: nil)
                return
            }
            
            // TODO: enter dashboard
            isLoginSuccess = true
//            showErrorMsg(msg: "登入成功", textfield: nil)
            
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
    func validateLoginInfo() -> Bool {
        
        // check not empty
        guard !usernameTextField.text!.isEmpty else {
            showErrorMsg(msg: "請輸入帳號", textfield: usernameTextField)
            return false
        }
        
        guard !passwordTextField.text!.isEmpty else {
            showErrorMsg(msg: "請輸入密碼", textfield: passwordTextField)
            return false
        }
        
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        // check user input data correctness
        guard CoreDataManager.isLoginSuccess(username: username, password: password) else {
            print("no match data")
            showErrorMsg(msg: "帳號密碼錯誤", textfield: nil)
            return false
        }
        
        return true
    }
    
    func showErrorMsg(msg: String, textfield: UITextField?) {
        if textfield != nil {
            textfield!.layer.borderColor = UIColor.red.cgColor
            textfield!.layer.borderWidth = 1.0
        }
        
        errorMsgLabel.alpha = 1
        errorMsgLabel.text = msg
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "signUp" || identifier == "forgetPassword" {
            print("enable segue")
            return true
        }
        guard isLoginSuccess && identifier == "showDashboard" else {
            print("disable segue")
            return false
        }
        
        return true
        
    }
    

}
