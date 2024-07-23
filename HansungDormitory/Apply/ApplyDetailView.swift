//
//  ApplyDetailView.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/18/24.
//

import Foundation
import SwiftUI

struct ApplyDetailView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var reason = ""
    
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
                // 신청하기 액션
            }) {
                Text("신청하기")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
            }
            .background(Color(red: 4/255, green: 45/255, blue: 111/255))
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
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
        // 종료일을 포함해야 하므로 +1을 해줌
        return components.day! + 1
    }
}

struct ApplyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyDetailView()
    }
}
