//
//  VotingInstructionView.swift
//  clio-app
//
//  Created by Luciana Adrião on 07/10/23.
//

import SwiftUI

struct VotingInstructionView: View {
    @StateObject private var vm = VotingInstructionViewModel()
    @State var answerPopupShow: Bool = false
    @State var hasVoted: Bool = false

    var body: some View {
        VStack {
            Header(userList: .constant([""]),
                   masterUser: .constant("profile-picture-eye"))

            VStack(alignment:.center) {
                Text("Hora de votar!").font(.itimRegular(fontType: .title3))
                Text("Escolha  a sua resposta favorita.").font(.itimRegular(fontType: .body))
            }
            .multilineTextAlignment(.center)

            GeometryReader { geo in
                VStack(spacing: 10.0) {
                    RoundedRectangle(cornerRadius: 15.0).stroke(.black, style: StrokeStyle(lineWidth: 2.0))
                        .background {
                            Image("IMAGE_PASSED")
                                .resizable()
                                .scaledToFill()
                                .background(.white)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(maxHeight: geo.size.height * 0.6)

                    Spacer()

                    if hasVoted {
                        AnswerSelected(hasVoted: $hasVoted, selectedText: .constant(vm.selectedText.text), geo: geo)
                        
                    } else {
                        ActionButton(title: "Ver respostas", foregroundColor: .customPink, hasBorder: false) {
                            answerPopupShow.toggle()
                        }
                        .frame(height: geo.size.height * 0.1)
                    }
                }
                .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.9)
                .frame(width: geo.size.width, height: geo.size.height )
                .background(BorderedBackground(foregroundColor: .customYellow, backgroundColor: .offWhite, hasBorder: true))
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 12.0)
        .background(Color.offWhite)
        .popupNavigationView(show: $answerPopupShow) {
            VotingPopupView(isShowingPopup: $answerPopupShow)
                .frame(width: UIScreen.main.bounds.width - 36 ,height: UIScreen.main.bounds.height - 130)
        }
        .foregroundColor(.black)
    }
}

#Preview {
    VotingInstructionView()
}
