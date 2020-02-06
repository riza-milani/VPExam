//
//  VPMainPresenter.swift
//  CodeExam
//
//  Created by riza milani on 11/16/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import Foundation

protocol VPMainPresenterProtocol {
    var router: VPMainRouter? { get set }
    var interactor: VPInteractor? { get set }
    func fetchSections(completion: @escaping (([ViaplaySection]) -> Void))
    func showDetail(href: String)
    func invalidateCache()
}

class VPMainPresenter: VPMainPresenterProtocol {
    var router: VPMainRouter?
    var interactor: VPInteractor?

    func fetchSections(completion: @escaping (([ViaplaySection]) -> Void)) {
        interactor?.fetchSections { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let vpSections):
                    completion(vpSections)
                case .failure(_):
                    // Custom error handling should be here.
                    // For simplicity, here I send empty array.
                    completion([])
                }
            }
        }
    }

    func showDetail(href: String) {
        router?.showDetail(href: href)
    }

    func invalidateCache() {
        router?.invalidateCache()
    }
}
