//
//  HomeView.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/3/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
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
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                }
                .background(Color(UIColor.systemGray6))
                .padding()
                
                // Notices
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("공지사항")
                            .font(.headline)
                            .padding(.leading)
                        Spacer()
                        Image(systemName: "plus")
                            .padding(.trailing)
                    }
                    .padding(.vertical, 5)
                    Divider()
                    ForEach(0..<3) { _ in
                        Text("[상상빌리지] 하계 방중 행정실 근무시간...")
                            .padding(.horizontal)
                            .padding(.vertical, 3)
                        Divider()
                    }
                }
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
