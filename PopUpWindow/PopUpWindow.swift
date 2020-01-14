//
//  PopUpWindow.swift
//  PopUpWindow
//
//  Created by hexlant_01 on 2020/01/14.
//  Copyright © 2020 hexlant_01. All rights reserved.
//

import UIKit

protocol PopUpDelegate {
    func handleDismissal()
}

class PopUpWindow: UIView {
    
    // MARK: - Properties
    
    var delegate: PopUpDelegate?
    
    // 성공했냐 실패했냐에 따라 보여주는 결과가 다르게 만들어주기
    var showSuccessMessage: Bool? {
        didSet {
            guard let success = showSuccessMessage else { return }
            if success {
                checkLabel.text = "✔"
                notificationLabel.text = "Success"
                checkLabel.textColor = UIColor(red: 147/255, green: 227/255, blue: 105/255, alpha: 1)
            } else {
                checkLabel.text = "X"
                notificationLabel.text = "Error"
                checkLabel.textColor = .red
            }
        }
    }
    
    // 체크마크 레이블
    let checkLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 96)
        label.text = "✔"
        return label
    }()
    
    // Success 또는 Error 메시지
    let notificationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 24)
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.mainBlue()
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 버튼 눌렀을 때 튀어나오는 뷰의 색깔
        backgroundColor = .white
        
        addSubview(checkLabel)
        checkLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -28).isActive = true
        checkLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(notificationLabel)
        notificationLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        notificationLabel.topAnchor.constraint(equalTo: checkLabel.bottomAnchor, constant: 0).isActive = true
        
        addSubview(button)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func handleDismissal() {
        delegate?.handleDismissal()
    }
}
