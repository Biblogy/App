//
//  File.swift
//  
//
//  Created by Veit Progl on 10.04.23.
//

import Foundation
import UIKit
import Logging

// Define the Error protocol with required properties
public protocol ErrorProtocol: LocalizedError {
    var code: Int { get }
    var title: String { get }
    var message: String { get }
}

// Define a struct to hold the default error titles and messages
public struct DefaultErrorCopy {
    public static let title = NSLocalizedString("Error", comment: "")
    public static let message = NSLocalizedString("An error has occurred. Please try again later, if this happens multiple times contact support", comment: "")
}

// Create a ErrorHandler class that handles all errors in the app
public class ErrorHandler {
    public static func showError(_ error: ErrorProtocol) {
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let topController = windowScene.windows.first?.rootViewController else {
                return
            }
            
            let errorMessage = error.message + " error code: " + String(error.code)
            
            Logger(label: "BiblogyKit: ErrorHandler").error(Logger.Message(stringLiteral: errorMessage))
            
            let alert = UIAlertController(title: error.title, message: errorMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)

            topController.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: Example Impementation

// Define an implementation of the Error protocol for a specific error type
struct NetworkingError: ErrorProtocol {
    let code: Int
    
    var title: String {
        return DefaultErrorCopy.title
    }
    
    var message: String {
        switch code {
        case 404:
            return NSLocalizedString("The requested resource was not found.", comment: "")
        case 500:
            return NSLocalizedString("The server is currently unavailable.", comment: "")
        default:
            return DefaultErrorCopy.message
        }
    }
    
    var errorDescription: String? {
        return message
    }
}

//MARK: Example use
//let error = NetworkingError(code: 404)
//print(error.title)
//print(error.message)
