//
//  AppDelegate.swift
//  FlutterHost
//
//  Created by Evgeniy Safronov on 30.06.2020.
//  Copyright © 2020 iSuperCitizen. All rights reserved.
//

import UIKit
import Flutter
import FlutterPluginRegistrant

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var engine: FlutterEngine!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        engine = FlutterEngine(name: "engine");
        engine.run()
        GeneratedPluginRegistrant.register(with: engine)
        
        return true
    }
    
    static var instance: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
}

