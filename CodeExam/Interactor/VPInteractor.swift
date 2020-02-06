//
//  VPInteractor.swift
//  CodeExam
//
//  Created by riza milani on 11/16/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import Foundation

protocol VPInteractorProtocol {
    func fetchSections(completion: @escaping ((Result<[ViaplaySection], Error>) -> Void))
    func fetchSectionDetail(href: String, completion: @escaping ((VPModel?) -> Void))
}
class VPInteractor: VPInteractorProtocol {
    
    var service: ServiceCall

    init(service: ServiceCall) {
        self.service = service
    }

    func fetchSections(completion: @escaping ((Result<[ViaplaySection], Error>) -> Void)) {
        service.getSections { result in
            completion(result)
        }
    }

    func fetchSectionDetail(href: String, completion: @escaping ((VPModel?) -> Void)) {
        service.getSectionDetail(href: href) { result in
            switch result {
            case .success(let vpmodel):
                completion(vpmodel)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
