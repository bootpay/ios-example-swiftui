//
//  PasswordUIPaymentView.swift
//  pgTestSwiftUI
//
//  Created by Taesup Yoon on 2022/06/09.
//

import SwiftUI
import Bootpay
import BootpayUI

struct PasswordUIPaymentView: View {
    @ObservedObject private var viewModel = ViewModel()
    let user = BootUser()
    private var payload = BootBioPayload()
    
    
    
   var body: some View {
       GeometryReader { geometry in
           VStack {
//               if(self.viewModel.showingBootpay == false) {
               Button("비밀번호UI 결제 테스트") {
                   bootpayStart(isPasswordMode: true)
               }.padding()
               .sheet(isPresented: self.$viewModel.showingBootpay) {
                   BootpayBioUI(
                    payload: self.payload,
                    userToken: self.viewModel.easyPayUserToken,
                    showBootpay: self.$viewModel.showingBootpay
                   )
                       .onError{ data in
                           print("-- error \(data)")
                       }.onIssued{ data in
                           print("-- ready \(data)")
                       }
                       .onConfirm { data in
                           print("-- confirm  \(data)")
                           return true
                       }
                       .onCancel { data in
                           print("-- cancel  \(data)")
                       }
                       .onDone { data in
                           print("-- done \(data)")
                       }
                       .onClose {
                           print("-- close")
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

        payload.names = ["플리츠레이어 카라숏원피스", "블랙 (COLOR)", "55 (SIZE)"]
           
//                        payload.userToken = token
        payload.user = user
        payload.isPasswordMode = isPasswordMode

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

        payload.prices = [p1, p2, p3]
        viewModel.getUserToken(user: user)
    }
}
