//
//  ShurjopaySdkPlugin.swift
//  ShurjopaySdk
//
//  Created by Rz Rasel on 2022-05-16
//
import Foundation
import UIKit

class ShurjopaySdkPlugin {
    //
    typealias onSuccess         = (_ transactionData: TransactionData?, ErrorSuccess) -> Void
    typealias onFailed          = (ErrorSuccess) -> Void
    typealias onProgressView    = (Bool) -> Void
    var onSuccess:      onSuccess?
    var onFailed:       onFailed?
    var onProgressView: onProgressView?
    var uiProperty:     UIProperty?
    var viewController: UIViewController?
    var progressBar:    ProProgressBar?
    var requestData:    RequestData?
    var sdkType:        String?
    init(onSuccess: @escaping onSuccess,
         onProgressView: @escaping onProgressView,
         onFailed: @escaping onFailed) {
        self.onSuccess      = onSuccess
        self.onProgressView = onProgressView
        self.onFailed       = onFailed
    }
    func onSDKPlugin(uiProperty: UIProperty, sdkType: String, requestData: RequestData) {
        self.uiProperty     = uiProperty
        self.viewController = uiProperty.viewController
        self.sdkType        = sdkType
        self.requestData    = requestData
        showProgressView()
        guard onCheckInternet() == true else {
            hideProgressView()
            self.onFailed?(ErrorSuccess(
                message:    "ERROR: Error in internet connection CODE: \((#file as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")) \(#function) \(#line)",
                esType:     ErrorSuccess.ESType.INTERNET_ERROR
            ))
            return
        }
        getToken()
    }
    private func getToken() {
        let tokenUrl = ApiClient.getApiClient(sdkType: sdkType!).getToken()
        let parameters: [String: Any] = [
            "username": requestData?.username ?? "",
            "password": requestData?.password ?? ""
        ]
        Utils.onHttpRequest(httpMethod: HttpMethod.POST, location: tokenUrl, parameters: parameters, header: nil, isEncoded: true) {
            (data: Data?, error: Error?) in
            guard error == nil else {
                self.hideProgressView()
                self.onFailed?(ErrorSuccess(
                    message:    error!.localizedDescription,
                    esType:     ErrorSuccess.ESType.HTTP_ERROR
                ))
                return
            }
            let jsonData    = Utils.getJsonData(responseData: data!)
            //let spCode      = jsonData?["sp_code"]
            var tokenData   = TokenData()
            tokenData.username      = self.requestData?.username
            tokenData.password      = self.requestData?.password
            tokenData.token         = jsonData!["token"] as? String
            tokenData.storeId       = jsonData!["store_id"] as? Int
            tokenData.executeUrl    = jsonData!["execute_url"] as? String
            tokenData.tokenType     = jsonData!["token_type"] as? String
            tokenData.spCode        = jsonData!["sp_code"] as? Int
            tokenData.massage       = jsonData!["massage"] as? String
            tokenData.expiresIn     = jsonData!["expires_in"] as? Int
            self.getExecuteUrl(tokenData: tokenData)
        }
    }
    private func getExecuteUrl(tokenData: TokenData) {
        let checkoutUrl = ApiClient.getApiClient(sdkType: sdkType!).checkout()
        let parameters: [String: Any] = [
            "token":                tokenData.token!,
            "store_id":             tokenData.storeId!,
            "prefix":               requestData!.prefix!,
            "currency":             requestData!.currency!,
            "amount":               requestData!.amount!,
            "order_id":             requestData!.orderId!,
            "discsount_amount":     requestData!.discountAmount!,
            "disc_percent":         requestData!.discPercent!,
            "client_ip":            requestData!.clientIp!,
            "customer_name":        requestData!.customerName!,
            "customer_phone":       requestData!.customerPhone!,
            "customer_email":       requestData!.customerEmail!,
            "customer_address":     requestData!.customerAddress!,
            "customer_city":        requestData!.customerCity!,
            "customer_state":       requestData!.customerState!,
            "customer_postcode":    requestData!.customerPostcode!,
            "customer_country":     requestData!.customerCountry!,
            "return_url":           requestData!.returnUrl!,
            "cancel_url":           requestData!.cancelUrl!,
            "value1":               requestData!.value1!,
            "value2":               requestData!.value2!,
            "value3":               requestData!.value3!,
            "value4":               requestData!.value4!,
            ]
        Utils.onHttpRequest(httpMethod: HttpMethod.POST, location: checkoutUrl, parameters: parameters, header: nil, isEncoded: true) {
            (data: Data?, error: Error?) in
            guard error == nil else {
                self.hideProgressView()
                self.onFailed?(ErrorSuccess(
                    message:    "ERROR: \(error!.localizedDescription) CODE: \((#file as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")) \(#function) \(#line)",
                    esType:     ErrorSuccess.ESType.HTTP_ERROR
                ))
                return
            }
            var checkoutData: CheckoutData?
            do {
                let decoder = JSONDecoder()
                checkoutData = try decoder.decode(CheckoutData.self, from: data!)
            } catch {
                self.hideProgressView()
                self.onFailed?(ErrorSuccess(
                    message:    "ERROR: \(error.localizedDescription) CODE: \((#file as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")) \(#function) \(#line)",
                    esType:     ErrorSuccess.ESType.HTTP_ERROR
                ))
                return
            }
            self.hideProgressView()
            self.showWebView(tokenData: tokenData, checkoutData: checkoutData!)
        }
    }
    private func showWebView(tokenData: TokenData, checkoutData: CheckoutData) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: self.uiProperty!.storyboardName, bundle: nil)
            let sPayViewController = storyboard.instantiateViewController(withIdentifier: self.uiProperty!.identifier) as! ShurjoPayViewController
            sPayViewController.modalPresentationStyle = .fullScreen
            sPayViewController.setListener(onSuccess: self.onSuccess!,
                                           onProgressView: self.onProgressView!,
                                           onFailed: self.onFailed!)
            sPayViewController.onLoadData(sdkType: self.sdkType!, requestData: self.requestData!, tokenData: tokenData, checkoutData: checkoutData)
            self.viewController!.present(sPayViewController, animated: true, completion: nil)
        }
    }
    func showProgressView() {
        DispatchQueue.main.async {
            self.progressBar = ProProgressBar(label: "Loading...")
            self.progressBar?.show(viewController: self.viewController!)
        }
    }
    func hideProgressView() {
        DispatchQueue.main.async {
            self.progressBar?.hide(viewController: self.viewController!)
        }
    }
}

extension ShurjopaySdkPlugin {
    func onCheckInternet() -> Bool {
        guard NetConnection.isConnected() == true else {
            return false
        }
        self.onSuccess?(nil, ErrorSuccess(
            message:    "SUCCESS: Net connected CODE: \((#file as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")) \(#function) \(#line)",
            esType:     ErrorSuccess.ESType.INTERNET_SUCCESS
        ))
        return true
    }
}
