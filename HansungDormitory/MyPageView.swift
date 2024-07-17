//
//  MyPageView.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/17/24.
//

import Foundation
import SwiftUI

struct MyPageView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 로고 및 타이틀
                HStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 30)
                        .padding(.leading)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                Text("마이페이지")
                    .font(.system(size: 30, weight: .bold))
                    .padding(.bottom, 20)
                
                // 사용자 정보 및 배정된 방
                VStack(spacing: 10) {
                    HStack {
                        Spacer()
                        Text("장수희님")
                            .font(.system(size: 25, weight: .bold))
                        Spacer()
                        Image("myImage")
                            .resizable()
                            .frame(width: 80, height: 100)
                            .foregroundColor(Color(red: 4/255, green: 45/255, blue: 111/255))
                    }
                    .padding()
                    
                    HStack {
                        Text("장수희님의 배정된 방은 ")
                        Text("504-2")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                        Text("호입니다.")
                    }
                    .foregroundColor(.black)
                    .padding(.bottom, 10)
                    .padding(.horizontal)
                    .cornerRadius(10)
                }
                .padding()
                .background(Color(white: 0.95))
                .cornerRadius(15)
                .shadow(radius: 2)
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                // 공지사항 및 외박현황
                VStack {
                    HStack {
                        Image(systemName: "bell.fill")
                        Text("공지사항")
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    
                    Divider()
                    
                    HStack {
                        Image(systemName: "pencil")
                        Text("외박현황")
                        Spacer()
                    }
                    .padding(.vertical, 10)
                }
                .padding()
                .background(Color(white: 0.95))
                .cornerRadius(15)
                .shadow(radius: 2)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, 20) // 최상단과의 간격 조정
            .navigationBarHidden(true)
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
