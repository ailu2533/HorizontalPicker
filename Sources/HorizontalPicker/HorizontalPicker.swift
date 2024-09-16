// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct HorizontalSelectionPicker<ItemType: Hashable, Content: View, SelectedValue: Hashable>: View {
    private let items: [ItemType]
    @Binding private var selectedItem: SelectedValue
    private let itemToSelectedValue: (ItemType) -> SelectedValue
    private let backgroundColor: Color
    private let itemViewBuilder: (ItemType) -> Content
    @Namespace private var animation
    private let pickerId: UUID
    private let verticalPadding: CGFloat

    public init(pickerId: UUID, items: [ItemType], selectedItem: Binding<SelectedValue>, backgroundColor: Color = Color(.systemBackground),
                verticalPadding: CGFloat = 0,
                @ViewBuilder itemViewBuilder: @escaping (ItemType) -> Content) where SelectedValue == ItemType {
        self.items = items
        _selectedItem = selectedItem
        self.backgroundColor = backgroundColor
        self.itemViewBuilder = itemViewBuilder
        itemToSelectedValue = { $0 }
        self.pickerId = pickerId
        self.verticalPadding = verticalPadding
    }

    public init(pickerId: UUID, items: [ItemType], selectedItem: Binding<SelectedValue>, backgroundColor: Color = .clear,
                verticalPadding: CGFloat = 0,
                @ViewBuilder itemViewBuilder: @escaping (ItemType) -> Content, itemToSelectedValue: @escaping (ItemType) -> SelectedValue) {
        self.items = items
        _selectedItem = selectedItem
        self.backgroundColor = backgroundColor
        self.itemViewBuilder = itemViewBuilder
        self.itemToSelectedValue = itemToSelectedValue
        self.pickerId = pickerId
        self.verticalPadding = verticalPadding
    }

    public var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                itemsStackView(proxy: proxy)
            }
            .scrollIndicators(.hidden)
            .contentMargins(.horizontal, 16)
        }
        // .sensoryFeedback(.impact(weight: .light, intensity: 0.5), trigger: selectedItem)
    }

    private func itemsStackView(proxy: ScrollViewProxy) -> some View {
        HStack {
            ForEach(items, id: \.self) { item in
                itemButton(for: item, proxy: proxy)
                    .id(itemToSelectedValue(item))
            }
        }
        .padding(.vertical, 8)
        .onChange(of: selectedItem) { _, newValue in
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                proxy.scrollTo(newValue, anchor: .center)
            }
        }
    }

    private func itemButton(for item: ItemType, proxy: ScrollViewProxy) -> some View {
        Button(action: {
            selectedItem = itemToSelectedValue(item)
        }) {
            itemViewBuilder(item)
                .contentShape(Rectangle())
        }
        .buttonStyle(HorizontalPickerButtonStyle(
            pickerId: pickerId,
            isSelected: selectedItem == itemToSelectedValue(item),
            namespace: animation,
            itemId: itemToSelectedValue(item)
        ))
    }
}

struct WeekdaySelectionView: View {
    static let weekdays = [
        "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日",
    ]

    @State private var selectedWeekday = WeekdaySelectionView.weekdays.first!

    var body: some View {
        HorizontalSelectionPicker(pickerId: UUID(), items: WeekdaySelectionView.weekdays, selectedItem: $selectedWeekday, backgroundColor: .blue.opacity(0.4)) { weekday in
            Text(weekday)
        }
    }
}

// Preview
struct HorizontalPickerPreview: PreviewProvider {
    static var previews: some View {
        WeekdaySelectionView()
            .background(.blue)
    }
}
