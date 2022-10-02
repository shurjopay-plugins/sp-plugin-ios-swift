//
//  Transaction.swift
//  ShurjopaySdk
//
//  Created by Rz Rasel on 2022-05-11
//
import Foundation

public struct TransactionData: Codable {
    public var id:                  Int?
    public var orderId:             String?
    public var currency:            String?
    public var amount:              Double?
    public var payableAmount:       Double?
    public var discsountAmount:     Double?
    public var discPercent:         Double?
    public var usdAmt:              Double?
    public var usdRate:             Double?
    public var cardHolderName:      String?
    public var cardNumber:          String?
    public var phoneNo:             String?
    public var bankTrxId:           String?
    public var invoiceNo:           String?
    public var bankStatus:          String?
    public var customerOrderId:     String?
    public var spCode:              Int?
    public var spMassage:           String?
    public var name:                String?
    public var email:               String?
    public var address:             String?
    public var city:                String?
    public var transactionStatus:   String?
    public var dateTime:            String?
    public var method:              String?
    public var value1:              String?
    public var value2:              String?
    public var value3:              String?
    public var value4:              String?
    
    enum CodingKeys: String, CodingKey {
        case id                 = "id"
        case orderId            = "order_id"
        case currency           = "currency"
        case amount             = "amount"
        case payableAmount      = "payable_amount"
        case discsountAmount    = "discsount_amount"
        case discPercent        = "disc_percent"
        case usdAmt             = "usd_amt"
        //
        case usdRate            = "usd_rate"
        case cardHolderName     = "card_holder_name"
        case cardNumber         = "card_number"
        case phoneNo            = "phone_no"
        case bankTrxId          = "bank_trx_id"
        case invoiceNo          = "invoice_no"
        case bankStatus         = "bank_status"
        case customerOrderId    = "customer_order_id"
        //
        case spCode             = "sp_code"
        case spMassage          = "sp_massage"
        case name               = "name"
        case email              = "email"
        case address            = "address"
        case city               = "city"
        case transactionStatus  = "transaction_status"
        //
        case dateTime           = "date_time"
        case method             = "method"
        case value1             = "value1"
        case value2             = "value2"
        case value3             = "value3"
        case value4             = "value4"
    }
}
