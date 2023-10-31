//
//  RaffleThemeView.swift
//  clio-app
//
//  Created by Thiago Henrique on 17/10/23.
//

import SwiftUI

struct RaffleThemeView: View {
    @EnvironmentObject var gameSession: GameSession
    @EnvironmentObject var router: Router
    @StateObject private var vm: RaffleThemeViewModel = RaffleThemeViewModel()

    var body: some View {
        VStack {
            Text("O tema esta sendo sorteado...")
                .font(.itimRegular(fontType: .title3))
                .multilineTextAlignment(.center)
                .padding(24)
                .background(
                    Color.white
                        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                        .stroke(lineWidth: 2.0)
                }
                .padding(.bottom, 24)

            Spacer()

            Text("O tema é: ")
                .font(.itimRegular(fontType: .title3))
                .multilineTextAlignment(.center)
                .padding(.bottom, 24)
                .padding(.horizontal, 60)

            HStack {
                Spacer()
                themeSlot(theme: $gameSession.gameFlowParameters.sessionTheme)
                    .padding()
                Spacer()
            }
            .padding(.horizontal, 24)

            Spacer()
            Spacer()
            
            if vm.isThemeSet {
                ActionButton(title: "Continuar", foregroundColor: .lapisLazuli, backgroundColor: .offWhite, hasBorder: true) {
                    router.clear()
                    router.goToSelectPlayer()
                }
                .padding()
                .frame(height: 92)
            } else {
                ActionButton(title: "Parar", foregroundColor: .lapisLazuli, backgroundColor: .offWhite, hasBorder: true) {
                    vm.stopTimerAndSetTheme()
                    gameSession.selectFirstRoundPrompt()
                    print(gameSession.gameFlowParameters.firstRoundPrompt)
                }
                .padding()
                .frame(height: 92)
            }
        }
        .applyHelpButton(.RaffleTheme)
        .onAppear {
            vm.setTheme(from: gameSession)
        }
        .onDisappear(perform: {
            vm.stopTimerAndSetTheme()
        })
        .foregroundColor(.black)
        .clioBackground()
    }
}

#Preview {
    RaffleThemeView()
}
