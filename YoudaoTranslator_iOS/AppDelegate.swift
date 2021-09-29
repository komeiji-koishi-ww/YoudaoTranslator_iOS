//
//  AppDelegate.swift
//  YoudaoTranslator
//
//  Created by kijin_seija on 2021/9/29.
//

import UIKit
import SwiftUI
import PartialSheet

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let sheetManager: PartialSheetManager = PartialSheetManager()
        
        self.window = UIWindow(frame: .zero)
        self.window?.frame = UIScreen.main.bounds
        self.window?.backgroundColor = .white
        let home = Translate().environmentObject(sheetManager)
        let vc = UIHostingController(rootView: home)
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()

        return true
    }

}

