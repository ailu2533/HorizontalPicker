//
//  File.swift
//
//
//  Created by ailu on 2024/7/12.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    @Entry var horizontalPickerForegroundColor: Color = Color(.systemGray5)
    @Entry var selectedHorizontalPickerForegroundColor: Color = Color(.systemGray5)
}

// MARK: - HorizontalPickerButtonStyle

@available(iOS 17.0, *)
public struct HorizontalPickerButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .modifier(PickerButtonModifier())
    }
}

// MARK: - PickerButtonModifier

private struct PickerButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .frame(minWidth: 44)
            .contentShape(Rectangle())
            .fontWeight(.semibold)
    }
}
