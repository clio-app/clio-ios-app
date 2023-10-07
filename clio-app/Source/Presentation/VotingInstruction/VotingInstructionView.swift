//
//  VotingInstructionView.swift
//  clio-app
//
//  Created by Luciana Adrião on 07/10/23.
//

import SwiftUI

struct VotingInstructionView: View {
//    @StateObject private var vm = VotingInstructionViewModel()

    var body: some View {
            VStack {
                // TODO: Fetch from viewmodel participants
                Header(userList: .constant(["profile-picture-eye","profile-picture-eye","profile-picture-eye"]), masterUser: .constant("profile-picture-eye"))

                VStack(alignment:.center) {
                    Text("Hora de votar!").font(.itimRegular(fontType: .title3))
                    Text("Escolha  asua resposta favorita.").font(.itimRegular(fontType: .body))
                }.multilineTextAlignment(.center)

                GeometryReader { geo in
                VStack(spacing: 50.0) {
                    RoundedRectangle(cornerRadius: 15.0).stroke(.black, style: StrokeStyle(lineWidth: 2.0))
                        .overlay {
                            Image("IMAGE_PASSED")
                                .resizable()
                                .scaledToFill()
                                .background(.white)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 15))


                    ActionButton(title: "Ver respostas", foregroundColor: .customPink, hasBorder: false) {
                        // Button action
                    }
                    .frame(height: 62)

                }
                .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.9)
                .frame(width: geo.size.width, height: geo.size.height )
                .background(BorderedBackground(foregroundColor: .customYellow, backgroundColor: .offWhite, hasBorder: true))
            }
                .padding(.horizontal)
        }
    }
}

#Preview {
    VotingInstructionView()
}
