//
//  File.swift
//
//
//  Created by ailu on 2024/7/12.
//

import Foundation
import SwiftUI

@available(iOS 17.0, *)
public struct HorizontalPickerButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    var isSelected: Bool
    var backgroundColor: Color

    public init(isSelected: Bool = false, backgroundColor: Color = Color.clear) {
        self.isSelected = isSelected
        self.backgroundColor = backgroundColor
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundStyle(.secondary)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(backgroundView(configuration: configuration))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? Color.orange : Color.clear, lineWidth: isSelected ? 1 : 0)
                    .shadow(color: isSelected ? Color.orange.opacity(0.5) : Color.clear, radius: 3, x: 2, y: 0)
                    .blur(radius: isSelected ? 0.2 : 0)
            )
            .blur(radius: configuration.isPressed ? 3 : 0)
            .animation(.easeInOut, value: configuration.isPressed)
            .saturation(isEnabled ? 1 : 0.5)
    }

    @ViewBuilder
    private func backgroundView(configuration: Self.Configuration) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color(.systemGray6))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(.systemGray3), lineWidth: isSelected ? 2 : 0)
            )
    }
}
