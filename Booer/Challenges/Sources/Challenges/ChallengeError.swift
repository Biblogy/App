//
//  ChallengeError.swift
//  
//
//  Created by Veit Progl on 10.04.23.
//

import Foundation
import BooerKit

enum ChallengeErrors: Int {
    case typeNotFound = 211
    case valueNotFound = 212
    case saveFailed = 221
}

struct ChallengeError: ErrorProtocol {
    let code: Int
    
    var title: String {
        return DefaultErrorCopy.title
    }
    
    var message: String {
        switch code {
        case 210:
            return NSLocalizedString("generic", comment: "")
        case 212:
            return NSLocalizedString("One of the fields is empty", comment: "")
        default:
            return DefaultErrorCopy.message
        }
    }
    
    var errorDescription: String? {
        return message
    }
    
    init(_ error: ChallengeErrors) {
        self.code = error.rawValue
    }
}
