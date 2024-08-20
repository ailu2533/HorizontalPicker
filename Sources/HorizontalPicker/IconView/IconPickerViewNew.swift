//
//  IconPicker.swift
//  MyHabit
//
//  Created by ailu on 2024/3/25.
//

import Collections
import SwiftUI


public struct IconPickerViewNew: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedIcon: String
    @State private var selectedIconSetName: String = ""

    let iconSets: OrderedDictionary<String, [String]>

    public init(selectedIcon: Binding<String>, iconSets: OrderedDictionary<String, [String]>) {
        self.iconSets = iconSets
        _selectedIcon = selectedIcon
    }

    public var body: some View {
        VStack {
            HorizontalSelectionPicker(pickerId: UUID(), items: iconSets.keys.elements, selectedItem: $selectedIconSetName) {
                Text($0)
            } itemToSelectedValue: {
                $0
            }
            .padding(.horizontal)

            SingleIconSetIconPickerView(selectedImg: _selectedIcon, icons: iconSets[selectedIconSetName] ?? [])
                .padding(.horizontal)
        }
        .onAppear {
            selectedIconSetName = selectedIconSetName.isEmpty ? iconSets.keys.first ?? "" : selectedIconSetName
            selectedIcon = selectedIcon.isEmpty ? iconSets[selectedIconSetName]?.first ?? "" : selectedIcon
        }
        .toolbar {
            ToolbarItem {
                Button(action: {
                    dismiss()
                }, label: {
                    Label("关闭", systemImage: "xmark.circle")
                })
            }
        }
    }
}
