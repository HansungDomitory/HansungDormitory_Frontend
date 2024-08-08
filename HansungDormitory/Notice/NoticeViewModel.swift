//
//  NoticeViewModel.swift
//  HansungDormitory
//
//  Created by JangSoohee on 8/5/24.
//

import Foundation
import Combine

class NoticeViewModel: ObservableObject {
    @Published var notices: [Notice] = []
    @Published var searchText: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchNotices()
    }
    
    var filteredNotices: [Notice] {
            if searchText.isEmpty {
                return notices
            } else {
                return notices.filter { $0.title.contains(searchText) }
            }
        }
    
    func fetchNotices() {
        guard let url = URL(string: "http://3.145.59.24:3000/notice") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Notice].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.notices = $0 }
            .store(in: &cancellables)
    }
}

