//
//  FlutterModule.swift
//  FlutterHost
//
//  Created by Evgeniy Safronov on 06.07.2020.
//  Copyright © 2020 iSuperCitizen. All rights reserved.
//

import Flutter
import FlutterPluginRegistrant
//
protocol FlutterModuleDelegate: AnyObject {
    func showFlutterText()
    func showFlutterBrowser()
    func showNative()
}

class FlutterModule {
    
    weak var delegate: FlutterModuleDelegate?
    
    private let engine = FlutterEngine(name: "flutter engine")
    private lazy var controller = FlutterViewController(engine: engine)
    
    func startEngine() {
        engine.run()
        GeneratedPluginRegistrant.register(with: engine)
    }
    
    func clear() {
        controller.clearRoute()
    }
    
    func push(route: String, navigationController: UINavigationController) {
        if navigationController.topViewController is FlutterViewController {
            controller.showRoute(route, animated: true)
        } else {
            controller.delegate = delegate
            controller.showRoute(route, animated: false)
            navigationController.pushViewController(controller, animated: true)
        }
    }
}

class FlutterViewController: Flutter.FlutterViewController {
    
    weak var delegate: FlutterModuleDelegate?
    
    private var lastRoute: String?
    private lazy var channel = FlutterMethodChannel(name: "channel", binaryMessenger: binaryMessenger)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate init(engine: FlutterEngine) {
        super.init(engine: engine, nibName: nil, bundle: nil)
        
        splashScreenView = UIView()
        splashScreenView.backgroundColor = UIColor.white;
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func clearRoute() {
        lastRoute = nil
        channel.invokeMethod("clearRoute", arguments: nil)
    }
    
    fileprivate func showRoute(_ route: String, animated: Bool) {
        guard route != lastRoute else {
            return
        }
        
        lastRoute = route
        channel.invokeMethod(
            animated ? "changeRouteAnimated" : "changeRoute",
            arguments: route
        )
    }
}
