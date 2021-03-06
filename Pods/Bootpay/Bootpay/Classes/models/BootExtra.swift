//
//  BootExtra.swift
//  SwiftUIBootpay
//
//  Created by Taesup Yoon on 2021/05/10.
//
import ObjectMapper


public class BootExtra: NSObject, Mappable, Codable {
    
    
    public override init() {
        super.init()
        self.appScheme = self.externalURLScheme() 
//        self.appScheme = (self.externalURLScheme() ?? "") + "://"
    }
    public required init?(map: Map) {
        super.init() 
        mapping(map: map)
    }
    
    func externalURLScheme() -> String? {
        guard let urlTypes = Bundle.main.infoDictionary?["CFBundleURLTypes"] as? [AnyObject],
            let urlTypeDictionary = urlTypes.first as? [String: AnyObject],
            let urlSchemes = urlTypeDictionary["CFBundleURLSchemes"] as? [AnyObject],
            let externalURLScheme = urlSchemes.first as? String else { return nil }

        return externalURLScheme
    }
    
    public func mapping(map: Map) {
        cardQuota <- map["card_quota"]
        sellerName <- map["seller_name"]
        deliveryDay <- map["delivery_day"]
        locale <- map["locale"]
        offerPeriod <- map["offer_period"]
        
        displayCashReceipt <- map["display_cash_receipt"]
        depositExpiration <- map["deposit_expiration"]
        appScheme <- map["app_scheme"]
        useCardPoint <- map["use_card_point"]
        directCard <- map["direct_card"]
        
        useOrderId <- map["use_order_id"]
        internationalCardOnly <- map["international_card_only"]
        phoneCarrier <- map["phone_carrier"]
        directAppCard <- map["direct_app_card"]
        directSamsungpay <- map["direct_samsungpay"]
        testDeposit <- map["test_deposit"]
        enableErrorWebhook <- map["enable_error_webhook"]
        separatelyConfirmed <- map["separately_confirmed"]
        confirmOnlyRestApi <- map["confirm_only_rest_api"]
        openType <- map["open_type"]
        redirectUrl <- map["redirect_url"]
        displaySuccessResult <- map["display_success_result"]
        displayErrorResult <- map["display_error_result"]
        useWelcomepayment <- map["use_welcomepayment"]
    }
    
    @objc public var cardQuota: String? //???????????? ?????? (5?????? ?????? ?????????)
    @objc public var sellerName: String? //???????????? ???????????? ??????
    @objc public var deliveryDay: Int = 1 //????????????
    @objc public var locale = "ko" //????????? ????????????
    @objc public var offerPeriod: String? //????????? ??????????????? ???????????? string ???, ???????????? PG??? ?????????
    @objc public var displayCashReceipt = true // ??????????????? ????????? ??????.. ???????????? KCP ??????
    @objc public var depositExpiration = "" //???????????? ?????? ???????????? ??????
    @objc public var appScheme: String? //????????? ????????? ?????? ?????? ??? ???????????? ?????? ( ???????????? ?????? )
    @objc public var useCardPoint = true //?????? ????????? ?????? ?????? (????????? ??????)
    @objc public var directCard = "" //?????? ????????? ?????? ????????? (????????? ??????)
    @objc public var useOrderId = false //????????? order_id??? PG??? ??????
    @objc public var internationalCardOnly = false //?????? ???????????? ?????? ?????? (????????? ??????)
    @objc public var phoneCarrier: String? //???????????? ??? ????????? ????????????, SKT,KT,LGT ??? 1?????? ??????
    @objc public var directAppCard = false //?????????????????? direct ??????
    @objc public var directSamsungpay = false //???????????? ?????? ?????????
    @objc public var testDeposit = false //???????????? ?????? ??????
    @objc public var enableErrorWebhook = false //?????? ????????? Feedback URL??? webhook
//    @objc public var popup = true //??????????????? ??? ?????? PG ??? ?????? popup??? true??? ?????????
    @objc public var separatelyConfirmed = true // confirm ???????????? ???????????? ??????, false??? ?????? ????????????
    @objc public var confirmOnlyRestApi = false //REST API?????? ?????? ??????
    @objc public var openType = "redirect" //????????? ?????? type, [iframe, popup, redirect] ??? ??? 1
    @objc public var useBootpayInappSdk = true //native app????????? redirect??? ??????????????? ???????????? ?????? ??????
    @objc public var redirectUrl: String? = "https://api.bootpay.co.kr/v2" //open_type??? redirect??? ?????? ????????? ????????? URL (  ?????? ??? ?????? ?????? ?????? ?????? ?????? )
    @objc public var displaySuccessResult = false //?????? ???????????? ??????????????? ???????????? ??????????????? ???????????? ( open_type??? iframe, popup ????????? ?????? )
    @objc public var displayErrorResult = true //????????? ???????????? ??????????????? ???????????? ??????????????? ???????????? ( open_type??? iframe, popup ????????? ?????? )
    @objc public var useWelcomepayment = false //?????? ???????????? ????????? true
}
