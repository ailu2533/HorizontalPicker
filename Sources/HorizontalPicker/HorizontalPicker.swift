// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct HorizontalSelectionPicker<ItemType: Hashable, Content: View, SelectedValue: Hashable>: View {
    var items: [ItemType]
    @Binding private var selectedItem: SelectedValue

    // 添加一个转换函数，将 ItemType 转换为 SelectedValue
    var itemToSelectedValue: (ItemType) -> SelectedValue

    var backgroundColor: Color

    @ViewBuilder var itemViewBuilder: (ItemType) -> Content

    private var shouldEmbedInScrollView = true

    var feedback: SensoryFeedback?

    // 初始化方法，当 SelectedValue 和 ItemType 相同时
    public init(items: [ItemType], selectedItem: Binding<SelectedValue>, backgroundColor: Color = Color(.clear), shouldEmbedInScrollView: Bool = true, feedback: SensoryFeedback? = nil,
                itemViewBuilder: @escaping (ItemType) -> Content) where SelectedValue == ItemType {
        self.items = items
        _selectedItem = selectedItem
        self.backgroundColor = backgroundColor
        self.itemViewBuilder = itemViewBuilder
        self.shouldEmbedInScrollView = shouldEmbedInScrollView
        self.feedback = feedback
        itemToSelectedValue = { $0 }
    }

    public init(items: [ItemType], selectedItem: Binding<SelectedValue>, backgroundColor: Color = Color(.clear), shouldEmbedInScrollView: Bool = true, feedback: SensoryFeedback? = nil,
                itemViewBuilder: @escaping (ItemType) -> Content, itemToSelectedValue: @escaping (ItemType) -> SelectedValue) {
        self.items = items
        _selectedItem = selectedItem
        self.backgroundColor = backgroundColor
        self.itemViewBuilder = itemViewBuilder
        self.shouldEmbedInScrollView = shouldEmbedInScrollView
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
            ForEach(items, id: \.self) { dataItem in
                Button(action: {
                    // 使用转换函数来更新 selectedItem
                    selectedItem = itemToSelectedValue(dataItem)
                }, label: {
                    itemViewBuilder(dataItem)
                        .frame(minWidth: 30)
                        .contentShape(Rectangle())
                })
                .buttonStyle(HorizontalPickerButtonStyle(isSelected: selectedItem == itemToSelectedValue(dataItem)))
                .modifier(FeedbackViewModifier(feedback: feedback, trigger: selectedItem))
                .animation(.default, value: selectedItem)
            }
        }
    }
}

struct WeekdaySelectionView: View {
    static let weekdays = [
        "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日",
    ]

    @State private var selectedWeekday = WeekdaySelectionView.weekdays.first!

    var body: some View {
        HorizontalSelectionPicker(items: WeekdaySelectionView.weekdays, selectedItem: $selectedWeekday, backgroundColor: .gray.opacity(0.1)) { weekday in
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
