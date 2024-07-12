//
//  File.swift
//
//
//  Created by ailu on 2024/7/12.
//

import Foundation

//
//  SwiftUIView.swift
//
//
//  Created by ailu on 2024/6/7.
//

import SwiftUI

public struct IconView: View {
    private let iconName: String
    private let width: CGFloat
    private let height: CGFloat

    public init(iconName: String, width: CGFloat = 60, height: CGFloat = 60) {
        self.iconName = iconName
        self.width = width
        self.height = height
    }

    public var body: some View {
        ResizedImage(imageName: iconName, targetSize: .init(width: width, height: height))
            .frame(width: width, height: height)
            .id(iconName)
    }
}
