//
//  AuthModel.swift
//  NBA-Stat-Getter
//
//  Created by Uriya Sabah on 5/22/23.
//

import UIKit
import FirebaseAuth

class AuthModel{
    
    var delegate: AuthDelegate?

    func userAccountCreation(email: String?, password: String?) {
        guard let emailText = email, let passwordText = password, !fieldsAreEmpty([emailText, passwordText]) else{
            self.delegate?.registerFailure(error: AuthError.EmptyText)
            return
        }
        
        //sign in with firebaseAuth
        var err : Error?
        
        FirebaseAuth.Auth.auth().createUser(withEmail: emailText, password: passwordText, completion: {result, error in
            guard error == nil else{
                err = error
                return
            }
            //sign-in is successful, call the delegate method
            self.delegate?.signInSuccess()
        })
        
        //check if account exists
        guard err == nil else{
            self.delegate?.registerFailure(error: AuthError.MiscError(err: err!))
            return
        }
    }
    
    func userSignIn(email: String?, password: String?) {
        guard let emailText = email, let passwordText = password, !fieldsAreEmpty([emailText, passwordText]) else{
            self.delegate?.signInFailure(error: AuthError.EmptyText)
            return
        }
        
        //sign in with firebaseAuth
        var err : Error?
        
        FirebaseAuth.Auth.auth().signIn(withEmail: emailText, password: passwordText, completion: {result, error in
            guard error == nil else{
                err = error
                return
            }
            
            //call signInSuccess method
            self.delegate?.signInSuccess()
        })
        
        //check if account exists
        guard err == nil else{
            self.delegate?.signInFailure(error: AuthError.AccountDoesNotExist)
            return
        }
        
        
    }
    
    func userSignOut() throws{
        do{
            try FirebaseAuth.Auth.auth().signOut()
        }
        catch {
            throw error
        }
    }
    
    //checks to see if at least one field is empty
    func fieldsAreEmpty(_ fields: [String]) -> Bool{
        for field in fields{
            if field.isEmpty{
                return true
            }
        }
        return false
    }
    
    func userIsSignedIn() -> Bool{
        return FirebaseAuth.Auth.auth().currentUser != nil
    }
}

protocol AuthDelegate {
    func signInSuccess()
    func signInFailure(error: AuthError)
    func registerFailure(error: AuthError)
}
