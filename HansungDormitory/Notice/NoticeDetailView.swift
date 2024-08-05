//
//  NoticeDetailView.swift
//  HansungDormitory
//
//  Created by JangSoohee on 8/5/24.
//

import Foundation
import SwiftUI

struct NoticeDetailView: View {
    let notice: Notice
    
    var body: some View {
        VStack {
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
            
            Divider()
            
            // Notice Details
            VStack(alignment: .leading) {
                            HStack {
                                Spacer()
                                Text(notice.title)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text("날짜: \(notice.date)")
                                    .font(.subheadline)
                                    .padding(.trailing ,20)
                            }
                            Text(notice.detail)
                                .padding(.top, 10)
                            Spacer()
                        }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("공지사항 상세", displayMode: .inline)
    }
}

struct NoticeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeDetailView(notice: Notice(title: "Sample Notice", department: "행정실", date: "2024-06-19", detail: "gweagawgeawgeqwageawegawegwagewagawegawegaweeeeeeeeeeeeeeeeeeeeeeeeeeeesrgaegoaw i. hmoewaighaw[eiogheawioghwaeogihg"))
    }
}
