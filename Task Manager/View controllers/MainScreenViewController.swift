//
//  ViewController.swift
//  Task Manager
//
//  Created by Наталья Шарапова on 03.02.2022.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var signInAccountLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var youreNewHereLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.isEnabled = false
        
        nameLabel.frame = CGRect(x: 40, y: 330, width: 300, height: 80)
        nameLabel.text = "Task Manager"
        nameLabel.font = UIFont(name: "Gill Sans", size: 40)
        
        descriptionLabel.frame = CGRect(x: 40, y: 364, width: 300, height: 80)
        descriptionLabel.text = "Organize your works"
        descriptionLabel.font = UIFont(name: "Gill Sans", size: 18)
        
        signInAccountLabel.frame = CGRect(x: view.bounds.midX - 73, y: 460, width: 300, height: 25)
        signInAccountLabel.text = "Sign in to your account"
        signInAccountLabel.font = UIFont(name: "Gill Sans", size: 15)
        signInAccountLabel.textColor = .gray
        
        userNameTextField.frame = CGRect(x: view.bounds.midX - 175, y: 488, width: 350, height: 42)
        userNameTextField.placeholder = "Username"
        
        passwordTextField.frame = CGRect(x: view.bounds.midX - 175, y: 540, width: 350, height: 42)
        passwordTextField.placeholder = "Password"
        
        youreNewHereLabel.frame = CGRect(x: 123, y: 840, width: 150, height: 25)
        youreNewHereLabel.text = "You're new here?"
        youreNewHereLabel.font = UIFont(name: "Gill Sans", size: 17)
        youreNewHereLabel.textColor = .gray
        
        signInButton.backgroundColor = .black
        signInButton.alpha = 0.7
        signInButton.layer.cornerRadius = 20
        signInButton.tintColor = .white
        signInButton.titleLabel?.font = UIFont(name: "Gill Sans", size: 20)
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = UIColor.white.cgColor
        signInButton.frame = CGRect(x: view.bounds.midX - 150, y: 730, width: 300, height: 60)
        signInButton.setTitle("Sign in", for: .normal)
        
        UIButton.animate(withDuration: 2, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction]) {
            self.signInButton.backgroundColor = .cyan
        }
        
        signUpButton.titleLabel?.font = UIFont(name: "Gill Sans", size: 19)
        signUpButton.frame = CGRect(x: 178, y: 839, width: 200, height: 25)
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.tintColor = .black
    }
    
    // MARK: - Actions
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        signInButton.isEnabled = true
    }
    
    @IBAction func gesture(_ sender: UITapGestureRecognizer) {
        
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        
        guard let userName = userNameTextField.text else {
            return
        }
        guard let passwordData = passwordTextField.text else {
            return
        }
        
        let userPassword = String(describing: passwordData)
        
        for (password, name) in namesAndPasswords {
            
            if name == userName && password == userPassword {
                
                performSegue(withIdentifier: "GoToTasks", sender: nil)
                
            } else {
                
                let alert = UIAlertController(title: "Incorrect login or password ", message: "Please check login and password", preferredStyle: UIAlertController.Style.alert)
                
                let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                alert.addAction(action)
                
                present(alert, animated: true)
            }
        }
    }
}
