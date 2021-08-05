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
    func getData(urlString: String,
                 success: @escaping (Data) -> (),
                 failure: @escaping (Error?) -> ())
}

class APIClient: ClientProtocol {
    var baseURL: String?
    
    required init(baseUrl: String) {
        self.baseURL = baseUrl
    }
    
    func getData(urlString: String,
                 success: @escaping (Data) -> (),
                 failure: @escaping (Error?) -> ()) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let urlReq = URLRequest(url: url as URL)
        let dataTask = URLSession.shared.dataTask(with: urlReq) { (data, urlResponse, error) in
            if error != nil {
                failure(error)
                return
            } else if let httpResp = urlResponse as? HTTPURLResponse, let reponseData = data {
                switch httpResp.statusCode {
                case 200, 201:
                    success(reponseData)
                default:
                    let error = NSError(domain: "om.rbtechsolutions.SampleBitBucketRep", code: 1001, userInfo: ["fetchFailed" : "Unable to Fetch Data"])
                    failure(error)
                }
            }
        }
        dataTask.resume()
    }
}

