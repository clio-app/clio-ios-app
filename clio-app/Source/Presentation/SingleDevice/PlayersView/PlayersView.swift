//
//  PlayersView.swift
//  clio-app
//
//  Created by Thiago Henrique on 17/10/23.
//

import SwiftUI
import Mixpanel

struct PlayersView: View {
    @EnvironmentObject var session: GameSession
    @EnvironmentObject var router: Router

    @State var text: String = ""
    @State var playerColor: String = ""
    @State private var newPlayer: Bool = false
    @FocusState private var focus: Bool

    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center) {
                Text("Adicione entre 3 a 5 amigos para iniciar o jogo")
                    .font(.itimRegular(fontType: .title3))
                    .multilineTextAlignment(.center)
                    .padding(24)
                    .background(Color.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                        .stroke(lineWidth: 2.0)
                    }
                    .padding(.bottom, 24)

                ForEach(session.gameFlowParameters.players, id: \.id) { player in
                    PlayerRow(color: player.picture, playerName: player.name) {
                        session.removePlayerInSession(player)
                    }.padding(.horizontal, 24)
                }

                if newPlayer {

                    AddPlayerField(color: $playerColor, playerName: $text,
                        onAddPlayer: {
                            addPlayerAndReset()
                        },
                        onChangeImage: {
                            changeImageAndFeedback()
                        }
                    )
                    .focused($focus, equals: true)
                    .padding(.horizontal, 10)
                }

                Button {
                    addPlayerAndReset()
                } label: {
                    Image(systemName: "plus.circle")
                    Text("Adicionar jogador")
                        .font(.itimRegular(fontType: .body))
                }
                .bold()
                .foregroundColor(Color.lapisLazuli)
            }
            .padding(.horizontal, 30)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .alert(isPresented: $session.alertError.showAlert) {
                Alert(title: Text("Error"), message: Text(session.alertError.errorMessage))
            }
            .keyboardAdaptive()
        }
        .onTapGesture {
            hideKeyboard()
            newPlayer = !text.isEmpty
        }
        .safeAreaInset(edge: .bottom) {
            ActionButton(title: "Iniciar", foregroundColor: .lapisLazuli , backgroundColor: .offWhite, hasBorder: true) {
                Mixpanel.mainInstance().track(
                    event: "Players",
                    properties: [
                        "count": "\(session.gameFlowParameters.players.count)"
                    ]
                )
                router.goToRaffleThemeView()
            }
            .padding()
            .frame(height: 92)
            .opacity(session.canStartGame() ? 0.2 : 1.0)
            .disabled(session.canStartGame())
        }
        .applyHelpButton(.AddPlayers)
        .ignoresSafeArea(.keyboard)
        .clioBackground()
        .scrollDismissesKeyboard(.interactively)
        .toolbarBackground(Color.lapisLazuli.opacity(0.2), for: .navigationBar)
    }

    // MARK: - Functions
    private func addPlayerAndReset() {
        performImpactFeedback()


        if newPlayer {
            session.addPlayerInSession(name: text, image: playerColor)
        } else if session.hasReachedPlayerLimit() {
            clearFocusAndTextfield()
        }
        resetInputFields()
        setFocusToTexField()
    }

    private func changeImageAndFeedback() {
        performImpactFeedback()
        playerColor = session.profileImageManager.randomizeProfileImage()
    }

    private func resetInputFields() {
        text = ""
        playerColor = session.profileImageManager.randomizeProfileImage()
    }

    private func setFocusToTexField() {
        newPlayer = !session.hasReachedPlayerLimit()
        focus = newPlayer
    }

    private func clearFocusAndTextfield() {
        // just to access the alert inside addPlayer
        session.addPlayerInSession(name: text, image: playerColor)
        newPlayer = false
        focus = newPlayer
    }

    private func performImpactFeedback() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}

#Preview {
    PlayersView()
}
