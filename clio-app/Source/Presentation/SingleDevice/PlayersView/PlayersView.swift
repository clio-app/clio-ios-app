//
//  PlayersView.swift
//  clio-app
//
//  Created by Thiago Henrique on 17/10/23.
//

import SwiftUI

struct PlayersView: View {
    @EnvironmentObject var session: GameSession
    @EnvironmentObject var router: Router

    @State var text: String = ""
    @State var profileImage: String = ""
    @State private var newPlayer: Bool = false
    @FocusState private var focus: Bool

    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center) {
                Text("Jogadores")
                    .font(.largeTitle)

                ForEach(session.gameFlowParameters.players, id: \.id) { player in
                    PlayerRow(playerImage: player.picture, playerName: player.name) {
                        session.removePlayerInSession(player)
                    }
                }

                if newPlayer {
                    AddPlayerField(playerImage: $profileImage, playerName: $text,
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

                Button("Adicionar Jogador") {
                    addPlayerAndReset()
                }
                .buttonStyle(.bordered)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .alert(isPresented: $session.alertError.showAlert) {
                Alert(title: Text("Error"), message: Text(session.alertError.errorMessage))
            }

            .keyboardAdaptive()
        }
        .background {
            Color.white.ignoresSafeArea()
        }
        .onTapGesture {
            hideKeyboard()
            newPlayer = !text.isEmpty
        }
        .safeAreaInset(edge: .bottom) {
            Button("Começar") {
                router.goToRaffleThemeView()
            }
            .buttonStyle(.borderedProminent)
            .disabled(session.canStartGame())
        }
        .ignoresSafeArea(.keyboard)
    }

    // MARK: - Functions
    private func addPlayerAndReset() {
        performImpactFeedback()


        if newPlayer {
            session.addPlayerInSession(name: text, image: profileImage)
        } else if session.hasReachedPlayerLimit() {
            clearFocusAndTextfield()
        }
        resetInputFields()
        setFocusToTexField()
    }

    private func changeImageAndFeedback() {
        performImpactFeedback()
        profileImage = session.randomizeProfileImage()
    }

    private func resetInputFields() {
        text = ""
        profileImage = session.randomizeProfileImage()
    }

    private func setFocusToTexField() {
        newPlayer = !session.hasReachedPlayerLimit()
        focus = newPlayer
    }

    private func clearFocusAndTextfield() {
        // just to access the alert inside addPlayer
        session.addPlayerInSession(name: text, image: profileImage)
        newPlayer = false
        focus = newPlayer
    }

    private func performImpactFeedback() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}

// MARK: - Views
struct PlayerRow: View {
    var playerImage: String
    var playerName: String
    var delete: (() -> Void)

    var body: some View {
        HStack {
            Image(playerImage).resizable().scaledToFit()
                .frame(width: 45, alignment: .center)
            Text(playerName)
            Spacer()
            Button {
                delete()
            } label: {
                Image(systemName: "trash").foregroundColor(.red)
            }
        }
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Color.gray.opacity(0.2))
        }
        .padding(.horizontal, 24)
    }
}

struct AddPlayerField: View {
    @Binding var playerImage: String
    @Binding var playerName: String

    var onAddPlayer: (() -> Void)
    var onChangeImage: (() -> Void)

    var body: some View {
        HStack {
            Image(playerImage)
                .resizable()
                .scaledToFit()
                .frame(width: 45, alignment: .center)
                .onTapGesture {
                    onChangeImage()
                }

            TextField(text: $playerName) {
                Text("Insira o nome do jogador")
                    .foregroundColor(.black.opacity(0.6))
            }
            .textFieldStyle(PlainTextFieldStyle())
            .padding(6)
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
            .foregroundColor(.black)
            .submitLabel(.done)
            .onSubmit {
                onAddPlayer()
            }
        }
    }
}

// MARK: - Extensions
extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

#Preview {
    PlayersView()
}
