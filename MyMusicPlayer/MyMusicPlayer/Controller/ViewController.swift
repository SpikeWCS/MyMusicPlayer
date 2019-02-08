//
//  ViewController.swift
//  MyMusicPlayer
//
//  Created by 王春杉 on 2019/1/30.
//  Copyright © 2019 王春杉. All rights reserved.
//

import UIKit

struct Device {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

class ViewController: UIViewController {
    
    var accountLable: UILabel? = UILabel()
    var accountField: UITextField?
    var passwordLable: UILabel? = UILabel()
    var passwordField: UITextField?
    var loginBtn: UIButton?
    var loginInfo: Login!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        setLable()
        setTextField()
        loginBtn = UIButton(frame: CGRect(x: Device.width/2, y: Device.height/3 + 100, width: 50, height: 30))
        loginBtn?.setTitle("登录", for: .normal)
        loginBtn?.setTitleColor(.black, for: .normal)
        self.view.addSubview(loginBtn!)
        loginBtn?.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    func setLable() {
        accountLable?.frame = CGRect(x: Device.width/3, y: Device.height/3, width: 48, height: 30)
        accountLable?.backgroundColor = .white
        accountLable?.text = "账号: "
        self.view.addSubview(accountLable!)
        
        passwordLable?.frame = CGRect(x: Device.width/3, y: Device.height/3 + 40, width: 48, height: 30)
        passwordLable?.backgroundColor = .white
        passwordLable?.text = "密码: "
        self.view.addSubview(passwordLable!)
    }
    
    func setTextField() {
        accountField = UITextField(frame: CGRect(x: Device.width/3 + 48, y: Device.height/3, width: 150, height: 30))
        accountField?.borderStyle = .roundedRect
//        accountField?.layer.masksToBounds = true  // 为了修改圆角半径
//        accountField?.layer.borderWidth = 1.5     // 边框加粗
        accountField?.placeholder = "请输入用户名"
        // 文字大小超过文本框长度时自动缩小字号，而不是隐藏显示省略号
        accountField?.adjustsFontSizeToFitWidth = true  // 当文字超出文本框宽度时，自动调整文字大小
        accountField?.minimumFontSize=14  // 最小可缩小的字号
        accountField?.textAlignment = .left // 水平局左对齐
        accountField?.contentVerticalAlignment = .center // 垂直居中对齐
        accountField?.clearButtonMode = .always  // 清除按钮：一直显示
        self.view.addSubview(accountField!)
        accountField?.keyboardType = .default // 键盘类型
        accountField?.returnKeyType = .done
        accountField?.delegate = self
        
        passwordField = UITextField(frame: CGRect(x: Device.width/3 + 48, y: Device.height/3 + 40, width: 150, height: 30))
        passwordField?.borderStyle = .roundedRect
        passwordField?.placeholder = "请输入密码"
        passwordField?.adjustsFontSizeToFitWidth = true  // 当文字超出文本框宽度时，自动调整文字大小
        passwordField?.minimumFontSize = 14  // 最小可缩小的字号
        passwordField?.textAlignment = .left // 水平局左对齐
        passwordField?.contentVerticalAlignment = .center // 垂直居中对齐
        passwordField?.clearButtonMode = .always  // 清除按钮：一直显示
        self.view.addSubview(passwordField!)
        passwordField?.keyboardType = .default // 键盘类型
        passwordField?.returnKeyType = .done
        passwordField?.isSecureTextEntry = true //输入内容会显示成小黑点
        passwordField?.delegate = self
    }
    
    @objc func login() {
        LoginInfoByPhone.phoneNum = (accountField?.text)!
        LoginInfoByPhone.password = (passwordField?.text)!
        LoginHelper.loginByPhone(success: { loginInfo in
            self.loginInfo = loginInfo
            print("登录被点击了！")
            print("登陆成功：\(loginInfo.profile.nickname)")
            LoginInfoByPhone.userId = loginInfo.profile.userID
            self.navigationController?.pushViewController(MainController(), animated: true)
        }) { _ in
            
        }
        
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        accountField?.resignFirstResponder()    // 使文本框失去焦点，并收回键盘
        passwordField?.resignFirstResponder()
        return true
    }
}
