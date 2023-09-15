//
//  ContentView.swift
//  clio-app
//
//  Created by Thiago Henrique on 15/09/23.
//

import SwiftUI

struct CreateRoomView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoomView()
    }
}
