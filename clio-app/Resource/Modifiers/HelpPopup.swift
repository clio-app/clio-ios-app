//
//  HelpButton.swift
//  clio-app
//
//  Created by Beatriz Leonel da Silva on 24/10/23.
//

import Foundation
import SwiftUI

// MARK: Help button and Pop Up
extension View {
    func applyHelpButton(_ help: HelpArea.HelpType) -> some View {
        return modifier(HelpArea(title: "Tutorial", text: help.description))
    }
}

struct HelpArea: ViewModifier {
    @State var helpAlert: Bool = false
    let title: String
    let text: String
    
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .overlay {
                GeometryReader { geo in
                    ZStack {
                        if helpAlert {
                            Color.black.opacity(0.3)
                                .ignoresSafeArea()
                                .transition(.opacity)
                                .onTapGesture {
                                    changeVisibility()
                                }
                            
                             CustomAlert(
                                isPopupPresented: $helpAlert,
                                title: title,
                                text: text
                            )
                            .ignoresSafeArea()
                            .padding()
                            .transition(.scale.combined(with: .offset(
                                x: geo.size.width,
                                y: -geo.size.height
                            )))
                            .clipped()
                            .scaleEffect(1)
                            .offset(
                                x: helpAlert ? 0 : -2000,
                                y: helpAlert ? 0 : -2000
                            )
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button() {
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                        changeVisibility()
                    }label: {
                        Image(systemName: "exclamationmark.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.lapisLazuli)
                            .frame(width: 38, height: 38)
                            .background {
                                Color.white
                                    .clipShape(Circle())
                                    .shadow(radius: 2)
                            }
                            .padding(.top, 2)
                            .padding(.bottom,5)
                            .padding(.leading, 10)
                        
                    }
                    .transition(.move(edge: .bottom).combined(with: .move(edge: .leading)))
                    .disabled(helpAlert)
                    .opacity(helpAlert ? 0 : 1)
                }
            }
    }
    
    func changeVisibility() {
        withAnimation(.easeInOut(duration: 0.3)) {
            helpAlert.toggle()
        }
    }
    
}


extension HelpArea {
    enum HelpType {
        case start
        case addingPlayer
        case selectTheme
        case selectPlayer
        case capturePhoto
        case captureDescription
        case presentResult
        case readyForResults
        
        var description: String {
            switch self {
            case .start:
                return "Selecione o modo de jogo para iniciar a partida."
            case .addingPlayer:
                return "Adicione todos os jogadores que irão participar da rodada."
            case .selectTheme:
                return "A frase apresentada servirá de contexto e dica para as próximas fases do jogo."
            case .selectPlayer:
                return "Passe o dispositivo para o jogador ilustrado na tela ou selecione 'não' até que apareça o seu nome."
            case .capturePhoto:
                return "Tire foto de algo que você acha que faz relação com a frase. E selecione 'Enviar' se gostou da sua conexão."
            case .captureDescription:
                return "Faça uma descrição que explique a conexão entre a foto e o tema."
            case .presentResult:
                return "Veja quais foram as relações feitas pelos outros jogadore e se divirta."
            case .readyForResults:
                return "Junte todos os jogadores para ver as respostas mais inusitadas e descobrir quem pensou fora da caixinha."
            }
        }
    }
}
