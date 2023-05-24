//
//  ViewController.swift
//  NBA-Stat-Getter
//
//  Created by Uriya Sabah on 5/4/23.
//

import UIKit

class SignInViewController: UIViewController, AuthDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var auth_brain : AuthModel = AuthModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if auth_brain.userIsSignedIn(){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let queryViewController = storyboard.instantiateViewController(withIdentifier: "QueryViewController") as! QueryViewController
            queryViewController.navigationItem.setHidesBackButton(true, animated: false)
            self.navigationController?.popViewController(animated: false)
            self.navigationController?.pushViewController(queryViewController, animated: false)
        }
        // Do any additional setup after loading the view.
        else{
            auth_brain.delegate = self
            emailTextField.placeholder = "Enter Email"
            emailTextField.autocapitalizationType = .none
            emailTextField.autocorrectionType = .no
            passwordTextField.placeholder = "Enter Password"
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    func signInSuccess() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let queryViewController = storyboard.instantiateViewController(withIdentifier: "QueryViewController") as! QueryViewController
        queryViewController.navigationItem.setHidesBackButton(true, animated: false)
        let navigationController = UINavigationController(rootViewController: queryViewController)
        self.view.window?.rootViewController = navigationController
    }
    
    func signInFailure(error: AuthError){
        switch error{
        case AuthError.EmptyText:
            let myAlert = UIAlertController(title: "Fields Are Blank", message: "Please fill in the email and password fields above.", preferredStyle: .alert)
            myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(myAlert, animated: true, completion: nil)
        default:
            let myAlert = UIAlertController(title: "Account Not Found", message: "Please re-enter your credentials or register at the registration page.", preferredStyle: .alert)
            
            myAlert.addAction(UIAlertAction(title: "Stay Here", style: .default, handler: nil))
            
            myAlert.addAction(UIAlertAction(title: "Register Account", style: .default){ (_) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let registrationViewController = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
                registrationViewController.navigationItem.setHidesBackButton(true, animated: false)
                self.navigationController?.pushViewController(registrationViewController, animated: true)
            })
            self.present(myAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func registrationPress(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registrationViewController = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        registrationViewController.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    @IBAction func signInPress(_ sender: UIButton) {
        auth_brain.userSignIn(email: emailTextField.text, password: passwordTextField.text)
    }
    
    //empty stub
    func registerFailure(error: AuthError) {
    }
}
    



