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

class NativeViewController: UIViewController {
    
    var onShowFlutterBrowser: (() -> Void)?
    var onShowFlutterText: (() -> Void)?
    var onShowNative: (() -> Void)?
    var onShowMenu: (() -> Void)?
    
    @IBAction func onShowScreenWithBrowser(_ sender: Any) {
        onShowFlutterBrowser?()
    }

    @IBAction func onShowScreenWithText(_ sender: Any) {
        onShowFlutterText?()
    }

    @IBAction func onShowNativeScreen(_ sender: Any) {
        onShowNative?()
    }

    @IBAction func onShowMenuScreen(_ sender: Any) {
        onShowMenu?()
    }
}
