//
//  ImageDetailView.swift
//  imagePagingApp
//
//  Created by kbsys on 2023/02/21.
//

import SwiftUI

struct ImageDetailView: View {
    
    let maxAllowedScale = 4.0
    @State var scale: CGFloat = 1.0
    
    var doubleTapGesture: some Gesture {
        TapGesture(count: 2).onEnded {
            if scale < maxAllowedScale / 2 {
                scale = maxAllowedScale
            } else {
                scale = 1.0
            }
        }
    }
    
    @Environment(\.presentationMode) var present
    
    let image:String
    
    var body: some View {
        ZStack {
            ZoomableScrollView(maxAllowedScale: maxAllowedScale,
                               scale: $scale) {
                Image(image)
                    .resizable()
                    .scaledToFit()
            }
            VStack {
                HStack(spacing:0) {
                    Spacer()
                    // close btn
                    Button(action: {
                        present.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding()
                            .clipShape(Circle())
                            .gesture(doubleTapGesture)
                            .background(
                                Color.black.clipShape(Circle())
                            )
                    })
                    .padding(10)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    
                }
                
                Spacer()
                
            }
            
        }
        .ignoresSafeArea()
        
    }
    
        
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(image: "img3")
    }
}
