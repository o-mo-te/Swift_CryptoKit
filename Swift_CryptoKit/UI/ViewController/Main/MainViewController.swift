//
//  ViewController.swift
//  Swift_CryptoKit
//

import UIKit

final class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

private extension MainViewController {
    
    private func setup() {
        
        // 書き込むパスの取得
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = "\(documentsPath)/Sample.text"
        
        print("command + shift + G: \(filePath)")
        
        // ファイルをデータ型で取得(デバックのため、"filePath"にあらかじめテスト用のファイル"Sample.text"を配置)
        guard let encryptData = FileManager.default.contents(atPath: filePath) else {
            return
        }
        
        //  暗号化
        if !CryptManager.shared.writeEncryptedData(to: filePath, data: encryptData) {
            print("failed to write encrypted data.")
        }
        
        guard let decryptData = FileManager.default.contents(atPath: filePath) else {
            return
        }
        
        // 復号
        if !CryptManager.shared.writeDecryptedData(to: filePath, data: decryptData) {
            print("failed to write decrypted data.")
        }
    }
}
