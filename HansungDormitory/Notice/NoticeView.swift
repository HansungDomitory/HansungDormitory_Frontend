//
//  NoticeView.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/7/24.
//

import Foundation
import SwiftUI

struct NoticeView: View {
    let notices = [
        Notice(title: "[상상빌리지] 하계 방중 행정실 근무시간...", department: "행정실", date: "2024-06-19", detail:""),
        Notice(title: "[상상빌리지] 동계 방중 행정실 근무시간...", department: "행정실", date: "2024-06-19", detail:""),
        Notice(title: "[상상빌리지] 하계 방중 행정실 근무시간...", department: "행정실", date: "2024-06-19", detail:""),
        Notice(title: "Sample Notice", department: "행정실", date: "2024-06-19", detail: "gweagawgeawgeqwageawegawegwagewagawegawegaweeeeeeeeeeeeeeeeeeeeeeeeeeeesrgaegoaw i. hmoewaighaw[eiogheawioghwaeogihg")
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
                Text("공지사항")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
            // Notice Count and Search Bar
            HStack {
                Text("total: \(notices.count)건")
                    .padding(.leading)
                Spacer()
                TextField("검색", text: .constant(""))
                    .padding(8)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .padding(.trailing, 5)
                Button(action: {
                    // 검색 버튼 액션
                }) {
                    Text("검색")
                        .foregroundColor(.white)
                        .padding(.horizontal, 7)
                        .padding(.vertical, 6)
                        .background(Color.gray)
                        .cornerRadius(3)
                }
                .padding(.trailing, 5)
            }
            .padding(.vertical, 5)
            .padding(.bottom, 20)
            
            Divider()
            
            // Notice List
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(notices, id: \.self) { notice in
                        NavigationLink(destination: NoticeDetailView(notice: notice)) {
                            VStack(alignment: .leading) {
                                Text(notice.title)
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                HStack {
                                    Text(notice.department)
                                        .font(.subheadline)
                                    
                                    Spacer()
                                    Text(notice.date)
                                        .font(.subheadline)
                                    
                                }
                                .padding(.horizontal)
                                Divider()
                            }
                        }
                    }
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

struct Notice: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let department: String
    let date: String
    let detail:String
}

struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeView()
    }
}

