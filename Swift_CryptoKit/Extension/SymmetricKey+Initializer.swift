//
//  SymmetricKey+Initializer.swift
//  Swift_CryptoKit
//

import Foundation
import CryptoKit

extension SymmetricKey {
    
    // Create symetricKey with base64Encoded string
    init?(base64EncodedString string: String) {
        guard let data = Data(base64Encoded: string) else {
            return nil
        }
        self.init(data: data)
    }
    
    // CreateBase64String from symetricKey
    func serialize() -> String {
        return self.withUnsafeBytes { body in
            Data(body).base64EncodedString()
        }
    }
}
