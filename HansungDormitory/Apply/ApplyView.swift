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
                        
                        ForEach(Array(viewModel.requests.enumerated()), id: \.element.id) { index, request in
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("\(viewModel.requests.count - index)")
                                        .font(.subheadline)
                                    Spacer()
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
                                    Text(request.formattedRegistrationDate())
                                        .font(.subheadline)
                                    Spacer()
                                    HStack(spacing: 4) {
                                        if request.isStartDateTodayOrAfter() {
                                            NavigationLink(destination: ApplyDetailView(leaveRequest: request)) {
                                                Text("수정")
                                                    .font(.system(size: 14))
                                                    .padding(4)
                                                    .padding(.leading, 2)
                                                    .padding(.trailing, 2)
                                                    .background(Color(red: 4/255, green: 45/255, blue: 111/255))
                                                    .foregroundColor(.white)
                                                    
                                            }
                                            Button(action: {
                                                viewModel.showDeleteAlert = true
                                                viewModel.selectedRequestId = request.id
                                            }) {
                                                    Text("삭제")
                                                        .font(.system(size: 14))
                                                        .padding(4)
                                                        .padding(.leading, 2)
                                                        .padding(.trailing, 2)
                                                        .background(.white)
                                                        .foregroundColor(Color(red: 4/255, green: 45/255, blue: 111/255))
                                                        .overlay(
                                                            Rectangle()
                                                                .stroke(Color.black, lineWidth: 1)
                                                        )
                                                    
                                            }
                                            .alert(isPresented: $viewModel.showDeleteAlert) {
                                                Alert(
                                                    title: Text("삭제 확인"),
                                                    message: Text("정말로 삭제하시겠습니까?"),
                                                    primaryButton: .destructive(Text("삭제")) {
                                                        if let id = viewModel.selectedRequestId {
                                                            viewModel.deleteLeaveRequest(id: id)
                                                        }
                                                    },
                                                    secondaryButton: .cancel(Text("취소"))
                                                )
                                            }
                                        }else {
                                            // 동일한 공간 차지하도록 빈 뷰 추가
                                            Spacer().frame(width: 37)
                                            Spacer().frame(width: 37)
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
    @Published var showDeleteAlert = false
    @Published var selectedRequestId: Int? = nil
    
    func fetchLeaveRequests() {
        guard let url = URL(string: "http://218.39.3.116/apply") else { return }
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else {
            print("No token available")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([LeaveRequest].self, from: data)
                    DispatchQueue.main.async {
                        self.requests = decodedResponse
                    }
                } catch {
                    print("Error decoding response: \(error)")
                }
            } else if let error = error {
                print("HTTP request failed: \(error)")
            }
        }.resume()
    }
    func deleteLeaveRequest(id: Int) {
        guard let url = URL(string: "http://218.39.3.116/apply/\(id)") else { return }
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else {
            print("No token available")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    self.requests.removeAll { $0.id == id }
                }
            } else if let error = error {
                print("HTTP request failed: \(error)")
            }
        }.resume()
    }
}

struct ApplyView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyView()
    }
}

extension LeaveRequest {
    func isStartDateTodayOrAfter() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let startDate = dateFormatter.date(from: self.startDate) else { return false }
        let calendar = Calendar.current
        return calendar.isDateInToday(startDate) || startDate > Date()
    }
}

