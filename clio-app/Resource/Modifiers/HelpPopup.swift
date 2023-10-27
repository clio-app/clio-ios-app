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
    func applyHelpButton(_ view: Views) -> some View {
        return modifier(HelpArea(viewType: view))
    }
}

struct HelpArea: ViewModifier {
    @State var helpAlert: Bool = false
    @State var text: String = ""
    let title: String
    var viewType: Views
    
    init(viewType: Views) {
        self.viewType = viewType
        self.title = "Tutorial"
    }
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                text = getHintForView(viewType)
            }
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
    
    private func changeVisibility() {
        withAnimation(.easeInOut(duration: 0.3)) {
            helpAlert.toggle()
        }
    }
    
    private func getHintForView(_ viewType: Views) -> String {
        switch viewType{
        case .Start:
            return "Selecione o modo de jogo para iniciar a partida."
        case .AddPlayers:
            return "Adicione todos os jogadores que irão participar da rodada."
        case .RaffleTheme:
            return "A frase apresentada servirá de contexto e dica para as próximas fases do jogo."
        case .SelectPlayer:
            return "Passe o dispositivo para o jogador ilustrado na tela ou selecione 'não' até que apareça o seu nome."
        case .PhotoArtifact:
            return "Tire foto de algo que você acha que faz relação com a frase. E selecione 'Enviar' se gostou da sua conexão."
        case .DescriptionArtifact:
            return "Faça uma descrição que explique a conexão entre a foto e o tema."
        case .PresentResults:
            return "Junte todos os jogadores para ver as respostas mais inusitadas e descobrir quem pensou fora da caixinha."
        case .ResultsVisualization:
            return "Veja quais foram as interpretações feitas pelos outros jogadore e se divirta."
        }
    }
}
