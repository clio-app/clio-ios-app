//
//  HttpError.swift
//  clio-app
//
//  Created by Thiago Henrique on 21/09/23.
//

import Foundation

enum HTTPError: Error, LocalizedError {
    case transportError
    case serverSideError(Int)
    
    var errorDescription: String? {
        switch self {
            case .transportError:
                return "Erro ao enviar dados ao servidor!"
            case .serverSideError(let statusCode):
                return getDescription(of: statusCode)
        }
    }
}

extension HTTPError {
    private func getDescription(of statusCode: Int) -> String {
        if (400...499).contains(statusCode) {
            return "Por favor, certifique-se de preencher todos os campos obrigatórios corretamente."
        } else if (500...599).contains(statusCode) {
            return "Desculpe, não foi possível acessar nosso servidor."
        } else if (700...).contains(statusCode) {
            return "Desculpe, algo deu errado. Tente mais tarde."
        }
        
        return "Desconhecido"
    }
}
