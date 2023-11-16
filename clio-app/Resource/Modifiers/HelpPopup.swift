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
    @State var willShowHelpAlert = false
    @State var helpAlert: Bool = false
    @State var text: String = ""
    let title: String
    var viewType: Views
    
    init(viewType: Views) {
        self.viewType = viewType
        self.title = NSLocalizedString("Tutorial", comment: "Tutorial")
    }
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            if willShowHelpAlert {
                VStack{}
                    .frame(width: 38, height: 44)
            }
            content
                .toolbar(willShowHelpAlert ? .hidden : .visible, for: .navigationBar)
        }
        .onAppear {
            text = getHintForView(viewType)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if !helpAlert {
                    Button() {
                        UIApplication.shared.endEditing()
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                        changeVisibility()
                    }label: {
                        Image(systemName: "questionmark.circle.fill")
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
                    .ignoresSafeArea()
                }
            }
        }
        .overlay {
            GeometryReader { geo in
                ZStack {
                    if helpAlert {
                        Color.black.opacity(0.3)
                            .transition(.opacity)
                            .onTapGesture {
                                changeVisibility()
                            }
                            .ignoresSafeArea(.all)
                        
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
    }
    
    private func changeVisibility() {
        withAnimation(.easeInOut(duration: 0.3)) {
            helpAlert.toggle()
        }
        willShowHelpAlert.toggle()
    }
 
    private func getHintForView(_ viewType: Views) -> String {
        switch viewType {
        case .Start:
            return NSLocalizedString("Start_Hint", comment: "Start view hint");
        case .AddPlayers:
            return NSLocalizedString("AddPlayers_Hint", comment: "AddPlayers view hint");
        case .RaffleTheme:
            return NSLocalizedString("RaffleTheme_Hint", comment: "RaffleTheme view hint");
        case .SelectPlayer:
            return NSLocalizedString("SelectPlayer_Hint", comment: "SelectPlayer view hint");
        case .firstPrompt:
            return NSLocalizedString("FirstPrompt_Hint", comment: "FirstPrompt view hint");
        case .PhotoArtifact:
            return NSLocalizedString("PhotoArtifact_Hint", comment: "PhotoArtifact view hint");
        case .DescriptionArtifact:
            return NSLocalizedString("DescriptionArtifact_Hint", comment: "DescriptionArtifact view hint");
        case .PresentResults:
            return NSLocalizedString("PresentResults", comment: "PresentResults view hint");
        case .AllResultsVisualization:
            return NSLocalizedString("ResultsVisualization_Hint", comment: "ResultsVisualization view hint");
        }
    }
}
