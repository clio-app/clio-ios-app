//
//  AnswerGridItem.swift
//  clio-app
//
//  Created by Luciana Adrião on 07/10/23.
//

import SwiftUI

struct DescriptionItem: View {
    @Binding var description: String
    @Binding var foregroundColor: Color
    @Binding var backgroundColor: Color
    var isSelected = false
    var descriptionTapped: ((String) -> ())?

    var body: some View {
        Group {
            ZStack(alignment: .center) {
                Text(self.description).zIndex(1).padding(24)
                BorderedBackground(foregroundColor: .softGreen, hasBorder: false)
                BorderedBackground(foregroundColor: .offWhite, hasBorder: false).padding(12)
            }

            // TODO: Add ribbon when tapped
            HStack {
                Spacer()
                if isSelected {
                    Image("ribbon")
                        .offset(y: -36)
                }
            }
            .frame(height: 32)
        }
        .onTapGesture {
            descriptionTapped?(description)
        }
    }
}

#Preview {
    DescriptionItem(description: .constant("some text"), foregroundColor: .constant(.softGreen), backgroundColor: .constant(.offWhite), isSelected: false)
}
