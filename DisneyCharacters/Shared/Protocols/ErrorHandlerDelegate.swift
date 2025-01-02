//
//  ErrorHandlerDelegate.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation

protocol ErrorHandlerDelegate<ErrorType> {
    associatedtype ErrorType: Error
    
    func handleError(_ error: ErrorType)
}
