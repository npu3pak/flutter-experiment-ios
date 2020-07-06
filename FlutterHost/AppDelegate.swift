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
    
    private let flutterModule = FlutterModule()
    private var rootCoordinator: NativeCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        flutterModule.startEngine()
        let rootNavigationController = UINavigationController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        
        rootCoordinator = NativeCoordinator(rootNavigationController: rootNavigationController, flutterModule: flutterModule)
        rootCoordinator!.start()
        
        return true
    }
}

