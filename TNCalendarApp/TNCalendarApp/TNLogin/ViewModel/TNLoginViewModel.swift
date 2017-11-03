//
//  TNLoginViewModel.swift
//  TNCalendarApp
//
//  Created by 涂育旺 on 2017/10/18.
//  Copyright © 2017年 com.person. All rights reserved.
//

import RxSwift
import RxDataSources

class TNLoginViewModel: NSObject {
    
    var isLogin: Bool?
    var userHeadImage: UIImage?
    var userName: String?
    var password: String?
    var items: Observable<[String]>!
    
    var loginviewController: TNLoginViewController!
    
    
    init(viewController: TNLoginViewController) {
        
        super.init()
        
        loginviewController = viewController
        items = Observable.just(["SIGN IN", "NEW ACCOUNT"])
        
        //get userInfo from disk
        
        //get default info
        
        
    }
    
    public func SignIn() {
    
        var name = Visitor().name
        var password = Visitor().password
        
        if let user = BmobUser.current() {
            name = user.username
            password = user.object(forKey: "password") as! String
        }
        
        //request
        BmobUser.loginWithUsername(inBackground: name, password: password) { (userInfo, error) in
            guard error == nil else {
                
                //show tip
                print(error?.localizedDescription)
                return
            }

            guard UIApplication.shared.keyWindow?.rootViewController == TNLoginViewController.shared else {
                TNLoginViewController.shared.dismiss(animated: true, completion: nil)
                return
            }
            UIApplication.shared.keyWindow?.rootViewController = MPDTabBarViewController()

        }
    }
    
    public func NewAccount() {
        let registerViewController = TNRegisterViewController(type: .close)
        loginviewController.present(registerViewController.pushNavigationController(), animated: true, completion: nil)
    }
    
}
