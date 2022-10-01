//
//  WebViewContainer.swift
//  ShurjopaySdk
//
//  Created by Rz Rasel on 2022-05-18
//

import Foundation
import UIKit
import WebKit

class ShurjoPayViewController: UIViewController {
    typealias onSuccess         = (_ transactionData: TransactionData?, ErrorSuccess) -> Void
    typealias onFailed          = (ErrorSuccess) -> Void
    typealias onProgressView    = (Bool) -> Void
    var onSuccess:      onSuccess?
    var onFailed:       onFailed?
    var onProgressView: onProgressView?
    private let webView         = WKWebView()
    private var requestData:    RequestData?
    private var tokenData:      TokenData?
    private var checkoutData:   CheckoutData?
    private var sdkType:        String?
    private var isSuccessUrl:   Bool = false
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        onCreateView()
    }
    func setListener(onSuccess: @escaping onSuccess,
                     onProgressView: @escaping onProgressView,
                     onFailed: @escaping onFailed) {
        self.onSuccess      = onSuccess
        self.onProgressView = onProgressView
        self.onFailed       = onFailed
    }
    func onLoadData(sdkType: String, requestData: RequestData, tokenData: TokenData, checkoutData: CheckoutData) {
        self.requestData    = requestData
        self.sdkType        = sdkType
        self.tokenData      = tokenData
        self.checkoutData   = checkoutData
        onLoad(location: checkoutData.checkoutUrl!)
    }
    private func onCreateView() {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.frame  = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(webView)
        webView.navigationDelegate = self
    }
    private func onLoad(location: String) {
        let url = URL(string: location)!
        webView.load(URLRequest(url: url))
    }
}
extension ShurjoPayViewController: WKNavigationDelegate, UIWebViewDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let url = webView.url?.absoluteString
        if url!.containsIgnoringCase(find: requestData?.cancelUrl) {
            self.dismiss(animated: true, completion: nil)
            return
        }
        if url!.containsIgnoringCase(find: requestData?.returnUrl) && url!.containsIgnoringCase(find: "order_id") {
            verifyPayment(sdkType: sdkType!)
            return
        }
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    }
}
extension ShurjoPayViewController {
    func verifyPayment(sdkType: String) {
        let verifyUrl = ApiClient.getApiClient(sdkType: sdkType).verify()
        let parameters: [String: Any] = [
            "order_id": checkoutData?.spOrderId! ?? ""
        ]
        let header = (tokenData?.tokenType)! + " " + (tokenData?.token)!
        Utils.onHttpRequest(httpMethod: HttpMethod.POST, location: verifyUrl, parameters: parameters, header: header, isEncoded: true) {
            (data: Data?, error: Error?) in
            guard error == nil else {
                self.dismissWindow()
                self.onFailed?(ErrorSuccess(
                    message:    "ERROR: \(error!.localizedDescription) CODE: \((#file as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")) \(#function) \(#line)",
                    esType:     ErrorSuccess.ESType.HTTP_ERROR
                ))
                return
            }
            var transactionDataList: [TransactionData] = []
            do {
                let decoder = JSONDecoder()
                transactionDataList = try decoder.decode([TransactionData].self, from: data!)
            }
            catch {
                self.dismissWindow()
                self.onFailed?(ErrorSuccess(
                    message:    "ERROR: \(error.localizedDescription) CODE: \((#file as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")) \(#function) \(#line)",
                    esType:     ErrorSuccess.ESType.HTTP_ERROR
                ))
                return
            }
            let transactionData: TransactionData = transactionDataList[transactionDataList.count - 1]
            if(transactionData.spCode == 1000) {
                self.dismissWindow()
                self.onSuccess?(transactionData, ErrorSuccess(
                    message:    "SUCCESS: Transaction success CODE: \((#file as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")) \(#function) \(#line)",
                    esType:     ErrorSuccess.ESType.HTTP_SUCCESS
                ))
                return
            } else {
                self.dismissWindow()
                self.onFailed?(ErrorSuccess(
                    message:    "ERROR: Transaction failed sp code CODE: \((#file as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")) \(#function) \(#line)",
                    esType:     ErrorSuccess.ESType.HTTP_ERROR
                ))
                return
            }
        }
    }

    func dismissWindow() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
