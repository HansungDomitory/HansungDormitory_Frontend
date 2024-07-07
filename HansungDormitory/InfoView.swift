//
//  InfoView.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/7/24.
//

import Foundation
import SwiftUI

struct InfoView: View {
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
                Text("기숙사 소개")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.bottom, 30)
            // Selected Tab
            HStack {
                Text("상상빌리지")
                    .fontWeight(.bold)
                    .padding()
                    .frame(width: 250, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
            .padding(.bottom, 30)
            
            // Dormitory Info
            VStack(alignment: .leading, spacing: 10) {
                Text("한성대학교 행복(공공)기숙 상상빌리지 개요")
                    .font(.headline)
                    .padding(.top)
                Divider()
                InfoRow(label: "건물명", value: "한성대학교 공공기숙사[상상빌리지]")
                InfoRow(label: "시설 용도", value: "교육연구시설(기숙사)")
                InfoRow(label: "건물 규모", value: "B2~F7층 6,795.8㎡")
                InfoRow(label: "실수", value: "장애인실 : 2실\n일반실 : 162실")
                InfoRow(label: "수용인원", value: "총 326명 (남자: 132명, 여자: 192명)")
                InfoRow(label: "부대 시설", value: "체육시설, 휴게실, 세미나실, 세탁실, 편의점 등")
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(width: 100, alignment: .leading)
                Text(value)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true) // 멀티라인 텍스트를 위해
            }
            Divider()
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
