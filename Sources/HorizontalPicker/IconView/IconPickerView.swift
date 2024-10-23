//
//  File.swift
//
//
//  Created by ailu on 2024/7/12.
//

import Collections
import Foundation
import SwiftUI

public struct IconPickerView: View {
    // MARK: Lifecycle

    public init(selectedIcon: Binding<String>, iconSets: OrderedDictionary<String, [String]>) {
        self.iconSets = iconSets
        _selectedIcon = selectedIcon
    }

    // MARK: Public

    public var body: some View {
        VStack {
            HorizontalSelectionPicker(pickerID: UUID(), items: iconSets.keys.elements, selectedItem: $selectedIconSetName) {
                Text($0)
            } itemToSelectedValue: { $0 }
                .padding(.horizontal)
                .padding(.top, 40)

            SingleIconSetIconPickerView(selectedImg: $selectedIcon, icons: iconSets[selectedIconSetName] ?? [])
                .padding(.horizontal)
        }
        .onAppear {
            selectedIconSetName = selectedIconSetName.isEmpty ? iconSets.keys.first ?? "" : selectedIconSetName
        }
        .navigationTitle("选择图标")
    }

    // MARK: Internal

    @Binding var selectedIcon: String
    let iconSets: OrderedDictionary<String, [String]>

    // MARK: Private

    @Environment(\.dismiss) private var dismiss
    @State private var selectedIconSetName: String = ""
}
