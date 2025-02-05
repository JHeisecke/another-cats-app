//
//  AppDelegate.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-04.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {

    static var orientationLock = UIInterfaceOrientationMask.all

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
