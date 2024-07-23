//
//  ApplyView.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/8/24.
//

import Foundation
import SwiftUI

struct ApplyView: View {
    
    @StateObject private var viewModel = LeaveRequestViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
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
                        
                        ForEach(viewModel.requests) { request in
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
                .onAppear {
                    viewModel.fetchLeaveRequests()
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: ApplyDetailView()) {
                            Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color(red: 4/255, green: 45/255, blue: 111/255))
                                .padding(.bottom, 130)
                                .padding(.trailing, 20)
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

class LeaveRequestViewModel: ObservableObject {
    @Published var requests: [LeaveRequest] = []
    
    func fetchLeaveRequests() {
        guard let url = URL(string: "http://218.39.3.116/apply") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let requests = try decoder.decode([LeaveRequest].self, from: data)
                    DispatchQueue.main.async {
                        self.requests = requests
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
        
        task.resume()
    }
}

struct ApplyView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyView()
    }
}
