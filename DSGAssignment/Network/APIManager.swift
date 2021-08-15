//
//  APIManager.swift
//  DSGAssignment
//
//  Created by VEER BAHADUR TIWARI on 15/08/21.
//

import Foundation

typealias CompletionHandler = (_ success: Bool, _ resources: Any?,_ error:String) -> ()

class APIManager: NSObject {
    
    //class function for accessing static class object
    class func shared() -> APIManager {
        return sharedInstance
    }
    
    private static var sharedInstance: APIManager = {
        let apiManager = APIManager()
        return apiManager
    }()
    
    private let baseURL: String
    
    private override init() {
        self.baseURL = ApiBaseUrl
    }
    
    //Genric API call
    private func getApiCall<T:Codable>(_ components: URLComponents?,_ type:T.Type,_ completion: @escaping CompletionHandler) {
        
        //Block which return No connectivity messgae is there is no internet
        NetworkManager.isUnreachable { _ in
            completion(false,nil,NoConnectivityMessage)
        }
        //Execute API calls when network is reachable
        NetworkManager.isReachable { _ in
            let request = URLRequest(url: (components?.url)!)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    let info = try decoder.decode(T.self, from: data)
                    completion(true,info,"")
                    
                } catch let err {
                    completion(false,nil,err.localizedDescription)
                }
            })
            task.resume()
        }
    }
    
     // get search result for q
    func getSearchResult(query: String, completion: @escaping CompletionHandler) {
        var components = URLComponents(string: baseURL + "events")
        components?.queryItems = [URLQueryItem]()
        components?.queryItems?.append(contentsOf: [
                                        URLQueryItem(name: "client_id", value: CLIENTID),
                                        URLQueryItem(name: "q", value: query)])
        
        getApiCall(components, Events.self, completion)
    }

}
