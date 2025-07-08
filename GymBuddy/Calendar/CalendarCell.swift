//
//  CalendarCell.swift
//  GymBuddy
//
//  Created by Brandon Henderson on 4/16/25.
//
import SwiftUI

struct CalendarCell: View {
    @EnvironmentObject var dateHolder: DateHolder
    @EnvironmentObject var storage: ExerciseStorage
    let count: Int
    let startingSpaces: Int
    let daysInMonth: Int
    let daysInPrevMonth: Int
    let onSelect: () -> Void
    let fullDate: Date

    var body: some View {
        Button(action: onSelect) {
            ZStack(alignment: .topTrailing) {
                ZStack {
                    if fullDate.isToday {
                        Circle()
                            .fill(Color.red.opacity(0.2))
                            .frame(width: 36, height: 36)
                    }

                    Text(monthStruct().day())
                        .foregroundColor(typeColor(for: monthStruct().monthType))
                        .fontWeight(fullDate.isToday ? .bold : .regular)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                let workoutCount = storage.count(for: fullDate)
                if workoutCount > 0 {
                    Text("\(workoutCount)")
                        .font(.caption2)
                        .padding(5)
                        .background(Circle().fill(Color.red))
                        .foregroundColor(.white)
                        .offset(x: -4, y: 4)
                }
            }
        }
    }

    func typeColor(for type: MonthType) -> Color {
        return type == .Current ? .primary : .gray
    }

    func monthStruct() -> MonthStruct {
        let start = startingSpaces == 0 ? 7 : startingSpaces
        if count <= start {
            let day = daysInPrevMonth + count - start
            return MonthStruct(monthType: .Previous, dayInt: day)
        } else if count - start > daysInMonth {
            let day = count - start - daysInMonth
            return MonthStruct(monthType: .Next, dayInt: day)
        }
        let day = count - start
        return MonthStruct(monthType: .Current, dayInt: day)
    }
}
