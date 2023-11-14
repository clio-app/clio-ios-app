//
//  MapperError.swift
//  clio-app
//
//  Created by Thiago Henrique on 21/09/23.
//

import Foundation

enum MapperError: Error, CaseIterable, LocalizedError {
    case encodingError
    case decodingError
    
    var errorDescription: String? {
        switch self {
            case .encodingError:
                return "Some informations could not being processed"
            case .decodingError:
                return "Error while showing informations"
        }
    }
}
