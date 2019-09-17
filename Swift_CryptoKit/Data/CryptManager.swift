//
//  CryptManager.swift
//  Swift_CryptoKit
//
//  Created by hidetomo on 2019/09/18.
//  Copyright © 2019 Hidetomo Masuda. All rights reserved.
//

import Foundation
import CryptoKit

enum AppError: Error {
    case error
}

class CryptManager {
    
    // MARK: - Property
    
    static let shared = CryptManager()
    private var encryptionKey = SymmetricKey(size: .bits256)
    private let keyName = "encryptionKey"
    
    // MARK: - Public function
    
    /// 指定したパスに暗号化したデータを書き込む
    /// - Parameter path: 書き込み先のパス
    /// - Parameter data: 暗号化して書き込むデータ
    @discardableResult
    func writeEncryptedData(to path: String, data: Data) -> Bool {
        do {
            let data = try encrypt(data: data)
            FileManager.default.createFile(atPath: path, contents: data, attributes: [:])
            return true
        } catch _ {
            return false
        }
    }
    
    /// 指定したパスに復号したデータを書き込む
    /// - Parameter path: 書き込み先のパス
    /// - Parameter data: 復号して書き込むデータ
    @discardableResult
    func writeDecryptedData(to path: String, data: Data) -> Bool {
        do {
            let data = try decrypt(data: data)
            FileManager.default.createFile(atPath: path, contents: data, attributes: [:])
            return true
        } catch _ {
            return false
        }
    }
    
    // MARK: - Private function
    
    /// 暗号化
    /// - Parameter data: 暗号化するデータ
    private func encrypt(data: Data) throws -> Data {
        do {
            let sealedBox =  try AES.GCM.seal(data, using: encryptionKey)
            guard let data = sealedBox.combined else {
                throw AppError.error
            }
            return data
        } catch _ {
            throw AppError.error
        }
    }
    
    /// 復号
    /// - Parameter data: 復号するデータ
    private func decrypt(data: Data) throws -> Data {
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            return try AES.GCM.open(sealedBox, using: encryptionKey)
        } catch _ {
            throw AppError.error
        }
    }
}
