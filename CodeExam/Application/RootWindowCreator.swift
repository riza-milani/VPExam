//
//  RootWindowCreator.swift
//  CodeExam
//
//  Created by riza milani on 11/16/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import UIKit

class RootWindowCreator {
    func create() -> UIWindow {
        let serviceCallApi = ServiceCallApi()
        let window = UIWindow(frame: UIScreen.main.bounds)
        let destinationViewController = VPMainRouter().assemble(serviceCall: serviceCallApi)
        let navigationContoller = UINavigationController(rootViewController: destinationViewController)
        navigationContoller.modalPresentationStyle = .fullScreen
        window.rootViewController = navigationContoller
        window.overrideUserInterfaceStyle = .light
        return window
    }
}
