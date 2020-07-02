//
//  ViewController.swift
//  FlutterHost
//
//  Created by Evgeniy Safronov on 30.06.2020.
//  Copyright © 2020 iSuperCitizen. All rights reserved.
//

import UIKit
import Flutter
import FlutterPluginRegistrant

class ViewController: UIViewController {
    
    @IBAction func onShowScreenWithBrowser(_ sender: Any) {
        showFlutterModule(route: "browser")
    }

    @IBAction func onShowScreenWithText(_ sender: Any) {
        showFlutterModule(route: "text")
    }
    
    private func showFlutterModule(route: String) {
        let engine = AppDelegate.instance.engine!
        let controller = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
        controller.splashScreenView = UIView()
        controller.splashScreenView.backgroundColor = UIColor.white;
        let channel = FlutterMethodChannel(name: "channel", binaryMessenger: controller.binaryMessenger)
        channel.invokeMethod("changeRoute", arguments: route)
        navigationController?.pushViewController(controller, animated: true)
    }
}
