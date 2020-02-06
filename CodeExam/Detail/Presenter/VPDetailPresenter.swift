//
//  VPDetailPresenter.swift
//  CodeExam
//
//  Created by riza milani on 11/16/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import Foundation

protocol VPDetailPresenterProtocol {
    var router: VPDetailRouter? { get set }
    var interactor: VPInteractor? { get set }
    func fetchDetail(completion: @escaping ((VPModel?) -> Void))
    func free()
    var href: String? { get set }
}

class VPDetailPresenter: VPDetailPresenterProtocol {

    var router: VPDetailRouter?
    var interactor: VPInteractor?
    var href: String?

    init(href: String) {
        self.href = href
    }

    func fetchDetail(completion: @escaping ((VPModel?) -> Void)) {
        guard let href = href else {
            return
        }
        interactor?.fetchSectionDetail(href: href) { vpModel in
            DispatchQueue.main.async {
                completion(vpModel)
            }
        }
    }

    func free() {
        router?.viewController = nil
        router = nil
        href = nil
    }
}
