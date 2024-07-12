//
//  File.swift
//
//
//  Created by ailu on 2024/7/12.
//

import Foundation
import SwiftUI

struct FeedbackViewModifier<Trigger: Equatable>: ViewModifier {
    var feedback: SensoryFeedback?
    var trigger: Trigger

    func body(content: Content) -> some View {
        if let feedback {
            content.sensoryFeedback(feedback, trigger: trigger)
        } else {
            content
        }
    }
}
