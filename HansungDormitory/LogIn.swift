//
//  LogIn.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/3/24.
//

import Foundation
import SwiftUI

struct Login: View {
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Image("logoImage")
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
                
                TextField("학번을 입력해주세요", text: $id)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                
                SecureField("비밀번호를 입력해주세요", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 30)
                    .padding(.bottom, 50)
                
                Button(action: {
                    login()
                }) {
                    Text("로그인")
                        .font(.headline)
                        .foregroundColor(.white) // 버튼 텍스트 색상 설정
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(Color(red: 4/255, green: 45/255, blue: 111/255)) // 버튼 배경 색상 설정
                .cornerRadius(10)
                .padding(.horizontal, 10)
                
                HStack {
                    Text("아직 회원이 아니신가요?")
                        .font(.system(size: 12))
                        .padding(.bottom, 40)
                    
                    NavigationLink(destination: Signin()) {
                        
                        Text("회원가입")
                            .font(.system(size: 12))
                            .padding(.leading, 60)
                            .foregroundColor(.black)
                    }
                    .padding(.bottom, 40)
                }
            }
            .padding()
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("로그인 결과"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
            }
        }
    }
    
    func login() {
        guard let url = URL(string: "http://218.39.3.116/login") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = ["id": id, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    alertMessage = "오류: \(error.localizedDescription)"
                    showingAlert = true
                }
                return
            }
            
            guard data != nil else {
                DispatchQueue.main.async {
                    alertMessage = "데이터를 받지 못했습니다"
                    showingAlert = true
                }
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 201 {
                DispatchQueue.main.async {
                    alertMessage = "로그인 성공!"
                    showingAlert = true
                    isLoggedIn = true // 로그인 성공 시 상태 변경
                }
            } else {
                DispatchQueue.main.async {
                    alertMessage = "잘못된 자격 증명 또는 서버 오류"
                    showingAlert = true
                }
            }
        }.resume()
    }
}
struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(isLoggedIn: .constant(false))
    }
}
