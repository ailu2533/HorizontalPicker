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

@available(iOS 17.0, *)
public struct HorizontalPickerButtonStyle: ButtonStyle {
    // MARK: Lifecycle

    public init(isSelected: Bool = false, backgroundColor: Color) {
        self.isSelected = isSelected
        self.backgroundColor = backgroundColor
    }

    // MARK: Public

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .fontWeight(.semibold)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .frame(minWidth: 40)
            .background(backgroundView)
    }

    // MARK: Internal

    var isSelected: Bool
    var backgroundColor: Color

    @ViewBuilder
    var backgroundView: some View {
        RoundedRectangle(cornerRadius: 12).fill(backgroundColor)
            .opacity(isSelected ? 1 : 0)
    }
}
