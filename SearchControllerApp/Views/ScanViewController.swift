//
//  ScanViewController.swift
//  SearchControllerApp
//
//  Created by 近江伸一 on 2023/04/01.
//

import UIKit
import VisionKit
class ScanViewController: UIViewController, DataScannerViewControllerDelegate {
    private let nextViewController = DataShowView()
    var texts: String?
    //データ スキャナーが使用可能かどうかを確認
    private  var scannerAvailable: Bool {
        DataScannerViewController.isSupported && DataScannerViewController.isAvailable
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showAleart()
        
        
    }
    func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
        switch item {
        case .text(let text):
            print("text: \(text.transcript)")
            UIPasteboard.general.string = text.transcript
            texts = text.transcript
            
            changeView(view:texts!)
        case .barcode(let code):
            guard let urlString = code.payloadStringValue else { return }
            guard let url = URL(string: urlString) else { return }
            UIApplication.shared.open(url)
            texts = urlString
            
            changeView(view:texts!)
            
        default:
            print("想定外のエラー")
        }
    }
    func changeView(view: String){
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "nextViewController") as! DataShowView
//        pushViewController(viewController, animated: true)
        
        self.dismiss(animated: true)
        
        self.present(nextViewController, animated: true, completion: nil)
   
        DataShowView.str = texts!
        
    }

    
    func startButton() {
        guard scannerAvailable == true else { return }
        //✳️DataScannerViewControllerをインスタンス化
        let dataScanner = DataScannerViewController(recognizedDataTypes: [.text(),.barcode(symbologies:[ .ean13])],qualityLevel: .accurate,isHighFrameRateTrackingEnabled: true, isPinchToZoomEnabled: true, isGuidanceEnabled: true,isHighlightingEnabled: true)
        dataScanner.delegate = self
        present(dataScanner,animated: true) {
            try? dataScanner.startScanning()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        showAleart()
        startButton()
    }
    
    
    func showAleart(){
        let alert = UIAlertController(title: "カメラを起動します", message: "This is an alert.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            self.startButton()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
