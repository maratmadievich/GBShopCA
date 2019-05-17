//
//  AppDelegate.swift
//  GBShop
//
//  Created by Марат Нургалиев on 18/04/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let requestFactory = RequestFactory()

   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureKeyboard()
        
        showLogin()
        
        return true
    }
    
    
    private func configureKeyboard() {
        
        IQKeyboardManager.shared.enable = true
        
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    
    private func showLogin() {
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "LoginStart")
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window?.rootViewController = rootViewController
        
        self.window?.makeKeyAndVisible()
    }
    
    
    private func tryChangeUserData() {
        
        let profile = requestFactory.makeChangeProfileRequestFatory()
        
        profile.changeProfile(idUser: 123, userName: "maratmadievich", password: "geekbrains", email: "my@gmail.com", gender: "m", creditCard: "1234-1234-1234-1234", bio: "Some text") { response in
            
            switch response.result {
                
            case .success(let profile):
                
                print(profile)
                
            case .failure(let error):
                
                print(error.localizedDescription)
            }
            
        }
        
    }
    
//    func applicationWillResignActive(_ application: UIApplication) {
//        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//    }
//
//    func applicationDidEnterBackground(_ application: UIApplication) {
//        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    }
//
//    func applicationWillEnterForeground(_ application: UIApplication) {
//        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    }
//
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    }
//
//    func applicationWillTerminate(_ application: UIApplication) {
//        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    }


}

