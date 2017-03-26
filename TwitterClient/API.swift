//
//  API.swift
//  TwitterClient
//
//  Created by Kyle Hillman on 3/21/17.
//  Copyright © 2017 Kyle Hillman. All rights reserved.
//

import Foundation
import Accounts
import Social

typealias AccountCallback = (ACAccount?)->() //maybe return obtional array for multiple accounts
typealias UserCallback = (User?)->()
typealias TweetsCallback = ([Tweet]?)->()

class API {
    static let shared = API()
    
    var account : ACAccount?
    
    private func login(callback: @escaping AccountCallback){
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccounts(with: accountType, options: nil) { (success, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                callback(nil)
                return
            }
            
            if success {
                if let account = accountStore.accounts(with: accountType).first as? ACAccount{
                    callback(account)
                }
            } else {
                print("The user did not allow access to their account")
            }
        }
        
    }
    
    private func getOAuthUser(callback: @escaping UserCallback){
        let url = URL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")
        
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil){
            request.account = self.account
            request.perform(handler: { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    callback(nil)
                    return
                }
                
                guard let response = response else { callback(nil); return }
                guard let data = data else { callback(nil); return }
                
                switch response.statusCode {
                case 200...299:
                        let user = JSONParser.userFrom(data: data)
                        callback(user)
                case 400...499:
                    print("Error: Response came back with client side error: \(response.statusCode)")
                case 500...599:
                    print("Error: Response came back with server side error: \(response.statusCode)")
                default:
                    print("Error: response came back with status code: \(response.statusCode)")
                    callback(nil)
                }
            })
        }
        
    }
    
    private func updateTimeLine(url: String, callback: @escaping TweetsCallback){
        
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: URL(string: url), parameters: nil){
            request.account = self.account
            request.perform(handler: { (data, response, error) in
                if let error = error {
                    print("Error: Error requesting user's home timeline - \(error.localizedDescription)")
                    callback(nil)
                    return
                }
                
                guard let response = response else { callback(nil); return }
                guard let data = data else {callback(nil); return }
                
                switch response.statusCode {
                case 200...299:
                    JSONParser.tweetsFrom(data: data, callback: { (success, tweets) in
                        if success {
                            callback(tweets)
                        }
                })
                case 400...499:
                    print("Error: Response came back with client side error: \(response.statusCode)")
                case 500...599:
                    print("Error: Response came back with server side error: \(response.statusCode)")
                default:
                    print("Error: response came back with status code: \(response.statusCode)")
                    callback(nil)
                }
            })
        }
    }
    
    func getTweets(callback: @escaping TweetsCallback){
        if self.account == nil {
            login(callback: { (account) in
                if let account = account {
                    self.account = account
                    self.updateTimeLine(url: "https://api.twitter.com/1.1/statuses/home_timeline.json", callback: { (tweets) in
                        callback(tweets)
                    })
                }
            })
        } else {
            self.updateTimeLine(url: "https://api.twitter.com/1.1/statuses/home_timeline.json", callback: { (tweets) in
                callback(tweets)
            })
        }
    }
    
    func getTweetsFor(_ user: String, callback: @escaping TweetsCallback){
        
        let urlString = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(user)"

        
        self.updateTimeLine(url: urlString) { (tweets) in
            callback(tweets)
        }
    }
    
    func getUserInfo(callback: @escaping UserCallback) {
        self.getOAuthUser { (user) in
            callback(user)
        }
    }
}





































