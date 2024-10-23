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
public struct HorizontalPickerButtonStyle<ItemID: Hashable>: ButtonStyle {
    // MARK: Lifecycle

    public init(pickerID: UUID, isSelected: Bool = false, namespace: Namespace.ID, itemID: ItemID) {
        self.pickerID = pickerID
        self.isSelected = isSelected
        self.namespace = namespace
        self.itemID = itemID
    }

    // MARK: Public

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .fontWeight(.semibold)
            .font(.headline)
            .foregroundStyle(isSelected ? Color(.systemGray5) : Color.primary)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .frame(minWidth: 40)
            .background(backgroundView)
            .animation(.smooth, value: isSelected)
    }

    // MARK: Internal

    @Environment(\.isEnabled) var isEnabled

    var isSelected: Bool
//    var backgroundColor: Color
    var namespace: Namespace.ID
    var itemID: ItemID

    let pickerID: UUID

    @ViewBuilder
    var backgroundView: some View {
        if isSelected {
            Capsule()
                .fill(.primary)
                .matchedGeometryEffect(id: pickerID, in: namespace)
        } else {
            Capsule()
                .fill(Color(.clear))
        }
    }
}
