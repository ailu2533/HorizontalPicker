//
//  SwiftUIView.swift
//  
//
//  Created by ailu on 2024/7/12.
//

import SwiftUI

struct ResizedImage: View {
    @StateObject var imageLoader = ImageLoader()
    let imageName: String
    let targetSize: CGSize

    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.5), value: imageLoader.image)
            } else if imageLoader.isLoading {
                ProgressView()  // 显示加载进度指示器
                    .aspectRatio(contentMode: .fit)
            } else {
                Rectangle()
                    .fill(Color.clear)// 提供一个占位符
            }
        }
        .onAppear {
            imageLoader.loadAndResizeImage(named: imageName, targetSize: targetSize)
        }
    }
}
