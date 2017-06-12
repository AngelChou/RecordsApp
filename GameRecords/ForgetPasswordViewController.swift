//
//  ForgetPasswordViewController.swift
//  GameRecords
//
//  Created by Shun-Ching, Chou on 2017/6/10.
//  Copyright © 2017年 Shun-Ching, Chou. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var errorMsgLabel: UILabel!
    
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
    
    @IBAction func SendEmailClicked(_ sender: Any) {
        if validateTextFieldContent() {
            // TODO: send update password email
            showAlert(alertTitle: "發送新密碼", alertMessage: "新密碼已寄至您的電子郵件信箱，請使用新密碼重新登入，謝謝！")
        }
    }
    @IBAction func usernameTextFieldClicked(_ sender: Any) {
        usernameTextField.layer.borderWidth = 0.0
        errorMsgLabel.alpha = 0
        errorMsgLabel.text = ""
    }
    
    // MARK: - Functions
    
    func validateTextFieldContent() -> Bool {
        // is textfield empty
        guard !usernameTextField.text!.isEmpty else {
            showErrorMsg(msg: "請輸入帳號", textfield: usernameTextField)
            return false
        }
        
        let username = usernameTextField.text!
        
        // is email format correct
        guard CommonFunction.checkEmailFormat(username) else {
            showErrorMsg(msg: "無效的電子郵件信箱", textfield: usernameTextField)
            return false
        }
        
        // is email exist
        if !CoreDataManager.isEmailExist(username) {
            showErrorMsg(msg: "此電子郵件信箱未註冊", textfield: usernameTextField)
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
