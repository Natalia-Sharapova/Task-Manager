//
//  SignUpViewController.swift
//  Task Manager
//
//  Created by Наталья Шарапова on 04.02.2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var alreadyHaveAnAccountLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var letsbeginLabel: UILabel!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letsbeginLabel.frame = CGRect(x: 40, y: 352, width: 300, height: 80)
        letsbeginLabel.text = "Let's begin?"
        letsbeginLabel.font = UIFont(name: "Gill Sans", size: 18)
        letsbeginLabel.textColor = .black
        
        signUpLabel.frame = CGRect(x: 40, y: 385, width: 300, height: 80)
        signUpLabel.text = "Create your account"
        signUpLabel.font = UIFont(name: "Gill Sans", size: 35)
        
        userNameTextField.frame = CGRect(x: view.bounds.midX - 175, y: 470, width: 350, height: 42)
        userNameTextField.placeholder = "Enter username"
        userNameTextField.borderStyle = .roundedRect
        
        passwordTextField.frame = CGRect(x: view.bounds.midX - 175, y: 532, width: 350, height: 42)
        passwordTextField.placeholder = "Enter password"
        
        signUpButton.backgroundColor = .black
        signUpButton.alpha = 0.7
        signUpButton.layer.cornerRadius = 20
        signUpButton.tintColor = .white
        signUpButton.titleLabel?.font = UIFont(name: "Gill Sans", size: 20)
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.white.cgColor
        signUpButton.frame = CGRect(x: view.bounds.midX - 150, y: 730, width: 300, height: 60)
        signUpButton.setTitle("Sign up", for: .normal)
        
        UIButton.animate(withDuration: 1, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction]) {
            self.signUpButton.backgroundColor = .red
        }
        
        alreadyHaveAnAccountLabel.frame = CGRect(x: 95, y: 840, width: 230, height: 25)
        alreadyHaveAnAccountLabel.text = "Already have an account?"
        alreadyHaveAnAccountLabel.font = UIFont(name: "Gill Sans", size: 17)
        alreadyHaveAnAccountLabel.textColor = .gray
        
        signInButton.titleLabel?.font = UIFont(name: "Gill Sans", size: 19)
        signInButton.frame = CGRect(x: 206, y: 839, width: 200, height: 25)
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.tintColor = .black
        
    }
    
    // MARK: - Actions
    
    @IBAction func nameTextFieldEdited(_ sender: UITextField) {
        
        guard let name = userNameTextField.text else {
            return
        }
        // Check if name contains numbers
        
        if name.allSatisfy( ("0"..."9").contains) {
            
            let alert = UIAlertController(title: "The name must contain only letters",
                                          message: "Please change the name",
                                          preferredStyle: UIAlertController.Style.alert)
            
            let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            alert.addAction(action)
            
            present(alert, animated: true)
        }
    }
    
    @IBAction func gesture(_ sender: UITapGestureRecognizer) {
        
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func passwordTextFieldEdited(_ sender: UITextField) {
        
        guard let password = passwordTextField.text else {
            return
        }
        
        // Check if password have less than 5 characters
        if password.count < 5 {
            let alert = UIAlertController(title: "The password must contain more than 4 characters", message: "Please change the password", preferredStyle: UIAlertController.Style.alert)
            
            let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            alert.addAction(action)
            
            present(alert, animated: true)
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
        guard let name = userNameTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        namesAndPasswords.updateValue(name, forKey: password)
    }
}

