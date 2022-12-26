//
//  GridItemImageView.swift
//  imagePagingApp
//
//  Created by Taehyung Lee on 2022/12/26.
//

import SwiftUI

struct GridItemImageView: View {
    @EnvironmentObject var vm:HomeViewModel
    var index:Int
    var body: some View {
        Button {
            vm.selectedImageID = vm.allImages[index]
            vm.showImageViewer.toggle()
            
        } label: {
            ZStack {
                
                if index <= 3 {
                    Image(vm.allImages[index])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getWidth(index: index), height: 120, alignment: .center)
                        .cornerRadius(12)
                }
                
                if vm.allImages.count > 4, index == 3 {
                    RoundedRectangle(cornerRadius: 12).fill(Color.black.opacity(0.3))
                    
                    let remainingImage = vm.allImages.count - 4
                    Text("+\(remainingImage)")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
                
            }
        }

        
    }
    
    func getWidth(index: Int) -> CGFloat {
        let width = getRect().width - 100
        if vm.allImages.count % 2 == 0 {
            return width / 2
        }else{
            if index == vm.allImages.count - 1 {
                return width
            }else{
                return width / 2
            }
        }
    }
}

struct GridItemImageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
