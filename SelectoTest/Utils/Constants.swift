//
//  Constants.swift
//  SelectoTest
//
//  Created by Sergiy Lyahovchuk on 28.08.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import Foundation
import UIKit

typealias CompletionBlock = (NSData?) -> ()
typealias FailureBlock = (Error) -> ()
typealias TranslatedText = (String) -> ()

let API_KEY = ""
let BASE_URL = "https://translation.googleapis.com/"
let METHOD_TRANSLATE = "language/translate/v2"

let SHADOW_GRAY : CGFloat = 120.0/255.0
