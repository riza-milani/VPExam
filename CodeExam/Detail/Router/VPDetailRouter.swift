//
//  VPDetailRouter.swift
//  CodeExam
//
//  Created by riza milani on 11/16/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import UIKit

class VPDetailRouter {
    var viewController: UIViewController?
    var serviceCallApi: ServiceCall?

    func assemble(href: String, serviceCall: ServiceCall) -> UIViewController {
        let view = VPDetailViewController()
        let presenter = VPDetailPresenter(href: href.replacingOccurrences(of: "{?dtg}", with: ""))
        let interactor = VPInteractor(service: serviceCall)
        presenter.router = self
        presenter.interactor = interactor
        view.presenter = presenter
        viewController = view
        return view
    }
}
