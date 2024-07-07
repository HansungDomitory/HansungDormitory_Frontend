// ContentView.swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            Text("Note View")
                .tabItem {
                    Image(systemName: "pencil.tip.crop.circle")
                        .font(.system(size: 24, weight: .bold))
                    Text("Note")
                }
            
            Text("Check View")
                .tabItem {
                    Image(systemName: "checkmark.square")
                    Text("Check")
                }
            
            Text("Profile View")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
