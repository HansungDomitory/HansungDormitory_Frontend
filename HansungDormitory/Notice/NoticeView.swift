//
//  NoticeView.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/7/24.
//

import Foundation
import SwiftUI

struct NoticeView: View {
    @StateObject private var viewModel = NoticeViewModel()
    var body: some View {
        NavigationView {
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
                    Text("total: \(viewModel.notices.count)건")
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
                        ForEach(viewModel.notices, id: \.self) { notice in
                            NavigationLink(destination: NoticeDetailView(notice: notice)) {
                                VStack(alignment: .leading) {
                                    Text(notice.title)
                                        .font(.headline)
                                        .padding(.horizontal)
                                        .padding(.vertical, 5)
                                        .foregroundColor(.black)
                                    HStack {
                                        Text(notice.department)
                                            .font(.subheadline)
                                            .foregroundColor(.black)
                                        Spacer()
                                        Text(notice.formattedDate())
                                            .font(.subheadline)
                                            .foregroundColor(.black)
                                        
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
}

struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeView()
    }
}

