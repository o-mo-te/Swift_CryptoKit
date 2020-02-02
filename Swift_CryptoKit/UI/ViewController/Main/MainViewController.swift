//
//  ViewController.swift
//  Swift_CryptoKit
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - View  life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - IBAction
    
    @IBAction private func tappedEncryptButton(_ sender: UIButton) {
        doEncrypt()
    }
    
    @IBAction private func tappedDecryptButton(_ sender: UIButton) {
        doDecrypt()
    }
}

private extension MainViewController {
    
    /// 初期処理
    private func setup() {
        print("You can open easily with command -> command + shift + G: \(getFilePath())")
        setupLayout()
    }
    
    /// レイアウトの設定
    private func setupLayout() {
        resultLabel.layer.borderWidth = 1
        descriptionLabel.layer.borderWidth = 1
        resultLabel.layer.borderColor = UIColor.black.cgColor
        descriptionLabel.layer.borderColor = UIColor.black.cgColor
    }
    
    /// 暗号化を実行
    private func doEncrypt() {
        let path = getFilePath()
        guard
            let data = getPathData(path: path),
            CryptoManager.shared.writeEncryptedData(to: path, data: data) else {
                updateLabelText(result: "Failure!", description: "Failed to write encrypted data.")
                return
        }
        updateLabelText(result: "Succeed!", description: " Succeed to write encrypted data.")
    }
    
    /// 復号を実行
    private func doDecrypt() {
        let path = getFilePath()
        guard
            let data = FileManager.default.contents(atPath: path),
            CryptoManager.shared.writeDecryptedData(to: path, data: data)else {
                updateLabelText(result: "Failure!", description: "Failed to write decrypted data.")
                return
        }
        updateLabelText(result: "Succeed!", description: " Succeed to write decrypted data.")
    }
    
    /// 書き込むパスを取得
    private func getFilePath() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return "\(documentDirectory)/Sample.text"
    }
    
    /// 指定したパスのデータを取得
    private func getPathData(path: String) -> Data? {
        guard let data = FileManager.default.contents(atPath: path) else {
            return nil
        }
        return data
    }
    
    /// 表示文言を変更
    private func updateLabelText(result: String, description: String) {
        resultLabel.text = result
        descriptionLabel.text = description
    }
}
