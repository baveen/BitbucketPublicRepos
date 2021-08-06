//
//  APIClient.swift
//  BitbucketPublicRepos
//
//  Created by Baveendran Nagendran on 2021-08-05.
//

import Foundation
import UIKit

protocol ClientProtocol {
    var baseURL: String? {get set}
    
    init(baseUrl: String)
    func getData(urlString: String?,
                 completion: @escaping (_ data: Data?, _ error: Error?) -> Void)
}

class APIClient: ClientProtocol {
    var baseURL: String?
    
    required init(baseUrl: String) {
        self.baseURL = baseUrl
    }
    
    func getData(urlString: String?, completion: @escaping (Data?, Error?) -> Void) {
        guard let urlStr = urlString, let url = URL(string: urlStr) else {
            return
        }
        
        let urlReq = URLRequest(url: url as URL)
        let dataTask = URLSession.shared.dataTask(with: urlReq) { (data, urlResponse, error) in
            if error != nil {
                completion(nil, error)
                return
            } else if let httpResp = urlResponse as? HTTPURLResponse, let reponseData = data {
                switch httpResp.statusCode {
                case 200, 201:
                    completion(reponseData, nil)
                default:
                    let customError = NSError(domain: "com.rbtechsolutions.SampleBitBucketRep", code: 1001, userInfo: ["fetchFailed" : "Unable to Fetch Data"])
                    completion(nil, customError)
                }
            }
        }
        dataTask.resume()
    }
    
}

