//
//  PasswordPaymentView.swift
//  pgTestSwiftUI
//
//  Created by Taesup Yoon on 2022/06/09.
//

import SwiftUI
import Bootpay
import BootpayUI

struct PasswordPaymentView: View {
    @ObservedObject private var viewModel = ViewModel()
    let user = BootUser()
    private var payload = Payload()
    
     
   var body: some View {
       GeometryReader { geometry in
           VStack {
//               if(self.viewModel.showingBootpay == false) {
               Button("비밀번호 결제 테스트") {
                   bootpayStart(isPasswordMode: true)
               }.padding()
               .sheet(isPresented: self.$viewModel.showingBootpay) {
                   BootpayUI(payload: payload, requestType: BootpayRequest.TYPE_PASSWORD, userToken: self.viewModel.easyPayUserToken)
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
                           self.viewModel.showingBootpay = false
                       }
                       .onClose {
                           print("-- close")
                           self.viewModel.showingBootpay = false
                       }.onDisappear {
                           //swipe back으로 사라졌을때 close 이벤트를 호출해준다
                           Bootpay.shared.debounceClose()
                       }
                       
               }
           }.frame(width: geometry.size.width, height: geometry.size.height)
               .navigationBarHidden(true)
       }
   }
    
    func bootpayStart(isPasswordMode: Bool) {
        
        user.id = "123456abcdffffe2345678901234561324516789122"
        user.area = "서울"
        user.gender = 1
        user.email = "test1234@gmail.com"
        user.phone = "01012344567"
        user.birth = "1988-06-10"
        user.username = "홍길동"
        
        #if os(macOS)
        payload.applicationId = "5b8f6a4d396fa665fdc2b5e7" //web application id
        #elseif os(iOS)
        payload.applicationId = "5b8f6a4d396fa665fdc2b5e9" //ios application id
        #endif

        payload.pg = "나이스페이"

        payload.price = 1000
        payload.orderId = String(NSTimeIntervalSince1970)
        //                        payload.name = "테스트 아이템"
        payload.orderName = "Touch ID 인증 결제 테스트"
 
        payload.user = user

        payload.extra = BootExtra()
        payload.extra?.cardQuota = "6"
        payload.extra?.displaySuccessResult = true

        let p1 = BootBioPrice()
        let p2 = BootBioPrice()
        let p3 = BootBioPrice()

        p1.name = "상품가격"
        p1.price = 89000

        p2.name = "쿠폰적용"
        p2.price = -2500

        p3.name = "배송비"
        p3.price = 2500
 
        viewModel.getUserToken(user: user)
    }
}
