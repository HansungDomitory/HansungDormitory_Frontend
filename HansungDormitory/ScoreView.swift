//
//  ScoreView.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/30/24.
//

import Foundation
import SwiftUI

struct ScoreView: View {
    var studentID: String = "2071268"
    var studentName: String = "장수희"
    var meritPoints: Int = 13
    var demeritPoints: Int = 5
    var totalPoints: Int {
        return meritPoints - demeritPoints
    }
    var records: [(number: Int, reason: String, points: Int, date: String)] = [
        (4, "점호 우수 상점", 3, "2024-05-22"),
        (3, "폐문시간내 출입\n5월 19일 02:47", -5, "2024-05-20"),
        (2, "소방 훈련 참여", 5, "2024-04-12"),
        (1, "1학기 OT참석", 5, "2024-03-08")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            // Logo and title
            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 30)
                Spacer()
            }
            .padding(.top, 20)
            .padding(.horizontal)
            
            Text("상벌점 조회")
                .font(.system(size: 28, weight: .bold))
                .padding(.bottom, 20)
            
            // Student information
            HStack {
                Text("학번: \(studentID)")
                Spacer().frame(width: 20)
                Text("이름: \(studentName)")
            }
            .font(.system(size: 18))
            .padding(.horizontal)
            
            // Points summary
            HStack {
                Text("상점: \(meritPoints)").foregroundColor(.blue)
                Text("벌점: \(demeritPoints)").foregroundColor(.red)
                Text("총점: \(totalPoints)").foregroundColor(.blue)
            }
            .font(.system(size: 18))
            .padding(.horizontal)
            
            Divider()
            
            // Score records
            VStack(spacing: 0) {
                HStack {
                    Text("번호")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("사유")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("상벌점")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("적용일자")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.system(size: 18, weight: .bold))
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color(white: 0.9))
                .padding(.bottom, 20)
                
                ForEach(records, id: \.number) { record in
                    VStack {
                        HStack {
                            Text("\(record.number)")
                                .frame(width:40, alignment: .leading)
                                .padding(.leading, 15)
                            Text(record.reason)
                                .frame(width: 130, alignment: .leading)
                            Text("\(record.points > 0 ? "+" : "")\(record.points)")
                                .foregroundColor(record.points > 0 ? .blue : .red)
                                .frame(width: 40, alignment: .leading)
                                .padding(.trailing,10)
                            Text(record.date)
                                .frame(width: 100, alignment: .leading)
                        }
                        .padding(.horizontal)
                        Divider()
                            .padding(.bottom, 20)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.top, 20)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
