//
//  AppDelegate.swift
//  KiddiesAhead
//
//  Created by sts on 3/3/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications
import SwiftyStoreKit

var g_user = UserModel()
var g_start : TimeInterval = 0


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        UIApplication.shared.isIdleTimerDisabled = true
        ProgressHUD.initHUD()
        
        setupIAP()
        //loadProducts()
        
        return true
    }
    
    func setupIAP() {
        
        SwiftyStoreKit.completeTransactions(atomically: true, completion: {products in
            
            for product in products {
                
                if product.transaction.transactionState == .purchased || product.transaction.transactionState == .restored {
                    
                    if product.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(product.transaction)
                    }
                }
            }
        })
    }
    
    func loadProducts() {
        
        let productsIds = Set([k1Lang1Month, k2Lang1Month, k3Lang1Month, k4Lang1Month, k1Lang1Year, k2Lang1Year, k3Lang1Year, k4Lang1Year])
        
        SwiftyStoreKit.retrieveProductsInfo(productsIds, completion: {result in
            
            for product in result.retrievedProducts {
                
                
                print("\(product.localizedTitle), \(product.localizedPrice!), \(product.price)")
            }
            
            print(result)
            
        })
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        if g_user._id == 0 {
            return 
        }
        
        let current = Date()
        let spent = current.timeIntervalSince1970 - g_start
        let mins = Int(spent / 60.0) + 1
        g_user._spentMins += mins
        g_user._lastSpent = current
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let last_spent = formatter.string(from: current)
        
        ApiManager.sharedManager.saveSpent(userId:g_user._id, spent:g_user._spentMins, last_spent:last_spent) { (success, data) in
            
        }
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        let current = Date()
        g_start = current.timeIntervalSince1970
        
        if g_user._id == 0 {
            return
        }
        
        let currentWeek = Calendar.current.component(.weekOfYear, from: current)
        let lastWeek = Calendar.current.component(.weekOfYear, from: g_user._lastSpent)
        
        if currentWeek != lastWeek {
            g_user._spentMins = 0
            g_user._lastSpent = current
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        

    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        //let aps = userInfo["aps"] as! [String: AnyObject]
        
        completionHandler()
    }
}

