//
//  NewGameViewController.swift
//  GameRecords
//
//  Created by Shun-Ching, Chou on 2017/6/7.
//  Copyright © 2017年 Shun-Ching, Chou. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var gameNameTextField: UITextField!
    @IBOutlet weak var vistingTeamNameTextField: UITextField!
    
    // MARK: - Class Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    
    @IBAction func StartNewGameButtonPressed(_ sender: Any) {
        let gameName = gameNameTextField.text
        let vistingTeamName = vistingTeamNameTextField.text
        
        print("Game Name: \(gameName)")
        print("Visting Team Name: \(vistingTeamName)")
        
        
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
