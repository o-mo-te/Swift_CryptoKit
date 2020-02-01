//
//  SymmetricKey+Initializer.swift
//  Swift_CryptoKit
//

import Foundation
import CryptoKit

extension SymmetricKey {
    
    init?(base64EncodedString string: String) {
        guard let data = Data(base64Encoded: string) else {
            return nil
        }
        self.init(data: data)
    }
    
    func serialize() -> String {
        return self.withUnsafeBytes { body in
            Data(body).base64EncodedString()
        }
    }
}
