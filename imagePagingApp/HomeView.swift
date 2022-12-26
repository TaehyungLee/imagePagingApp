//
//  HomeView.swift
//  imagePagingApp
//
//  Created by Taehyung Lee on 2022/12/26.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm:HomeViewModel
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    var body: some View {
        ScrollView {
            HStack (alignment:.top, spacing: 15) {
                Circle().fill(Color.purple)
                    .frame(width: 60, height: 60)
                VStack(alignment:.leading, spacing: 10) {
                    Text("title..")
                        .font(.title)
                        .fontWeight(.bold)
                    +
                    Text("is noname")
                    let column = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
                    LazyVGrid(columns: column, alignment: .leading, spacing: 10) {
                        ForEach(vm.allImages.indices, id: \.self) { idx in
                            GridItemImageView(index: idx)
                        }
                    }
                    
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .overlay(
            // image viewer
            ZStack {
                if vm.showImageViewer {
                    Color("bg")
                        .opacity(vm.bgOpacity)
                        .ignoresSafeArea()
                    ImageView()
                }
            }
        )
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
