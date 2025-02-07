//
//  File.swift
//
//
//  Created by ailu on 2024/7/12.
//

import Foundation
import SwiftUI

public struct ComparableHorizontalSelectionPicker<ItemType: Hashable, Content: View>: View {
    // MARK: Lifecycle

    public init(
        items: [ItemType],
        selectedItem: Binding<ItemType>,
        backgroundColor: Color = Color(.clear),
        isEmbeddedInScrollView: Bool = true,
        itemViewBuilder: @escaping (ItemType) -> Content
    ) {
        self.items = items
        _selectedItem = selectedItem
        self.backgroundColor = backgroundColor
        self.itemViewBuilder = itemViewBuilder
        self.isEmbeddedInScrollView = isEmbeddedInScrollView
    }

    // MARK: Public

    public var body: some View {
        ScrollView(.horizontal) {
            itemsStackView()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .contentMargins(.vertical, 2)
    }

    // MARK: Internal

    var items: [ItemType]
    var backgroundColor: Color

    @ViewBuilder var itemViewBuilder: (ItemType) -> Content

    // MARK: Private

    @Binding private var selectedItem: ItemType

    private var isEmbeddedInScrollView = true

    private func itemsStackView() -> some View {
        HStack(spacing: 0) {
            ForEach(items, id: \.self) { dataItem in
                Button(action: {
                    selectedItem = dataItem
                }, label: {
                    itemViewBuilder(dataItem)
                        .contentShape(Circle())
                })
                .containerRelativeFrame(.horizontal, count: 6, spacing: 0)
                .scrollTargetLayout()
                .buttonStyle(HorizontalPickerButtonStyle2(isSelected: selectedItem == dataItem, backgroundColor: backgroundColor))
            }
        }.scrollTargetLayout()
    }
}
