//
//  MyPageView.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/17/24.
//

import Foundation
import SwiftUI

struct MyPageView: View {
    @State private var userName: String = ""
    @State private var UserRoom: String = ""
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
                        Text("\(userName)님")
                            .font(.system(size: 25, weight: .bold))
                        Spacer()
                        Image("myImage")
                            .resizable()
                            .frame(width: 80, height: 100)
                            .foregroundColor(Color(red: 4/255, green: 45/255, blue: 111/255))
                    }
                    .padding()
                    
                    HStack {
                        Text("\(userName)님의 배정된 방은 ")
                        Text("\(UserRoom)")
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
                    NavigationLink(destination: NoticeView()) {
                        HStack {
                            Image(systemName: "bell.fill")
                            Text("공지사항")
                            Spacer()
                        }
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                    }
                    Divider()
                    
                    NavigationLink(destination: ApplyView()) {
                        HStack {
                            Image(systemName: "pencil")
                            Text("외박현황")
                            Spacer()
                        }
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                    }
                    Divider()
                    
                    NavigationLink(destination: ScoreView()) {
                        HStack {
                            Image(systemName: "heart.circle.fill")
                            Text("상벌점현황")
                            Spacer()
                        }
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                    }
                }
                .padding()
                .background(Color(white: 0.95))
                .cornerRadius(15)
                .shadow(radius: 2)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, 20)
            .navigationBarHidden(true)
            .onAppear {
                fetchUserInfo()
            }
        }
    }
    func fetchUserInfo() {
        UserService.shared.fetchUserInfo { result in
            switch result {
            case .success(let userInfo):
                if let name = userInfo["name"] as? String,
                   let room = userInfo["room"] as? String {
                    DispatchQueue.main.async {
                        self.userName = name
                        self.UserRoom = room
                    }
                }
            case .failure(let error):
                print("Failed to fetch user info: \(error)")
            }
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
