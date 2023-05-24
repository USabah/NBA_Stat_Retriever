//
//  registrationViewController.swift
//  NBA-Stat-Getter
//
//  Created by Uriya Sabah on 5/22/23.
//

import UIKit

class RegistrationViewController: UIViewController, AuthDelegate {
    
    var auth_brain : AuthModel = AuthModel()
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        auth_brain.delegate = self
        emailTextField.placeholder = "Enter Email"
        passwordTextField.placeholder = "Enter Password"
        passwordTextField.isSecureTextEntry = true
    }
    
    func signInSuccess() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let queryViewController = storyboard.instantiateViewController(withIdentifier: "QueryViewController") as! QueryViewController
        queryViewController.navigationItem.setHidesBackButton(true, animated: false)
        let navigationController = UINavigationController(rootViewController: queryViewController)
        self.view.window?.rootViewController = navigationController
    }
    
    //empty stub
    func signInFailure(error: AuthError){
    }
    
    func registerFailure(error: AuthError) {
        switch error{
        case AuthError.EmptyText:
            let myAlert = UIAlertController(title: "Fields Are Blank", message: "Please fill in the email and password fields above.", preferredStyle: .alert)
            myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(myAlert, animated: true, completion: nil)
        case AuthError.MiscError(let error):
            let myAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            
            myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(myAlert, animated: true, completion: nil)
        default:
            let myAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            
            myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(myAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func registerButtonPress(_ sender: UIButton) {
        auth_brain.userAccountCreation(email: emailTextField.text, password: passwordTextField.text)
    }
    
    @IBAction func signInPageButtonPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
