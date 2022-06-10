//
//  AuthenticationView.swift
//  pgTestSwiftUI
//
//  Created by Taesup Yoon on 2022/06/09.
//

import SwiftUI
import Bootpay
import BootpayUI

struct AuthenticationView: View {
    
    @State private var showingBootpay = false
    private var payload = Payload()
    
    var body: some View {
        
        VStack {
            if(self.showingBootpay) {
                BootpayUI(payload: payload, requestType: BootpayRequest.TYPE_AUTHENTICATION)
                    .onCancel { data in
                        print("-- cancel: \(data)")
                    }
                    .onIssued { data in
                        print("-- ready: \(data)")
                    }
                    .onConfirm { data in
                        print("-- confirm: \(data)")
                        return true //재고가 있어서 결제를 최종 승인하려 할 경우
    //                            return true //재고가 없어서 결제를 승인하지 않을때
    //                            return false
                    }
                    .onDone { data in
                        print("-- done: \(data)")
                    }
                    .onError { data in
                        print("-- error: \(data)")
                        self.showingBootpay = false
                    }
                    .onClose {
                        print("-- close")
                        self.showingBootpay = false
                    }.onDisappear {
                        //swipe back으로 사라졌을때 close 이벤트를 호출해준다
                        Bootpay.shared.debounceClose()
                    }
            } else {
                Button("통합결제 결제테스트") {
                    showingBootpay = true

                    #if os(macOS)
                    payload.applicationId = "5b8f6a4d396fa665fdc2b5e7" //web application id
                    #elseif os(iOS)
                    payload.applicationId = "5b8f6a4d396fa665fdc2b5e9" //ios application id
                    #endif

                    payload.pg = "다날"
                    payload.method = "본인인증"

//                    Bootpay.shared.request_type = BootpayConstant.REQUEST_TYPE_AUTH
                    
                    payload.price = 1000
                    payload.orderId = String(NSTimeIntervalSince1970)
//                    payload.authenticationId = String(NSTimeIntervalSince1970)
                    
                    payload.orderName = "테스트 아이템"

                    payload.extra = BootExtra()
    //                        payload.extra?.cardQuota = "6"

                    let user = BootUser()
                    user.username = "테스트 유저"
                    user.phone = "01012345678"
                    payload.user = user
                }.sheet(isPresented: self.$showingBootpay) {
                }
            }
        }.navigationBarHidden(true)
        
    }
}
