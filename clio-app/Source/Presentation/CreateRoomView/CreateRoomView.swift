//
//  ContentView.swift
//  clio-app
//
//  Created by Thiago Henrique on 15/09/23.
//

import SwiftUI
import Combine

protocol CreateRoomDisplayLogic {
    func displayRoomCode(viewModel: CreateRoom.ViewModel)
}

struct CreateRoomView: View {
    @State private var roomNameInput: String = ""
    @State private var roomThemeInput: String = ""
    
    @State private var isTextFieldActive: Bool = false
        
    public var buttonPressedSubject = PassthroughSubject<Void, Never>()
        
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    titleView
                        .padding(.top, 15)
                    
                    Spacer()
                    
                    formView
                    
                    Spacer()
                    Spacer()
                    
                    ActionButton(
                        title: "Criar sala",
                        foregroundColor: .lapisLazuli,
                        hasBorder: false,
                        action: {
                            UIApplication.shared.endEditing()
                            buttonPressedSubject.send()
                        })
                    .frame(height: 60)
                    
                }
                .padding()
                .frame(height: geometry.size.height)
            }
            .keyboardAdaptive()
        }
        .ignoresSafeArea(.keyboard)
        .background(
            Color.white
                .ignoresSafeArea()
        )
        .onTapGesture {
            UIApplication.shared.endEditing()
            self.isTextFieldActive = false
        }
        
    }
}

extension CreateRoomView {
    private var titleView: some View {
        StrokeText(
            text: "Crie uma sala",
            borderWidth: 2,
            borderColor: .black
        )
        .font(.nightyDemo(fontType: .largeTitle))
        .foregroundColor(.lapisLazuli)
    }
    
    private var formView: some View {
        VStack(spacing: 60) {
            formField(
                labelText: "Escolha um nome para a sala",
                placeHolder: "Escreva o nome da sala...",
                input: $roomNameInput)
            
            formField(
                labelText: "Escolha um tema",
                placeHolder: "Escreva o tema da sala...",
                input: $roomThemeInput)
            
        }
    }
    
    private func formField(labelText: String, placeHolder: String, input: Binding<String>) -> some View {
        VStack {
            Text(labelText)
                .font(.itimRegular(fontType: .title3))
                .foregroundColor(.black)
            
            TextFieldView(
                inputText: input,
                placeholder: placeHolder,
                color: .lapisLazuli
            )
            .onTapGesture {
                self.isTextFieldActive = true
            }
        }
    }
}

extension CreateRoomView: CreateRoomDisplayLogic {
    func displayRoomCode(viewModel: CreateRoom.ViewModel) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoomView()
    }
}
