//
//  File.swift
//
//
//  Created by ailu on 2024/7/12.
//

import Foundation
import SwiftUI

struct HorizontalPickerButtonStyle2: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    var isSelected = false
    var backgroundColor: Color = Color.clear

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 30)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(isSelected ? Color.white : backgroundColor)
            .foregroundColor(isSelected ? .black : .gray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.orange : Color.clear, lineWidth: 2)
                    .shadow(color: isSelected ? Color.orange.opacity(0.5) : Color.clear, radius: 4, x: 0, y: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}
