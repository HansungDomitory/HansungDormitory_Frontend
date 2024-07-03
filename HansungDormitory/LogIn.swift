//
//  LogIn.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/3/24.
//

import Foundation
import SwiftUI

struct Login: View {
    @State private var studentID: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            HStack{
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Text("한성대학교 생활관")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 4/255, green: 45/255, blue: 111/255)) // 텍스트 색상 설정
            }
            .padding(.bottom, 30)
            Text("LOGIN")
                .font(.system(size: 40, weight: .bold))
                .padding(.bottom, 10)
            Text("회원 서비스를 이용하시려면 로그인이 필요합니다.")
                .font(.system(size: 12))
                .padding(.bottom, 50)
            
            TextField("학번을 입력해주세요", text: $studentID)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
            
            SecureField("비밀번호를 입력해주세요", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
            
            Button(action: {
                // 로그인 버튼 액션
                }) {
                Text("로그인")
                    .font(.headline)
                    .foregroundColor(.white) // 버튼 텍스트 색상 설정
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                .background(Color(red: 4/255, green: 45/255, blue: 111/255)) // 버튼 배경 색상 설정
                .cornerRadius(10)
                .padding(.horizontal, 40)
        }
        .padding()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
