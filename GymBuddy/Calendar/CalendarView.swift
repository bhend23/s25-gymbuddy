//
//  CalendarView.swift
//  GymBuddy
//
//  Created by Brandon Henderson on 4/16/25.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var storage: ExerciseStorage
    @EnvironmentObject var dateHolder: DateHolder
    @State private var selectedDate: Date? = nil
    @State private var showExerciseSheet = false

    var body: some View {
        VStack(spacing: 1) {
            DateScrollerView()
                .environmentObject(dateHolder)
                .padding()
            dayOfWeekStack
            calendarGrid
        }
        .sheet(item: $selectedDate) { date in
            WorkoutSummaryView(date: date)
                .environmentObject(storage)
        }
    }

    var dayOfWeekStack: some View {
        HStack(spacing: 1) {
            Text("Sun").dayOfWeek()
            Text("Mon").dayOfWeek()
            Text("Tue").dayOfWeek()
            Text("Wed").dayOfWeek()
            Text("Thu").dayOfWeek()
            Text("Fri").dayOfWeek()
            Text("Sat").dayOfWeek()
        }
    }

    var calendarGrid: some View {
        let helper = CalendarHelper()
        let daysInMonth = helper.daysInMonth(dateHolder.date)
        let firstDayOfMonth = helper.firstOfMonth(dateHolder.date)
        let startingSpaces = helper.weekDay(firstDayOfMonth)
        let prevMonth = helper.minusMonth(dateHolder.date)
        let daysInPrevMonth = helper.daysInMonth(prevMonth)

        return VStack(spacing: 1) {
            ForEach(0..<6, id: \.self) { row in
                HStack(spacing: 1) {
                    ForEach(0..<7, id: \.self) { column in
                        let count = column + (row * 7)
                        CalendarCell(
                            count: count,
                            startingSpaces: startingSpaces,
                            daysInMonth: daysInMonth,
                            daysInPrevMonth: daysInPrevMonth,
                            onSelect: {
                                selectedDate = dateForCell(count: count, startingSpaces: startingSpaces)
                            },
                            fullDate: dateForCell(count: count, startingSpaces: startingSpaces)
                        )
                        .environmentObject(dateHolder)
                        .environmentObject(storage)
                    }
                    .padding(4)
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(8)
                }
            }
        }
    }

    func dateForCell(count: Int, startingSpaces: Int) -> Date {
        let calendar = Calendar.current
        let start = startingSpaces == 0 ? 7 : startingSpaces
        let offset = count - start
        if offset < 0 {
            let prevMonth = CalendarHelper().minusMonth(dateHolder.date)
            return calendar.date(byAdding: .day, value: CalendarHelper().daysInMonth(prevMonth) + offset, to: CalendarHelper().firstOfMonth(prevMonth))!
        } else if offset >= CalendarHelper().daysInMonth(dateHolder.date) {
            let nextMonth = CalendarHelper().plusMonth(dateHolder.date)
            return calendar.date(byAdding: .day, value: offset - CalendarHelper().daysInMonth(dateHolder.date), to: CalendarHelper().firstOfMonth(nextMonth))!
        } else {
            return calendar.date(byAdding: .day, value: offset, to: CalendarHelper().firstOfMonth(dateHolder.date))!
        }
    }
}

extension Text {
    func dayOfWeek() -> some View {
        frame(maxWidth: .infinity)
            .padding(.top, 1)
            .lineLimit(1)
    }
}

extension Date: @retroactive Identifiable {
    public var id: Date { self }
}

extension Date {
    var isToday: Bool {
        let adjusted = Calendar.current.date(byAdding: .day, value: -1, to: self)!
        return Calendar.current.isDateInToday(adjusted)
    }
}
