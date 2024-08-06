// ContentView.swift
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Group {
            if appState.isLoggedIn {
                MainTabView()
            } else {
                Login()
            }
        }
    }
}
struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("홈화면")
                }
            
            ApplyView()
                .tabItem {
                    Image(systemName: "pencil.tip.crop.circle")
                        .font(.system(size: 24, weight: .bold))
                    Text("외박신청")
                }
            
            NoticeView()
                .tabItem {
                    Image(systemName: "checkmark.square")
                    Text("공지사항")
                }
            
            MyPageView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("마이페이지")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppState())
    }
}
