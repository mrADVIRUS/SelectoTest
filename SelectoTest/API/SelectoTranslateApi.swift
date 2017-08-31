//
//  SelectoTranslateApi.swift
//  SelectoTest
//
//  Created by Sergiy Lyahovchuk on 28.08.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class SelectoTranslateApi {
    static let sharedInstance = SelectoTranslateApi()
    
    private init() {
        
    }
    
    func reguestTranslate(params: [String: String], success:@escaping TranslatedText, failure:@escaping FailureBlock ) {
        guard API_KEY != "" else {
            let userInfo: [AnyHashable : Any] =
                [
                    NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: "Warning: You should set the api key before calling the translate method.", comment: "") ,
                    NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unauthorized", value: "Absent API_KEY", comment: "")
            ]
            let error = NSError(domain: "", code: 400, userInfo: userInfo) as Error
            failure(error)
            return
        }
        
//        let strUrl = URL(string: "https://translation.googleapis.com/language/translate/v2?key=\(API_KEY)&q=Hello&source=en&target=uk&format=text")

        
        if let urlEncodedText = params["text"]?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            let source = params["source"]!
            let target = params["target"]!
            let strTranslateUrl = "\(BASE_URL)\(METHOD_TRANSLATE)?key=\(API_KEY)&q=\(urlEncodedText)&source=\(source)&target=\(target)&format=text"
            
            let translateUrl = URL(string: strTranslateUrl)!
            
            Alamofire.request(translateUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"]).responseJSON { response in
                
                guard response.result.isSuccess else {
                    print("Error : \(String(describing: response.result.error))")
                    failure(response.result.error!)
                    return
                }
                
                let resJson = JSON(response.result.value!)
                if let translations = resJson["data"]["translations"].array {
                    if let translatedText = translations.first?["translatedText"].stringValue {
                        success(translatedText)
                    }
                    
                }

            }
        }

        
        
        
    }
}
