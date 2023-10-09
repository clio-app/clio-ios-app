//
//  ClientOutput.swift
//  clio-app
//
//  Created by Thiago Henrique on 09/10/23.
//

import Foundation

protocol ClientOutput: AnyObject {
    func errorWhileReceivingMessage(_ error: Error)
}
