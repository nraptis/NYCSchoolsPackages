//
//  NetworkManager.swift
//  NYCNetworking
//
//  Created by Nicky Taylor on 3/17/23.
//

import Foundation

public protocol NetworkConforming {
    func fetchSchools() async throws -> [School]
    func fetchScores(dbn: String) async throws -> [Score]
}

public class NetworkManager: NSObject, NetworkConforming {
    
    public override init() {
        super.init()
    }
    
    private lazy var decoder: JSONDecoder = {
        let result = JSONDecoder()
        result.keyDecodingStrategy = .convertFromSnakeCase
        return result
    }()
    
    private lazy var clientCertificateData: Data = {
        guard let url = Bundle.module.url(forResource: "data.cityofnewyork.us", withExtension: "cer") else {
            return Data()
        }
        guard let data = try? Data(contentsOf: url) else {
            return Data()
        }
        return data
    }()
    
    let delegateQueue = OperationQueue()
    
    public func fetchSchools() async throws -> [School] {
        return try await fetchArray(urlString: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json",
                                    type: School.self)
    }
    
    public func fetchScores(dbn: String) async throws -> [Score] {
        return try await fetchArray(urlString: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn=\(dbn)",
                                    type: Score.self)
    }
    
    private func fetchArray<FetchType: Decodable>(urlString: String, type: FetchType.Type) async throws -> [FetchType] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration,
                                 delegate: self,
                                 delegateQueue: delegateQueue)
        let request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        let (data, _) = try await session.data(for: request)
        return try decoder.decode([FetchType].self,
                              from: data)
    }
    
}

extension NetworkManager: URLSessionDelegate {
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let trust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        guard let serverCertificateArray = SecTrustCopyCertificateChain(trust) as? [SecCertificate] else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        for serverCertificate in serverCertificateArray {
            let serverCertificateData = SecCertificateCopyData(serverCertificate) as Data
            if clientCertificateData == serverCertificateData {
                let credential = URLCredential(trust: trust)
                completionHandler(.useCredential, credential)
                return
            }
        }
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
}
