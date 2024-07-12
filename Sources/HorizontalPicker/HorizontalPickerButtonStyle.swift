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

    public init(isSelected: Bool = false, backgroundColor: Color = Color.orange) {
        self.isSelected = isSelected
        self.backgroundColor = backgroundColor
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .fontWeight(.semibold)
            .font(.subheadline)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .frame(minWidth: 30)
            .background(isSelected ? backgroundColor : Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
