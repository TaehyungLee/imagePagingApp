//
//  HomeViewModel.swift
//  imagePagingApp
//
//  Created by Taehyung Lee on 2022/12/26.
//

import Foundation
import SwiftUI

class HomeViewModel:ObservableObject {
    @Published var allImages:[String] = []
    @Published var showImageViewer = false
    @Published var selectedImageID:String = ""
    @Published var imageViewerOffset:CGSize = .zero
    
    @Published var bgOpacity:Double = 1
    @Published var imageScale:CGFloat = 1
    init() {
        allImages = [
            "img1","img2","img3","img4","img5"
        ]
    }
    
    func onChaned(value:CGSize) {
        // updating offset
        imageViewerOffset = value
        
        // calc opacity
        let helgHeight = UIScreen.main.bounds.height / 2
        
        let progress = imageViewerOffset.height / helgHeight
        
        withAnimation(.default) {
            bgOpacity = Double(1 - (progress < 0 ? -progress:progress))
            
        }
        
    }
    
    func onEnd(value:DragGesture.Value) {
        withAnimation(.easeInOut) {
            var translation = value.translation.height
            
            if translation < 0 {
                translation = -translation
                
            }
            
            if translation < 250 {
                imageViewerOffset = .zero
                bgOpacity = 1
                
            }else {
                showImageViewer.toggle()
                imageViewerOffset = .zero
                bgOpacity = 1
            }
        }
    }
}
