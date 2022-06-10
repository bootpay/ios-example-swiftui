//
//  ContentView.swift
//  pgTestSwiftUI
//
//  Created by Taesup Yoon on 2022/06/09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: DefaultPaymentView(),
                    label: {
                        Text("1. PG일반 결제 테스트")
                }).padding()
                NavigationLink(
                    destination: TotalPaymentView(),
                    label: {
                        Text("2. 통합결제 테스트")
                }).padding()
                NavigationLink(
                    destination: SubscriptionView(),
                    label: {
                        Text("3. 카드자동 결제 테스트 (인증)")
                }).padding()
                NavigationLink(
                    destination: SubscriptionBootpayView(),
                    label: {
                        Text("4. 카드자동 결제 테스트 (비인증)")
                }).padding()
                NavigationLink(
                    destination: AuthenticationView(),
                    label: {
                        Text("5. 본인인증 테스트")
                }).padding()
                NavigationLink(
                    destination: BioPaymentView(),
                    label: {
                        Text("6. 생체인증 결제 테스트")
                }).padding()
                NavigationLink(
                    destination: PasswordPaymentView(),
                    label: {
                        Text("7. 비밀번호 결제 테스트 - Bootpay")
                }).padding()
                NavigationLink(
                    destination: PasswordUIPaymentView(),
                    label: {
                        Text("8. 비밀번호 결제 테스트 - BootpayUI")
                }).padding()
                NavigationLink(
                    destination: WebAppView(),
                    label: {
                        Text("9. 웹앱으로 연동하기")
                }).padding()
            }.navigationBarHidden(true)
        }
        
    }
}
