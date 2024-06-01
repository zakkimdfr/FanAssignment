//
//  CustomBackButton.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 01/06/24.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(.white)
        }
    }
}

#Preview {
    CustomBackButton()
}
