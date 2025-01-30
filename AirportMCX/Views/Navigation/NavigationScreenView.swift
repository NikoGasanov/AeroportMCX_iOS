//
//  NavigationScreenView.swift
//  AirportMCX
//
//  Created by Niko Gasanov on 30.01.2025.
//


import SwiftUI

struct NavigationScreenView: View {
    var body: some View {
        VStack {
            Text("Навигация")
                .font(.largeTitle)
                .bold()
        }
        .navigationBarTitle("Навигация", displayMode: .inline)
    }
}
