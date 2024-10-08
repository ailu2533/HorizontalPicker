//
//  File.swift
//
//
//  Created by ailu on 2024/7/12.
//

import Foundation
import UIKit

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading: Bool = false // 添加一个标记图像是否正在加载的状态
    static let sharedCache = NSCache<NSString, UIImage>() // 全局静态缓存

    func loadAndResizeImage(named imageName: String, targetSize: CGSize) {
        isLoading = true // 标记开始加载
        let cacheKey = NSString(string: "\(imageName)_\(targetSize.width)x\(targetSize.height)")

        // 尝试从全局缓存中获取图像
        if let cachedImage = ImageLoader.sharedCache.object(forKey: cacheKey) {
            DispatchQueue.main.async {
                self.image = cachedImage
                self.isLoading = false // 标记加载完成
            }
            return
        }

        // 如果缓存中没有图像，进行加载和调整大小
        DispatchQueue.global(qos: .userInitiated).async {
            guard let image = UIImage(named: imageName) else {
                DispatchQueue.main.async {
                    self.image = UIImage() // 使用空图片作为默认值
                    self.isLoading = false // 标记加载完成
                }
                return
            }
            let format = UIGraphicsImageRendererFormat()
            format.scale = UIScreen.main.scale // 使用设备的屏幕比例
            let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
            let newImage = renderer.image { _ in
                image.draw(in: CGRect(origin: .zero, size: targetSize))
            }
            DispatchQueue.main.async {
                self.image = newImage
                ImageLoader.sharedCache.setObject(newImage, forKey: cacheKey) // 将新图像存入全局缓存
                self.isLoading = false // 标记加载完成
            }
        }
    }
}
