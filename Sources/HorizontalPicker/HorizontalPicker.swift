// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

// MARK: - HorizontalSelectionPicker

public struct HorizontalSelectionPicker<ItemType: Hashable & Identifiable, Content: View>: View {
    // MARK: Lifecycle

    public init(
        items: [ItemType],
        selectedItem: Binding<ItemType>,
        backgroundColor: Color = Color(.systemGray5),
        verticalPadding: CGFloat = 0,
        @ViewBuilder itemViewBuilder: @escaping (ItemType) -> Content
    ) {
        self.items = items
        _selectedItem = selectedItem
        self.itemViewBuilder = itemViewBuilder
    }

    // MARK: Public

    public var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                itemsStackView(proxy: proxy)
            }
            .scrollIndicators(.hidden)
            .contentMargins(.horizontal, 16)
        }
    }

    // MARK: Internal

    @ViewBuilder var itemViewBuilder: (ItemType) -> Content

    // MARK: Private

    private let items: [ItemType]
    @Binding private var selectedItem: ItemType

    private func itemsStackView(proxy: ScrollViewProxy) -> some View {
        HStack {
            ForEach(items) { item in
                itemButton(for: item)
                    .id(item)
            }
        }
        .onChange(of: selectedItem) { _, newValue in
            withAnimation(.spring) {
                proxy.scrollTo(newValue, anchor: .center)
            }
        }
    }

    private func itemButton(for item: ItemType) -> some View {
        Button {
            selectedItem = item
        } label: {
            itemViewBuilder(item)
               
                .foregroundStyle(selectedItem == item ? .primary : .secondary)
        }
        .buttonStyle(HorizontalPickerButtonStyle())
    }
}

// MARK: - Weekday

struct Weekday: Identifiable, Hashable {
    // MARK: Lifecycle

    init(_ text: String) {
        self.text = text
    }

    // MARK: Internal

    let text: String
    let id = UUID()
}

// MARK: - WeekdaySelectionView

struct WeekdaySelectionView: View {
    // MARK: Internal

    static let weekdays = [
        Weekday("星期一"), Weekday("星期二"), Weekday("星期三"), Weekday("星期四"), Weekday("星期五"), Weekday("星期六"), Weekday("星期日"),
    ]

    var body: some View {
        HorizontalSelectionPicker(items: WeekdaySelectionView.weekdays, selectedItem: $selectedWeekday, backgroundColor: .blue.opacity(0.4)) { weekday in
            Text(weekday.text)
        }
    }

    // MARK: Private

    @State private var selectedWeekday = WeekdaySelectionView.weekdays.first!
}

// MARK: - HorizontalPickerPreview

// Preview
struct HorizontalPickerPreview: PreviewProvider {
    static var previews: some View {
        WeekdaySelectionView()
            .background(.blue)
    }
}
