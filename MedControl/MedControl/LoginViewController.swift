//
//  LoginViewController.swift
//  MedControl
//
//  Created by aluno on 22/09/15.
//  Copyright (c) 2015 Puc-CCE. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {
    
    func showAlertController(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func authenticateitouchID(sender: AnyObject) {
    
    
    // 1
    let context = LAContext()
    var error: NSError?
    
    // 2
    // check if Touch ID is available
    
   
    
    
    
    
    
    
    if context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
    // 3
        let reason = "Authenticate with Touch ID"
        context.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reason,
            reply: {(success: Bool, error: NSError?) in
                // 4
                if success {
                    self.showAlertController("Touch ID Authentication Succeeded")
                } else {
                    self.showAlertController("Touch ID Authentication Failed")
                }
        })
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
