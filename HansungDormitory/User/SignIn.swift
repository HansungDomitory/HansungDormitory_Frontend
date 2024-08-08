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
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isSignUpSuccess = false
    
    @Environment(\.presentationMode) var presentationMode // 현재 화면의 presentation mode 환경 변수를 사용하여 이전 화면으로 돌아가기 위해 추가
    
    var body: some View{
        NavigationView {
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
                    signup()
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
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("회원가입 결과"), message: Text(alertMessage), dismissButton: .default(Text("확인"), action: {
                    if isSignUpSuccess {
                        presentationMode.wrappedValue.dismiss() // 회원가입 성공 시 현재 화면을 닫아 이전 화면으로 돌아감
                    }
                }))
                
            }
        }
    }
    
    func signup() {
        guard let url = URL(string: "http://3.145.59.24:3000/student") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "id": id,
            "name": name,
            "password": password
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            alertMessage = "요청 데이터 변환 실패"
            showingAlert = true
            return
        }
        
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    alertMessage = "오류: \(error.localizedDescription)"
                    showingAlert = true
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    alertMessage = "서버 응답 오류"
                    showingAlert = true
                }
                return
            }
            
            if httpResponse.statusCode == 201 {
                DispatchQueue.main.async {
                    alertMessage = "회원가입 성공!"
                    showingAlert = true
                    isSignUpSuccess = true
                }
            } else {
                DispatchQueue.main.async {
                    alertMessage = "회원가입 실패: \(httpResponse.statusCode)"
                    showingAlert = true
                }
            }
        }.resume()
    }
}
struct Signin_Previews: PreviewProvider {
    @State static var isLoggedIn = false
    
    static var previews: some View {
        Signin()
    }
}
