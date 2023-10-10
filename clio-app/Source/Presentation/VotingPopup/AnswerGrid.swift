//
//  VotingPopupGrid.swift
//  clio-app
//
//  Created by Luciana AdriÃ£o on 09/10/23.
//

import SwiftUI
import ClioEntities

struct AnswerGrid: View {
    var columnCount = 1
    @Binding var descriptonArray: [ClioEntities.Description]
    var descriptionTapped: ((String) -> ())?

    var body: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: columnCount), spacing: 20.0) {
            ForEach(0..<descriptonArray.count) { index in
                DescriptionItem(
                    description: .constant(descriptonArray[index].text),
                    foregroundColor: .constant(.offWhite),
                    backgroundColor: .constant(.softGreen),
                    descriptionTapped: descriptionTapped
                )
                .font(.itimRegular(fontType: .body))
                .padding(.horizontal, 12)
            }
        }
    }
}

//#Preview {
//    AnswerGrid(descriptonArray: .constant([Description(id: UUID(), userID: UUID(), text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus eu justo in ligula accumsan fermentum. Nulla facilisi. Curabitur interdum, libero eget consectetur tincidunt, metus augue varius velit, a rhoncus lectus urna eu risus.", voteCount: 0), Description(id: UUID(), userID: UUID(), text: "Pellentesque non tortor eu purus cursus posuere. Ut a erat sit amet turpis congue vestibulum. Duis sed lectus vel justo varius euismod in non arcu. Proin rhoncus vel dui at iaculis.", voteCount: 0),]))
//}
