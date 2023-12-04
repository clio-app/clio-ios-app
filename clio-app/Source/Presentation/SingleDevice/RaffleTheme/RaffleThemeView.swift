//
//  RaffleThemeView.swift
//  clio-app
//
//  Created by Thiago Henrique on 17/10/23.
//

import SwiftUI
import ClioEntities
import ClioDomain

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
                .padding(.top, 5)
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
                ActionButton(title: "Sortear Novamente", foregroundColor: .customYellow, backgroundColor: .offWhite, hasBorder: true) {
                    withAnimation {
                        vm.isThemeSet = false
                        vm.setTheme(from: gameSession)
                    }
                }
                .padding(.trailing, 5)
                .frame(height: 60)
                .padding(.horizontal)
                .padding(.bottom)
                .transition(.scale.combined(with: .move(edge: .bottom)))
                ActionButton(title: "Continuar", foregroundColor: .lapisLazuli, backgroundColor: .offWhite, hasBorder: true) {
                    router.clear()
                    router.goToSelectPlayer()
                }
                .padding(.trailing, 5)
                .frame(height: 60)
                .padding(.horizontal)
                .padding(.bottom)
            } else {
                ActionButton(title: "Parar", foregroundColor: .lapisLazuli, backgroundColor: .offWhite, hasBorder: true) {
                    withAnimation {
                        vm.stopTimerAndSetTheme()
                        gameSession.selectFirstRoundPrompt()
                        AudioManager.shared.playSound(named: .sortedTheme)
                    }
                }
                .padding(.trailing, 5)
                .padding()
                .frame(height: 90)
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
    @ObservedObject var gameSession = GameSession()
    @ObservedObject var router = Router()
    gameSession.addPlayerInSession(
        name: "name01",
        image: "Lilac"
    )
    gameSession.addPlayerInSession(
        name: "name02",
        image: "Lilac"
    )
    gameSession.addPlayerInSession(
        name: "name03",
        image: "Lilac"
    )


    let raffleThemeView = RaffleThemeView()
        .environmentObject(gameSession)
        .environmentObject(router)

    return raffleThemeView
}
