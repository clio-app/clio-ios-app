//
//  ContentView.swift
//  clio-app
//
//  Created by Thiago Henrique on 15/09/23.
//

import SwiftUI
import Combine

struct ErrorAlert {
    var showAlert: Bool
    let title: String
    let description: String
    
    static func initialState() -> ErrorAlert {
        return ErrorAlert(showAlert: false, title: "", description: "")
    }
}

struct CreateRoomView: View {    
    @StateObject private var vm = CreateRoomViewModel()
    @State private var isTextFieldActive: Bool = false
    @State private var errorAlert: ErrorAlert = ErrorAlert.initialState()
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
                    
                    Text("Cada sala pode haver no máximo 8 pessoas (com o professor).")
                        .multilineTextAlignment(.center)
                        .font(.itimRegular(size: 20))
                        .foregroundColor(.lapisLazuli)
                    
                    Spacer()
                    Spacer()
                    
                    ActionButton(
                        title: "Criar sala",
                        foregroundColor: .lapisLazuli,
                        hasBorder: false,
                        action: {
                            UIApplication.shared.endEditing()
                            buttonPressedSubject.send()
                            Task {
                                await vm.createRoom(
                                    request: CreateRoomModel.Create.Request(
                                        name: vm.roomNameInput,
                                        theme: .init(title: vm.roomThemeInput)
                                    )
                                )
                            }
                        }
                    )
                    .frame(height: 60)
                }
                .padding()
                .frame(height: geometry.size.height)
                .disabled(vm.viewState == .loading)
                .opacity(vm.viewState == .loading ? 0.3 : 1)
                .overlay {
                    if vm.viewState == .loading {
                        ProgressView()
                            .frame(width: 60, height: 60, alignment: .center)
                    }
                }
            }
            .keyboardAdaptive()
        }
        .alert(isPresented: $errorAlert.showAlert) {
            Alert(
                title: Text(errorAlert.title),
                message: Text(errorAlert.description),
                dismissButton: Alert.Button.cancel()
            )
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
        .onChange(of: vm.viewState, perform: { value in
            switch value {
                case let .failed(title, description):
                    errorAlert = ErrorAlert(
                        showAlert: true,
                        title: title,
                        description: description
                    )
                default:
                    return
            }
        })
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
                input: $vm.roomNameInput)
            
            formField(
                labelText: "Escolha um tema",
                placeHolder: "Escreva o tema da sala...",
                input: $vm.roomThemeInput)
            
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoomView()
    }
}
