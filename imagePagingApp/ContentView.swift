//
//  ContentView.swift
//  imagePagingApp
//
//  Created by Taehyung Lee on 2022/12/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
