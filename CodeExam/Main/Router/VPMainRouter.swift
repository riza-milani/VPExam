//
//  VPMainRouter.swift
//  CodeExam
//
//  Created by riza milani on 11/16/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import UIKit

class VPMainRouter {
    var viewController: UIViewController?
    var serviceCall: ServiceCall?

    func assemble(serviceCall: ServiceCall) -> UIViewController {
        self.serviceCall = serviceCall
        let view = VPMainViewController()
        let presenter = VPMainPresenter()
        let interactor = VPInteractor(service: serviceCall)
        presenter.router = self
        presenter.interactor = interactor
        view.presenter = presenter
        viewController = view
        return view
    }

    func showDetail(href: String) {
        let router = VPDetailRouter()
        guard let serviceCall = serviceCall, let destinationViewController = router.assemble(href: href, serviceCall: serviceCall) as? VPDetailViewController else {
            return
        }
        viewController?.navigationController?.pushViewController(destinationViewController, animated: true)
    }

    func invalidateCache() {
        serviceCall?.shouldInvalidateCache = true
    }
}
