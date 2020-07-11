//
//  NativeCoordinator.swift
//  FlutterHost
//
//  Created by Evgeniy Safronov on 06.07.2020.
//  Copyright © 2020 iSuperCitizen. All rights reserved.
//

import SegueCoordinator

class NativeCoordinator: SegueCoordinator {
    
    private let flutterModule: FlutterModule
    
    init(rootNavigationController: UINavigationController, flutterModule: FlutterModule) {
        self.flutterModule = flutterModule
        super.init(storyboardName: "Main", rootNavigationController: rootNavigationController)
        flutterModule.delegate = self
    }
    
    func start() {
        setInitial(type: NativeViewController.self) {
            $0.onShowFlutterText = showFlutterText
            $0.onShowFlutterBrowser = showFlutterBrowser
            $0.onShowNative = showNative
            $0.onShowMenu = showFlutterMenu
            $0.onShowChild = showFlutterChild
        }
    }
    
    func showFlutterText() {
        flutterModule.push(route: "text", navigationController: rootNavigationController)
    }
    
    func showFlutterBrowser() {
        flutterModule.push(route: "browser", navigationController: rootNavigationController)
    }
    
    func showFlutterMenu() {
        flutterModule.push(route: "menu", navigationController: rootNavigationController)
    }
    
    func showNative() {
        pushInitial(type: NativeViewController.self) {
            $0.onShowFlutterText = showFlutterText
            $0.onShowFlutterBrowser = showFlutterBrowser
            $0.onShowNative = showNative
            $0.onShowMenu = showFlutterMenu
            $0.onShowChild = showFlutterChild
        }
    }
    
    func showFlutterChild() {
        flutterModule.push(route: "child", navigationController: rootNavigationController)
    }
}

extension NativeCoordinator: FlutterModuleDelegate {
    
}
