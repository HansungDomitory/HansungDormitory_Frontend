//
//  ScoreView.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/30/24.
//

import Foundation
import SwiftUI

struct ScoreView: View {
    @State private var studentID: String = ""
    @State private var studentName: String = ""
    @State private var meritPoints: Int = 0
    @State private var demeritPoints: Int = 0
    @State private var records: [(number: Int, reason: String, points: Int, date: String)] = []
    
    var totalPoints: Int {
        return meritPoints - demeritPoints
    }
    
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
                ScrollView {
                ForEach(Array(records.enumerated()), id: \.offset) { index, record in
                    VStack {
                        HStack {
                            Text("\(records.count - index)")
                                .frame(width:40, alignment: .leading)
                                .padding(.leading, 15)
                            Text(record.reason)
                                .frame(width: 120, alignment: .leading)
                            Text("\(record.points > 0 ? "+" : "")\(record.points)")
                                .foregroundColor(record.points > 0 ? .blue : .red)
                                .frame(width: 40, alignment: .leading)
                                .padding(.trailing,20)
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
        .onAppear {
            fetchScores()
        }
        }
    }
    func fetchScores() {
        guard let url = URL(string: "http://3.145.59.24:3000/score/student") else { return }
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
                    let decodedResponse = try JSONDecoder().decode([ScoreRecord].self, from: data)
                    DispatchQueue.main.async {
                        if let firstRecord = decodedResponse.first?.student {
                            self.studentID = firstRecord.id
                            self.studentName = firstRecord.name
                            self.meritPoints = firstRecord.meritScore
                            self.demeritPoints = firstRecord.demeritScore
                        }
                        self.records = decodedResponse.enumerated().map { (index, record) in
                            let points = record.isMerit ? record.meritScore : -record.demeritScore
                            return (number: index + 1, reason: record.detail, points: points, date: record.formattedCreateAt())
                        }
                    }
                } catch {
                    print("Error decoding response: \(error)")
                }
            } else if let error = error {
                print("HTTP request failed: \(error)")
            }
        }.resume()
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
