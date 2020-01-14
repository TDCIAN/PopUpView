//
//  ViewController.swift
//  PopUpWindow
//
//  Created by hexlant_01 on 2020/01/14.
//  Copyright © 2020 hexlant_01. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    // MARK: - Properties
    var success = true
    
    lazy var popUpWindow: PopUpWindow = {
        let view = PopUpWindow()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.delegate = self
        return view
    }()
    
    // 블러처리 이펙트
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Show Pop Up Window", for: .normal)
        button.setTitleColor(UIColor.mainBlue(), for: .normal)
        button.addTarget(self, action: #selector(handleShowPopUp), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5 // 버튼 모서리를 둥글게
        return button
    }()

    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.mainBlue()
        
        // 이거 고쳐봐
        view.addSubview(button)
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        
        // 블러처리 만들어주는 뷰
        view.addSubview(visualEffectView)
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0 // 알파값을 0을 줬기 때문에 보이지 않는다

    }
    
    // 버튼 누르면 팝업 튀어나옴
    @objc func handleShowPopUp() {
        // 이거 고쳐봐
        view.addSubview(popUpWindow)
        popUpWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        popUpWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUpWindow.heightAnchor.constraint(equalToConstant: 700).isActive = true
        popUpWindow.widthAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        
        // 성공과 실패가 번갈아가면서 나오게 해주는 코드
        popUpWindow.showSuccessMessage = success
        success = !success
        
        popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpWindow.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.popUpWindow.alpha = 1
            self.popUpWindow.transform = CGAffineTransform.identity
        }
    }
}

extension ViewController: PopUpDelegate {
    func handleDismissal() {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.popUpWindow.alpha = 0
            self.popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpWindow.removeFromSuperview()
            print("Did remove pop up window...")
        }
    }
    
    
}

extension UIColor {
    static func mainBlue() -> UIColor {
        return UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    }
}

