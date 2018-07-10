//
//  ApiManager.swift
//  RichMe
//
//  Created by sts on 2/26/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftyUserDefaults

class ApiManager: NSObject {

    class var sharedManager: ApiManager {
        struct Singleton {
            static let instance = ApiManager()
        }
        return Singleton.instance
    }
    
    func login(email:String, pwd:String, completion: @escaping (_ success: Bool, _ response : Any?) -> ()) {
        
        let URL = Constants.REQ_LOGIN
        let params = ["email" : email, "password" : pwd, "device_type" : 0] as [String : Any]
        
        Alamofire.request(URL, method:.post, parameters:params)
            .responseJSON { response in
                
                switch response.result {

                case .failure:
                    completion(false, nil)

                case .success(let data):
                    
                    let dict = JSON(data)
                    
                    let result_code = dict[Constants.RES_RESULTCODE].intValue
                    
                    if result_code == Constants.CODE_SUCESS {
                        
                        let userInfo = dict[Constants.RES_USERINFO]
                        g_user = UserModel(dict:userInfo)
                        
                        Defaults[.email] = email
                        Defaults[.pwd] = pwd
                        
                        completion(true, data)
                        
                    } else {
                        completion(false, result_code)
                    }

                }
                
        }
    }
    
    func signup(email:String, username:String, pwd:String, completion: @escaping (_ success: Bool, _ response : Any?) -> ()) {
        
        let URL = Constants.REQ_SIGNUP
        let params = ["email" : email, "username":username, "password" : pwd, "device_type" : 0] as [String : Any]
        
        Alamofire.request(URL, method:.post, parameters:params)
            .responseJSON { response in
                
                switch response.result {
                    
                case .failure:
                    completion(false, nil)
                    
                case .success(let data):
                    
                    let dict = JSON(data)
                    
                    let result_code = dict[Constants.RES_RESULTCODE].intValue
                    
                    if result_code == Constants.CODE_SUCESS {
                        
                        let userId = dict[Constants.RES_USERID].intValue
                        g_user = UserModel(id: userId, username: username, email: email)
                        
                        Defaults[.email] = email
                        Defaults[.pwd] = pwd
                        
                        completion(true, data)
                        
                    } else {
                        
                        completion(false, result_code)
                    }
                    
                }
                
        }
    }
    
    func saveProfile(userId:Int, age:Int, attend:Int, completion: @escaping (_ success: Bool, _ response : Any?) -> ()) {
        
        let URL = Constants.REQ_SAVEPROFILE
        let params = ["user_id" : userId, "age":age, "attend" : attend] as [String : Any]
        
        Alamofire.request(URL, method:.post, parameters:params)
            .responseJSON { response in
                
                switch response.result {
                    
                case .failure:
                    completion(false, nil)
                    
                case .success(let data):
                    completion(true, data)
                    
                }
                
        }
    }
    
    func subscribe(userId:Int, price:Double, en_end:String?, es_end:String?, fr_end:String?, yb_end:String?, completion: @escaping (_ success: Bool, _ response : Any?) -> ()) {
        
        let URL = Constants.REQ_SUBSCRIBE
        var params = ["user_id" : userId, "price":price] as [String : Any]
        
        if en_end != nil {
            params["en_end"] = en_end!
        }
        
        if es_end != nil {
            params["es_end"] = es_end!
        }
        
        if fr_end != nil {
            params["fr_end"] = fr_end!
        }
        
        if yb_end != nil {
            params["yb_end"] = yb_end!
        }
        
        Alamofire.request(URL, method:.post, parameters:params)
            .responseJSON { response in
                
                switch response.result {
                    
                case .failure:
                    completion(false, nil)
                    
                case .success(let data):
                    completion(true, data)
                    
                }
                
        }
    }
    
    func saveSpent(userId:Int, spent:Int, last_spent:String!, completion: @escaping (_ success: Bool, _ response : Any?) -> ()) {
        
        let URL = Constants.REQ_SAVESPENT
        let params = ["user_id" : userId, "spent":spent, "last_spent":last_spent] as [String : Any]
        
        Alamofire.request(URL, method:.post, parameters:params)
            .responseJSON { response in
                
                switch response.result {
                    
                case .failure:
                    completion(false, nil)
                    
                case .success(let data):
                    completion(true, data)
                    
                }
                
        }
    }
    
    func resetPassword(email:String, completion: @escaping (_ success: Bool, _ response : Any?) -> ()) {
        
        let URL = Constants.REQ_RESETPASSWORD
        let params = ["email" : email] as [String : Any]
        
        Alamofire.request(URL, method:.post, parameters:params)
            .responseJSON { response in
                
                switch response.result {
                    
                case .failure:
                    completion(false, nil)
                    
                case .success(let data):
                    
                    let dict = JSON(data)
                    
                    let result_code = dict[Constants.RES_RESULTCODE].intValue
                    
                    if result_code == Constants.CODE_SUCESS {
                        
                        completion(true, data)
                        
                    } else {
                        completion(false, result_code)
                    }
                    
                }
                
        }
    }
    
    func setPassword(user_id:Int, password:String, completion: @escaping (_ success: Bool, _ response : Any?) -> ()) {
        
        let URL = Constants.REQ_SETPASSWORD
        let params = ["user_id" : user_id, "password" : password] as [String : Any]
        
        Alamofire.request(URL, method:.post, parameters:params)
            .responseJSON { response in
                
                switch response.result {
                    
                case .failure:
                    completion(false, nil)
                    
                case .success(let data):
                    completion(true, data)
                    
                }
                
        }
    }


}
