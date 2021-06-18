//
//  ViewController.swift
//  WebsocketApp
//
//  Created by Tushar Kalra on 16/06/21.
//

import UIKit
import WebsocketLauncher

class ViewController: UIViewController {
    
    var launcher = Launcher()

    
    private let launchButton: UIButton = {
        let launchButton = UIButton()
        launchButton.setTitle("Launch", for: .normal)
        launchButton.setTitleColor(.white, for: .normal)
        launchButton.backgroundColor = .systemTeal
        launchButton.layer.cornerRadius = 12
        launchButton.addTarget(self, action: #selector(launch), for: .touchUpInside)
        return launchButton
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(launchButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        launchButton.frame = CGRect(x: view.frame.midX - 50, y: view.frame.midY - 50, width: 100, height: 100)
        
    }
    
    @objc func launch(){
        print("launching...")
        launcher.launch()
        
        let vc = LaunchedViewController()
        vc.launcher = launcher
        present(vc, animated: true)
        
    }
    
}


extension UIView {
    
    public var width: CGFloat{
        return self.frame.size.width
    }
    public var height: CGFloat{
        return self.frame.size.height
    }
    public var top: CGFloat{
        return self.frame.origin.y
    }
    public var bottom: CGFloat{
        return self.frame.size.height + self.frame.origin.y
    }
    public var left: CGFloat{
        return self.frame.origin.x
    }
    
    public var right: CGFloat{
        return self.frame.size.width + self.frame.origin.x
    }
}
