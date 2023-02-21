//
//  ImageView.swift
//  imagePagingApp
//
//  Created by Taehyung Lee on 2022/12/26.
//

import SwiftUI

struct ImageView: View {
    @EnvironmentObject var vm:HomeViewModel
    @GestureState var draggingOffset:CGSize = .zero
    
    @State var showDetail = false
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(vm.bgOpacity)
                .ignoresSafeArea()
            
            // tabview bug
            ScrollView(.init()) {
                TabView(selection: $vm.selectedImageID) {
                    ForEach(vm.allImages, id: \.self) { image in
                        ZStack {
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .tag(image)
                                .scaleEffect(
                                    vm.selectedImageID == image ? (vm.imageScale > 1 ? vm.imageScale:1) : 1
                                )
                                .offset(y:vm.imageViewerOffset.height)
                                .gesture(
                                    // magnification
                                    MagnificationGesture().onChanged({ value in
                                        vm.imageScale = value
                                    }).onEnded({ _ in
    //                                    withAnimation(.spring()) {
    //                                        vm.imageScale = 1
    //                                    }
                                    })
                                    // Double to zoom
                                        .simultaneously(with: TapGesture(count: 2).onEnded({ _ in
                                            withAnimation {
                                                vm.imageScale = vm.imageScale > 1 ? 1 : 4
                                            }
                                        }))
                                )
                            
                            VStack {
                                Spacer()
                                HStack{
                                    Spacer()
                                    Button {
                                        showDetail.toggle()
                                    } label: {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke()
                                                .foregroundColor(.pink)
                                                .frame(width: 100, height: 40)
                                            
                                            Image(systemName: "plus.magnifyingglass")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(.pink)
                                                .frame(width: 30, height: 30)
                                        }
                                        
                                    }
                                    .padding(.bottom, 100)
                                }
                                .padding(.trailing, 10)
                            }
                            .sheet(isPresented: $showDetail) {
                                ImageDetailView(image: image)
                            }
                        }
                        
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .overlay (
                    // close btn
                    Button(action: {
                        withAnimation(.default) {
                            vm.showImageViewer.toggle()
                        }
                    }, label: {
                        
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.35))
                            .clipShape(Circle())
                            
                    })
                    .padding(10)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .opacity(vm.bgOpacity)
                    , alignment: .topTrailing
                )
            }
            .ignoresSafeArea()
        }
        .gesture(DragGesture().updating($draggingOffset, body: { value, outValue, _ in
            outValue = value.translation
            vm.onChaned(value: draggingOffset)
        })
            .onEnded(vm.onEnd))
        
        .transition(.move(edge: .bottom))
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
