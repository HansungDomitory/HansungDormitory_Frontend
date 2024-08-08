//
//  HomeView.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/3/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = NoticeViewModel()
    
    var body: some View {

        NavigationView {
            ScrollView(){
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
                    
                    
                    // Main Image
                    Image("dormitoryImage")
                        .resizable()
                        .scaledToFit()
                    
                    // Dormitory Info
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("기숙사 소개")
                                .font(.headline)
                                .padding(.leading)
                            Spacer()
                            NavigationLink(destination: InfoView()) {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                                    .padding(.trailing)
                            }
                        }
                        .padding(.vertical, 5)
                        Divider()
                        Text("한성대학교 상상빌리지는 쾌적하고 안전한 환경을 제공합니다. 최신 시설과 편리한 생활 공간을 갖춘 기숙사는 학생들의 학습과 생활을 지원합니다. 다양한 편의 시설과 함께 활기찬 커뮤니티를 경험해 보세요.")
                            .font(.system(size: 15))
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                    }
                    .background(Color(UIColor.systemGray6))
                    .padding()
                    
                    // Notices
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("공지사항")
                                .font(.headline)
                                .padding(.leading)
                            Spacer()
                            NavigationLink(destination: NoticeView()) {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                                    .padding(.trailing)
                            }
                        }
                        .padding(.vertical, 5)
                        Divider()
                        ForEach(viewModel.notices.prefix(3), id: \.self) { notice in
                            Text(notice.title)
                                .padding(.horizontal)
                                .padding(.vertical, 3)
                                .font(.system(size: 15))
                            Divider()
                        }
                    }
                    .background(Color(UIColor.systemGray6))
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding()
                .navigationBarHidden(true)
            }
            .onAppear {
                viewModel.fetchNotices()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
