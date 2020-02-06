//
//  File.swift
//  CodeExamTests
//
//  Created by riza milani on 11/17/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import Foundation
@testable import CodeExam

class ServiceCallMock: ServiceCall {
    var shouldInvalidateCache: Bool = false
    
    func getSections(completion: @escaping ((Result<[ViaplaySection], Error>) -> Void)) {
        let filePath = Bundle.main.path(forResource: "vpsections", ofType: "json")
        DispatchQueue.global(qos: .userInitiated).async {
            guard
                let path = filePath,
                let data = try? Data(contentsOf: URL(fileURLWithPath: path))
                else {
                    return
            }
            do {
                let vpModel = try JSONDecoder().decode(VPModel.self, from: data)
                completion(.success(vpModel.links.viaplaySections))
            } catch let error {
                completion(.failure(error))
            }
        }
        
    }
    
    func getSectionDetail(href: String, completion: @escaping ((Result<VPModel, Error>) -> Void)) {
        var filePath: String?
        switch href {
        case "https://content.viaplay.se/ios-se/serier{?dtg}":
            filePath = Bundle.main.path(forResource: "serier", ofType: "json")
        case "https://content.viaplay.se/ios-se/film{?dtg}":
            filePath = Bundle.main.path(forResource: "film", ofType: "json")
        case "https://content.viaplay.se/ios-se/sport{?dtg}":
            filePath = Bundle.main.path(forResource: "sport", ofType: "json")
        case "https://content.viaplay.se/ios-se/sport2{?dtg}":
            filePath = Bundle.main.path(forResource: "sport2", ofType: "json")
        case "https://content.viaplay.se/ios-se/sport3{?dtg}":
            filePath = Bundle.main.path(forResource: "sport3", ofType: "json")
        case "https://content.viaplay.se/ios-se/barn{?dtg}":
            filePath = Bundle.main.path(forResource: "barn", ofType: "json")
        default:
            break
        }
        DispatchQueue.global(qos: .userInitiated).async {
            guard
                let path = filePath,
                let data = try? Data(contentsOf: URL(fileURLWithPath: path))
                else {
                    return
            }
            do {
                let vpModel = try JSONDecoder().decode(VPModel.self, from: data)
                completion(.success(vpModel))
            } catch let error {
                completion(.failure(error))
            }
        }
        
    }
    
    
}
