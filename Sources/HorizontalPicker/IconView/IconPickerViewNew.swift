//
//  IconPicker.swift
//  MyHabit
//
//  Created by ailu on 2024/3/25.
//

import Collections
import SwiftUI

// public struct IconPickerViewNew: View {
//    // MARK: Lifecycle
//
//    public init(selectedIcon: Binding<String>, iconSets: OrderedDictionary<String, [String]>) {
//        self.iconSets = iconSets
//        _selectedIcon = selectedIcon
//    }
//
//    // MARK: Public
//
//    public var body: some View {
//        VStack {
//            HorizontalSelectionPicker(pickerID: UUID(), items: iconSets.keys.elements, selectedItem: $selectedIconSetName) {
//                Text($0)
//            } itemToSelectedValue: {
//                $0
//            }
//            .padding(.horizontal)
//
//            SingleIconSetIconPickerView(selectedImg: _selectedIcon, icons: iconSets[selectedIconSetName] ?? [])
//                .padding(.horizontal)
//        }
//        .onAppear {
//            selectedIconSetName = selectedIconSetName.isEmpty ? iconSets.keys.first ?? "" : selectedIconSetName
//            selectedIcon = selectedIcon.isEmpty ? iconSets[selectedIconSetName]?.first ?? "" : selectedIcon
//        }
//        .toolbar {
//            ToolbarItem {
//                Button(action: {
//                    dismiss()
//                }, label: {
//                    Label("关闭", systemImage: "xmark.circle")
//                })
//            }
//        }
//    }
//
//    // MARK: Internal
//
//    @Binding var selectedIcon: String
//    let iconSets: OrderedDictionary<String, [String]>
//
//    // MARK: Private
//
//    @Environment(\.dismiss) private var dismiss
//    @State private var selectedIconSetName: String = ""
// }
