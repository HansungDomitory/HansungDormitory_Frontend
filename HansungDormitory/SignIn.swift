//
//  SignIn.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/3/24.
//

import Foundation
import SwiftUI

struct Signin: View{
    @State private var name: String = ""
    @State private var id: String = ""
    @State private var password: String = ""
    
    var body: some View{
        VStack{
            HStack{
                Image("logoImage")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Text("한성대학교 생활관")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 4/255, green: 45/255, blue: 111/255))
            }
            .padding(.bottom, 50)
            Text("회원가입")
                .font(.system(size: 25, weight: .bold))
                .padding(.bottom, 30)
            HStack{
                Text("이름 : ")
                    .padding(.leading, 20)
                
                TextField("이름을 입력해주세요", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, 30)
                    .padding(.trailing, 20)
                   
            }
            .padding(.bottom, 20)
            
            HStack{
                Text("학번 : ")
                    .padding(.leading, 20)
                
                TextField("학번을 입력해주세요", text: $id)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, 30)
                    .padding(.trailing, 20)
            }
            .padding(.bottom, 20)
            
            HStack{
                Text("비밀번호 : ")
                    .padding(.leading, 20)
                
                SecureField("비밀번호를 입력해주세요", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.trailing, 20)
            }
            .padding(.bottom, 80)
           
            
            Button(action: {
                // 로그인 버튼 액션
                }) {
                Text("회원가입")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                .background(Color(red: 4/255, green: 45/255, blue: 111/255))
                .cornerRadius(10)
                .padding(.horizontal, 50)
        }
        .padding()
    }
}
struct Signin_Previews: PreviewProvider {
    static var previews: some View {
        Signin()
    }
}
