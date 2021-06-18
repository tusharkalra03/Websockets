//
//  LaunchedViewController.swift
//  WebsocketApp
//
//  Created by Tushar Kalra on 16/06/21.
//

import UIKit
import WebsocketLauncher

class LaunchedViewController: UIViewController {
    
    var launcher: Launcher!
    
    
    
    private let textlabel: UILabel = {
        let textlabel = UILabel()
        textlabel.text = "Send message"
        textlabel.textColor = .black
        textlabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        textlabel.numberOfLines = 2
        return textlabel
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemTeal
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Disconnect", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(disconnect), for: .touchUpInside)
        return button
    }()
    
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 2
        textField.placeholder = "Enter message"
        textField.setLeftPaddingPoints(8)
        textField.setRightPaddingPoints(8)
        return textField
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(textlabel)
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(cancelButton)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = view.width
        
        textlabel.frame = CGRect(x: view.left + 16, y: view.top + 100, width: size - 32, height: 100)
        textField.frame = CGRect(x: view.left + 16, y: textlabel.bottom + 20, width: size - 32, height: 50)
        button.frame = CGRect(x: view.left + 16, y: textField.bottom + 20, width: size - 32, height: 50)
        cancelButton.frame = CGRect(x: view.left + 16, y: button.bottom + 20, width: size - 32, height: 50)
        
    }
    
    @objc func sendMessage(){
        let message = textField.text ?? "hello"
        print("sending...")
        
        launcher.sendMessage(message: message){ output in
            
            DispatchQueue.main.async {
                
    
            switch output{
            
            case .failure(let error):
                let alert = UIAlertController(title: "Error sending", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
                
            case .success(_):
                
                self.launcher.recieveMessage(){ output in
                    
                    
                    DispatchQueue.main.async {
                        
                        switch output{
                        case .success(let string):
                            let alert = UIAlertController(title: "Message Recieved", message: string, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(alert, animated: true)
                            
                        case .failure(let error):
                            let alert = UIAlertController(title: "Error recieving", message: error.localizedDescription, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(alert, animated: true)
                            
                        }
                    }
                }
            }
            
        }
            
        }
    }
    
    
    
    @objc func disconnect(){
            launcher.disconnect()
            self.dismiss(animated: true)
        }
        
        
    }
    
    
    extension UITextField {
        func setLeftPaddingPoints(_ amount:CGFloat){
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        func setRightPaddingPoints(_ amount:CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
