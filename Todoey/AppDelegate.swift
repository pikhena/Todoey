//
//  AppDelegate.swift
//  Todoey
//
//  Created by Priscilla Ikhena on 18/04/2019.
//  Copyright © 2019 Priscilla Ikhena. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      
      // print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm() //initializing new realm. you can use underscore cause you don't use the variable name
            
        } catch {
            print("Error intialising new realm, \(error)")
        }
        
        
        return true
    }


    
   
    


}

