//
//  VotingPopupView.swift
//  clio-app
//
//  Created by Luciana Adrião on 07/10/23.
//

import SwiftUI
import ClioEntities

struct VotingPopupView: View {
    @State var progressValue: Float = 0.0
    @Binding var isShowingPopup: Bool
    var descriptionTapped: ((String) -> ())?

    @State var desc: [ClioEntities.Description] = [
        Description(id: UUID(), userID: UUID(), text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus eu justo in ligula accumsan fermentum. Nulla facilisi. Curabitur interdum, libero eget consectetur tincidunt, metus augue varius velit, a rhoncus lectus urna eu risus.", voteCount: 0),
           Description(id: UUID(), userID: UUID(), text: "Pellentesque non tortor eu purus cursus posuere. Ut a erat sit amet turpis congue vestibulum. Duis sed lectus vel justo varius euismod in non arcu. Proin rhoncus vel dui at iaculis.", voteCount: 0),
           Description(id: UUID(), userID: UUID(), text: "Suspendisse ac ex non ipsum varius viverra. Fusce efficitur interdum est, nec facilisis velit ullamcorper et. Vestibulum at vestibulum urna. Nunc rhoncus, elit eu efficitur hendrerit, elit erat vehicula odio.", voteCount: 0),
           Description(id: UUID(), userID: UUID(), text: "Aenean auctor, nisl eget efficitur convallis, augue odio volutpat dolor, ut bibendum tortor metus vel odio. Praesent euismod urna vel ex varius, eget fermentum odio tempus. Sed tristique ultrices turpis, ut volutpat justo.", voteCount: 0),
           Description(id: UUID(), userID: UUID(), text: "In sit amet dolor eget tellus bibendum tincidunt nec eget est. Nulla facilisi. Nullam ut dapibus libero, vel semper nisi. Vestibulum laoreet urna id justo ullamcorper dictum.", voteCount: 0),
    ]

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    // Dismiss self
                    isShowingPopup.toggle()
                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()

                }, label: {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, Color.peach)
                        .overlay {
                            Circle().stroke(.black)
                        }
                })
            }

            PieProgress(progressValue: self.$progressValue)
                .frame(height: 60.0)
                .padding(.bottom, 22)

            ScrollView(.vertical) {
                AnswerGrid(
                    descriptonArray: $desc, descriptionTapped: descriptionTapped)
                    .offset(y: 8.0)
            }
            .scrollIndicators(.hidden)
        }
        .padding()
        .background(BorderedBackground(foregroundColor: .offWhite, backgroundColor: .softGreen, hasBorder: true))
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                self.progressValue += 1
            }
        }
    }
}

#Preview {
    VotingPopupView(isShowingPopup: .constant(false))
}
