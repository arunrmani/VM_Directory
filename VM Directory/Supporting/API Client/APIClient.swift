    //
    //  APIClient.swift
    //  VM Directory
    //
    //  Created by Arun R Mani on 01/08/2022.
    //

import Foundation
import UIKit
#if canImport(FoundationNetworking)
import FoundationNetworking
import Accelerate
#endif
class APIClient : NSObject{
    
    static let shared = APIClient()
    //Mock base URL
    var baseURl = "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/"
    
    typealias resultCallBack = (Result<Data,APIError>)-> Void
    func callAPIRequest(semaphoreId:Int,request:URLRequest,completion:@escaping resultCallBack) {
        let semaphore = DispatchSemaphore (value: semaphoreId)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidAPI))
                semaphore.signal()
                return
            }
            //print("API Status : \(httpResponse.statusCode)")
            switch httpResponse.statusCode {
                case 200:
                    guard let data = data else {
                        completion(.failure(.invalidAPIResponse))
                        semaphore.signal()
                        return
                    }
                    completion(.success(data))
                    semaphore.signal()
                case 400:
                    completion(.failure(.badRequest))
                    semaphore.signal()
                    return
                case 401:
                    completion(.failure(.authenticationError))
                    semaphore.signal()
                    return
                case 404:
                    completion(.failure(.invalidAPI))
                    semaphore.signal()
                    return
                case 503:
                    completion(.failure(.serviceUnAvailable))
                    semaphore.signal()
                    return
                default:
                    completion(.failure(.unexpected(code: httpResponse.statusCode)))
                    semaphore.signal()
                    return
            }
        }
        task.resume()
        semaphore.wait()
    }
    
}

extension APIClient{
  
    
        //Mark:- GET People list
    typealias peopleResultCallBack = (Result<[People],APIError>)-> Void

    func getPeopleList(completionHandler: @escaping  peopleResultCallBack){
        
        let url = self.createURL(baseURL: self.baseURl, urlType: .GET_PEOPLE_LIST)
        
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        self.callAPIRequest(semaphoreId: 1, request: request) { result in
            switch result{
                case .success(let data):
                    self.processGetPeopleList(data: data, callBack: completionHandler)
                case .failure(let error):
                    completionHandler(.failure(error))
            }
        }
        
    }
    
        //Mark:- GET Rooms list
    typealias roomsResultCallBack = (Result<[Rooms],APIError>)-> Void
    
    func getRoomList(completionHandler: @escaping  roomsResultCallBack){
        
        let url = self.createURL(baseURL: self.baseURl, urlType: .GET_ROOMS_LIST)
        
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        self.callAPIRequest(semaphoreId: 2, request: request) { result in
            switch result{
                case .success(let data):
                    self.processGetRoomsList(data: data, callBack: completionHandler)
                case .failure(let error):
                    completionHandler(.failure(error))
            }
        }
        
    }
    
}




extension APIClient{
    
    private func dicToJsonString(dictionary : [String:Any]) -> String{
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            let theJSONText = String(data: theJSONData,
                                     encoding: .ascii)
                //print("JSON string = \(theJSONText!)")
            return theJSONText ?? ""
        }
        return ""
    }
    
    
    private func createURL(baseURL: String,urlType: URLType) -> String{
        switch urlType{
            case .GET_PEOPLE_LIST:
               return baseURL + urlType.rawValue
            case .GET_ROOMS_LIST:
                return baseURL + urlType.rawValue
        }
    }
    

    
    private func processGetPeopleList(data:Data,callBack:@escaping peopleResultCallBack){
        do{
            let responseObj =  try JSONDecoder().decode([People].self, from: data)
            callBack(.success(responseObj))
        }
        catch let error{
            print(error.localizedDescription)
            callBack(.failure(.convertionError))
        }
        }
    

    private func processGetRoomsList(data:Data,callBack:@escaping roomsResultCallBack){
        do{
            let responseObj =  try JSONDecoder().decode([Rooms].self, from: data)
            callBack(.success(responseObj))
        }
        catch let error{
            print(error.localizedDescription)
            callBack(.failure(.convertionError))
        }
    }
    
}

    //API URLS
enum URLType: String{
    case GET_PEOPLE_LIST = "people"
    case GET_ROOMS_LIST = "rooms"
    
}
