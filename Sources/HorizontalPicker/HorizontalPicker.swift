// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct HorizontalSelectionPicker<ItemType: Hashable, Content: View, SelectedValue: Hashable>: View {
    private let items: [ItemType]
    @Binding private var selectedItem: SelectedValue
    private let itemToSelectedValue: (ItemType) -> SelectedValue
    private let backgroundColor: Color
    private let itemViewBuilder: (ItemType) -> Content
    private let feedback: SensoryFeedback?

    public init(items: [ItemType], selectedItem: Binding<SelectedValue>, backgroundColor: Color = .clear, feedback: SensoryFeedback? = nil,
                @ViewBuilder itemViewBuilder: @escaping (ItemType) -> Content) where SelectedValue == ItemType {
        self.items = items
        _selectedItem = selectedItem
        self.backgroundColor = backgroundColor
        self.itemViewBuilder = itemViewBuilder
        self.feedback = feedback
        itemToSelectedValue = { $0 }
    }

    public init(items: [ItemType], selectedItem: Binding<SelectedValue>, backgroundColor: Color = .clear, feedback: SensoryFeedback? = nil,
                @ViewBuilder itemViewBuilder: @escaping (ItemType) -> Content, itemToSelectedValue: @escaping (ItemType) -> SelectedValue) {
        self.items = items
        _selectedItem = selectedItem
        self.backgroundColor = backgroundColor
        self.itemViewBuilder = itemViewBuilder
        self.feedback = feedback
        self.itemToSelectedValue = itemToSelectedValue
    }

    public var body: some View {
        ScrollView(.horizontal) {
            itemsStackView()
        }
        .scrollIndicators(.hidden)
        .contentMargins(.horizontal, 16)
    }

    private func itemsStackView() -> some View {
        HStack {
            ForEach(items, id: \.self) { item in
                itemButton(for: item)
            }
        }
    }

    private func itemButton(for item: ItemType) -> some View {
        Button(action: { selectedItem = itemToSelectedValue(item) }) {
            itemViewBuilder(item)
                .frame(minWidth: 30)
                .contentShape(Rectangle())
        }
        .buttonStyle(HorizontalPickerButtonStyle(isSelected: selectedItem == itemToSelectedValue(item)))
        .modifier(FeedbackViewModifier(feedback: feedback, trigger: selectedItem))
        .animation(.default, value: selectedItem)
    }
}

struct WeekdaySelectionView: View {
    static let weekdays = [
        "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日",
    ]

    @State private var selectedWeekday = WeekdaySelectionView.weekdays.first!

    var body: some View {
        HorizontalSelectionPicker(items: WeekdaySelectionView.weekdays, selectedItem: $selectedWeekday, backgroundColor: .clear) { weekday in
            Text(weekday)
        } itemToSelectedValue: { $0 }
    }
}

// Preview
struct HorizontalPickerPreview: PreviewProvider {
    static var previews: some View {
        WeekdaySelectionView()
    }
}
