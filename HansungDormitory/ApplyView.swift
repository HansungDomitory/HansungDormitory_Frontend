//
//  ApplyView.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/8/24.
//

import Foundation
import SwiftUI

struct LeaveRequest: Identifiable {
    let id = UUID()
    let number: Int
    let startDate: String
    let endDate: String
    let daysOut: Int
    let registrationDate: String
}

struct ApplyView: View {
    let requests = [
        LeaveRequest(number: 33, startDate: "2024.06.23", endDate: "2024.06.25", daysOut: 2, registrationDate: "2024.06.22"),
        LeaveRequest(number: 32, startDate: "2024.06.18", endDate: "2024.06.19", daysOut: 1, registrationDate: "2024.06.18"),
        LeaveRequest(number: 31, startDate: "2024.06.10", endDate: "2024.06.15", daysOut: 5, registrationDate: "2024.06.10"),
        LeaveRequest(number: 30, startDate: "2024.06.05", endDate: "2024.06.06", daysOut: 1, registrationDate: "2024.06.05")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 30)
                    .padding(.leading)
                Spacer()
            }
            .padding(.vertical)
            
            // Title
            HStack {
                Spacer()
                Text("외박 신청")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom,20)
            
            // Leave Requests Table
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("번호")
                        .fontWeight(.bold)
                    Spacer()
                    Text("기간")
                        .fontWeight(.bold)
                    Spacer()
                    Text("외박일수")
                        .fontWeight(.bold)
                    
                    Text("등록일자")
                        .fontWeight(.bold)
                    Spacer()
                    Text("비고")
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                Divider()
                
                ForEach(requests) { request in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(request.number)")
                            Spacer()
                            VStack {
                                Text(request.startDate)
                                    .font(.subheadline)
                                Text("~")
                                    .font(.subheadline)
                                Text(request.endDate)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Spacer()
                            Text("\(request.daysOut)")
                                .font(.subheadline)
                            Spacer()
                            Spacer()
                            Text(request.registrationDate)
                                .font(.subheadline)
                            Spacer()
                            HStack(spacing: 4) {
                                Button(action: {
                                    // 수정 버튼 액션
                                }) {
                                    Text("수정")
                                        .font(.system(size: 15, weight: .bold))
                                        .padding(2)
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(4)
                                }
                                Button(action: {
                                    // 삭제 버튼 액션
                                }) {
                                    Text("삭제")
                                        .font(.system(size: 15, weight: .bold))
                                        .padding(2)
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(4)
                                }
                            }
                        }
                        .padding(.horizontal)
                        Divider()
                    }
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

struct ApplyView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyView()
    }
}
