//
//  AppState.swift
//  HansungDormitory
//
//  Created by JangSoohee on 8/6/24.
//

import Foundation
import Combine

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
}
