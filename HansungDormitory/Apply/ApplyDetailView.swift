//
//  ApplyDetailView.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/18/24.
//

import Foundation
import SwiftUI

struct ApplyDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var reason = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var leaveRequest: LeaveRequest?
       
       init(leaveRequest: LeaveRequest? = nil) {
           self.leaveRequest = leaveRequest
           if let leaveRequest = leaveRequest {
               _startDate = State(initialValue: leaveRequest.startDate.toDate())
               _endDate = State(initialValue: leaveRequest.endDate.toDate())
               _reason = State(initialValue: leaveRequest.detail)
           }
       }
    
    var body: some View {
        VStack(spacing: 20) {
            // 로고 및 타이틀
            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 30)
                Spacer()
            }
            .padding(.leading)
            
            Text("외박 신청")
                .font(.system(size: 30, weight: .bold))
                .padding(.bottom, 20)
            
            // 학번 및 이름
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("학번")
                        .font(.headline)
                    Spacer()
                    Text("2071268")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                Divider()
                HStack {
                    Text("이름")
                        .font(.headline)
                    Spacer()
                    Text("장수희")
                        .font(.headline)
                }
                Divider()
                
                // 날짜 선택
                HStack {
                    Text("날짜")
                        .font(.headline)
                    Spacer()
                    DatePicker("", selection: $startDate, displayedComponents: .date)
                        .labelsHidden()
                    Text("~")
                    DatePicker("", selection: $endDate, displayedComponents: .date)
                        .labelsHidden()
                }
                Divider()
                
                // 외박일수
                HStack {
                    Text("외박일수")
                        .font(.headline)
                    Spacer()
                    Text("\(calculateDays(start: startDate, end: endDate))박 (\(formattedDate(startDate)) ~ \(formattedDate(endDate)))")
                }
                Divider()
                
                // 내용
                VStack(alignment: .leading) {
                    Text("내용")
                        .font(.headline)
                    TextEditor(text: $reason)
                        .frame(height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }
            .padding()
            
            // 신청하기 버튼
            Button(action: {
                submitLeaveRequest()
            }) {
                Text(leaveRequest != nil ? "수정하기" : "신청하기")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
            }
            .background(Color(red: 4/255, green: 45/255, blue: 111/255))
            .cornerRadius(10)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("외박 신청"), message: Text(alertMessage), dismissButton: .default(Text("확인")) {
                    self.presentationMode.wrappedValue.dismiss()
                })
            }

            Spacer()
        }
        .padding()
    }
    
    func submitLeaveRequest() {
        let requestId = leaveRequest?.id
                let urlString = requestId != nil ? "http://3.145.59.24:3000/apply/\(requestId!)" : "http://3.145.59.24:3000/apply"
                guard let url = URL(string: urlString) else { return }
            guard let token = UserDefaults.standard.string(forKey: "accessToken") else {
                self.alertMessage = "로그인이 필요합니다."
                self.showAlert = true
                return
            }
            
            var request = URLRequest(url: url)
        request.httpMethod = requestId != nil ? "PATCH" : "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let body: [String: Any] = [
                "start_date": formattedDate(startDate),
                "end_date": formattedDate(endDate),
                "detail": reason
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                print("Error serializing JSON: \(error)")
                return
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 || httpResponse.statusCode == 200 {
                        self.alertMessage = requestId != nil ? "외박 신청이 성공적으로 수정되었습니다." : "외박 신청이 성공적으로 처리되었습니다."
                    } else {
                        self.alertMessage = "외박 신청 처리 중 오류가 발생했습니다: \(error?.localizedDescription ?? "알 수 없는 오류")"
                    }
                    self.showAlert = true
                }
            }.resume()
        }


    // 날짜 형식 지정
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    // 외박일수 계산
    func calculateDays(start: Date, end: Date) -> Int {
        let calendar = Calendar.current
        
        // 날짜를 비교하여 동일한 경우 0을 반환
        if calendar.isDate(start, equalTo: end, toGranularity: .day) {
            return 0
        }
        
        // start와 end 사이의 일수 계산
        let components = calendar.dateComponents([.day], from: start, to: end)
        
        // start와 end 사이의 일수를 반환
        return components.day!
    }
}

struct ApplyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyDetailView()
    }
}

extension String {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self) ?? Date()
    }
}
