//
//  DateScrollerView.swift
//  GymBuddy
//
//  Created by Brandon Henderson on 4/16/25.
//

import SwiftUI

struct DateScrollerView: View {
    @EnvironmentObject var dateHolder: DateHolder
    var body: some View {
        HStack {
            Spacer()

            Button(action: previousMonth) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.red)
                    .imageScale(.large)
                    .font(Font.title.weight(.bold))
            }
            Text(CalendarHelper().monthYearString(dateHolder.date))
                .font(.title)
                .bold()
                .animation(.default)
                .frame(maxWidth: .infinity)
            Button(action: nextMonth) {
                Image(systemName: "arrow.right")
                    .foregroundColor(.red)
                    .imageScale(.large)
                    .font(Font.title.weight(.bold))
            }
            Spacer()
        }
    }

    func previousMonth() {
        dateHolder.date = CalendarHelper().minusMonth(dateHolder.date)
    }

    func nextMonth() {
        dateHolder.date = CalendarHelper().plusMonth(dateHolder.date)
    }
}

#Preview {
    DateScrollerView()
}
