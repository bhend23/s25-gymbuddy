//
//  OpeningView.swift
//  GymBuddy
//
//  Created by Brandon Henderson on 4/15/25.
//

import SwiftUI

struct OpeningView: View {
    var body: some View {
        NavigationStack {
            Spacer()

            VStack {
                Text("Welcome to GymBuddy!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "figure.run")
                    Image(systemName: "figure.core.training")
                    Image(systemName: "figure.cross.training")
                    Image(systemName: "figure.flexibility")
                }
                .font(.title)
                .foregroundColor(Color.red)
            }

            Spacer()

            NavigationLink(destination: CalendarView()) {
                Text("Get Started")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    OpeningView()
}
