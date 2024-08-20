//
//  File.swift
//
//
//  Created by ailu on 2024/7/12.
//

import Foundation
import SwiftUI

@available(iOS 17.0, *)
public struct HorizontalPickerButtonStyle<ItemId: Hashable>: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    var isSelected: Bool
    var backgroundColor: Color
    var namespace: Namespace.ID
    var itemId: ItemId

    let pickerId: UUID

    public init(pickerId: UUID, isSelected: Bool = false, backgroundColor: Color = Color.orange, namespace: Namespace.ID, itemId: ItemId) {
        self.pickerId = pickerId
        self.isSelected = isSelected
        self.backgroundColor = backgroundColor
        self.namespace = namespace
        self.itemId = itemId
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .fontWeight(.semibold)
            .font(.subheadline)
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .frame(minWidth: 30)
            .background(
                ZStack {
                    if isSelected {
                        Capsule()
                            .fill(Color(.black))
                            .matchedGeometryEffect(id: pickerId, in: namespace)
                    } else {
                        Capsule()
                            .fill(Color(.systemGray6))
                    }
                }
            )
            .foregroundColor(isSelected ? .white : .primary)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}
