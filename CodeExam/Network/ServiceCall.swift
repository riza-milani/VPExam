//
//  ServiceCall.swift
//  CodeExam
//
//  Created by riza milani on 11/16/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import Foundation

let BASE_URL = "https://content.viaplay.se/ios-se"

protocol ServiceCall {
    func getSections(completion: @escaping ((Result<[ViaplaySection], Error>) -> Void))
    func getSectionDetail(href: String, completion: @escaping ((Result<VPModel, Error>) -> Void))
    var shouldInvalidateCache: Bool { get set }
}

class ServiceCallApi: ServiceCall {

    var shouldInvalidateCache: Bool = false
    let cachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad

    func getSections(completion: @escaping ((Result<[ViaplaySection], Error>) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            let endpoint: String = BASE_URL
            guard let url = URL(string: endpoint) else {
                completion(.failure(NSError(domain: "Can not create url address.", code: 0, userInfo: nil)))
                return
            }
            let capacity = 100 * 1024 * 1024 // MBs
            let urlCache = URLCache(memoryCapacity: capacity, diskCapacity: capacity, diskPath: nil)
            let urlRequest = URLRequest(url: url)
            let config = URLSessionConfiguration.default
            config.requestCachePolicy = self.cachePolicy
            config.urlCache = urlCache
            if self.shouldInvalidateCache {
                urlCache.removeAllCachedResponses()
                config.requestCachePolicy = .reloadIgnoringLocalCacheData
                self.shouldInvalidateCache = false
            }
            let session = URLSession(configuration: config)

            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                guard let dataResponse = data else {
                    completion(.failure(NSError(domain: "There is no data response.", code: 0, userInfo: nil)))
                    return
                }
                guard let vpModel = try? JSONDecoder().decode(VPModel.self, from: dataResponse) else {
                    completion(.failure(NSError(domain: "Can not decode the data.", code: 0, userInfo: nil)))
                    return
                }
                completion(.success(vpModel.links.viaplaySections))
            }
            task.resume()
        }
    }

    func getSectionDetail(href: String, completion: @escaping ((Result<VPModel, Error>) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            let endpoint: String = href
            guard let url = URL(string: endpoint) else {
                completion(.failure(NSError(domain: "Can not create url address.", code: 0, userInfo: nil)))
                return
            }
            let capacity = 100 * 1024 * 1024 // MBs
            let urlCache = URLCache(memoryCapacity: capacity, diskCapacity: capacity, diskPath: nil)
            let urlRequest = URLRequest(url: url)
            let config = URLSessionConfiguration.default
            config.requestCachePolicy = self.cachePolicy
            if self.shouldInvalidateCache {
                config.requestCachePolicy = .reloadIgnoringLocalCacheData
                urlCache.removeAllCachedResponses()
                self.shouldInvalidateCache = false
            }
            config.urlCache = urlCache
            let session = URLSession(configuration: config)

            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                guard let dataResponse = data else {
                    completion(.failure(NSError(domain: "There is no data response.", code: 0, userInfo: nil)))
                    return
                }
                guard let vpModel = try? JSONDecoder().decode(VPModel.self, from: dataResponse) else {
                    completion(.failure(NSError(domain: "Can not decode the data.", code: 0, userInfo: nil)))
                    return
                }
                completion(.success(vpModel))
            }
            task.resume()
        }
    }
}
