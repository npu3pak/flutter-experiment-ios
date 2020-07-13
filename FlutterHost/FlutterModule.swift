//
//  FlutterModule.swift
//  FlutterHost
//
//  Created by Evgeniy Safronov on 06.07.2020.
//  Copyright © 2020 iSuperCitizen. All rights reserved.
//

import Flutter
import FlutterPluginRegistrant

protocol FlutterModuleDelegate: AnyObject {
    func showFlutterText()
    func showFlutterBrowser()
    func showNative()
}

class FlutterModule {
    
    weak var delegate: FlutterModuleDelegate?
    
    private let engine = FlutterEngine(name: "flutter engine")
    private var lastNavigationController: UINavigationController?
    
    private lazy var channel = FlutterMethodChannel(name: "channel", binaryMessenger: engine.binaryMessenger)
    
    func startEngine() {
        engine.run()
        GeneratedPluginRegistrant.register(with: engine)
        listenChannel()
    }
    
    private func listenChannel() {
        channel.setMethodCallHandler { [weak self] call, _ in
            switch call.method {
            case "pop": self?.pop()
            case "showFlutterBrowser": self?.delegate?.showFlutterBrowser()
            case "showFlutterText": self?.delegate?.showFlutterText()
            case "showNative": self?.delegate?.showNative()
            default: print("Unknown Method \(call.method)")
            }
        }
    }
    
    func push(route: String, navigationController: UINavigationController) {
        lastNavigationController = navigationController;
        
        if navigationController.topViewController is FlutterViewController {
            pushRoute(route, fromFlutter: true)
        } else {
            engine.viewController = nil
            let controller = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
            pushRoute(route, fromFlutter: false)
            navigationController.pushViewController(controller, animated: true)
        }
    }
    
    private func pushRoute(_ route: String, fromFlutter: Bool) {
        channel.invokeMethod(
            fromFlutter ? "pushRouteFromFlutter" : "pushRouteFromNative",
            arguments: route
        )
    }
    
    private func pop() {
        guard let nc = lastNavigationController else {
            return
        }
        
        nc.popViewController(animated: true)
        if let topFlutterController = nc.viewControllers.last(where: {$0 is FlutterViewController}) {
            engine.viewController = topFlutterController as! FlutterViewController
        }
    }
}

class FlutterViewController: Flutter.FlutterViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

