//
//  CalendarDay.swift
//  LoveMyCapibara
//
//  Created by Maurício de Moura on 06/07/23.
//

import SwiftUI

struct CalendarDay: View {
    @ObservedObject var viewModel: CalendarViewModel
    var week: [Date]
    var day: Date
    var index: Int
    
    var body: some View {
        if viewModel.calendar.isDate(day, equalTo: viewModel.date, toGranularity: .month) {
            ZStack {
                //fillRange(day: day, week: week, index: index)
                Button {
                    viewModel.selectDay(day)
                } label: {
                    ZStack {
                        Text("\(viewModel.calendar.component(.day, from: day))")
                            .padding(.bottom, 5)
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(viewModel.isDateSelected(day: day) ? Color.white : Color("PrimaryColor"))
                        Circle()
                            .frame(width: 6, height: 6)
                            .foregroundColor(viewModel.isToday(day: day) ? (viewModel.isDateSelected(day: day) ? Color.white : Color("PrimaryColor")) : Color.clear)
                            .offset(y: 12)
                    }
                    .padding(.vertical, 10)
                    .frame(width: 36, height: 36)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .background(viewModel.isDateInRange(day: day) ?
                            (viewModel.isDateSelected(day: day) ? Color("PrimaryColor").cornerRadius(50) : Color.clear.cornerRadius(50))
                            : Color.clear.cornerRadius(50))
            }
            .frame(height: 36)
            .frame(maxWidth: .infinity)
        } else {
            Rectangle()
                .foregroundColor(Color.clear)
                .frame(height: 36)
                .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    func fillRange(day: Date, week: [Date], index: Int) -> some View {
        HStack(spacing: 0) {
            if viewModel.isDateSelected(day: day) {
                if day == viewModel.firstDate {
                    Color.clear
                } else {
                    Color.black
                }
            } else {
                if viewModel.isDateInRange(day: day) {
                    if index == 0 {
                        Color.clear
                    } else {
                        if viewModel.isFirstDayOfMonth(date: day) {
                            Color.clear
                        } else {
                            Color.black
                        }
                    }
                } else {
                    Color.clear
                }
            }
            
            if viewModel.isDateSelected(day: day) {
                if day == viewModel.secondDate {
                    Color.clear
                } else {
                    if viewModel.secondDate == nil {
                        Color.clear
                    } else {
                        Color.black
                    }
                }
            } else {
                if viewModel.isDateInRange(day: day) {
                    if index == week.count - 1 {
                        Color.clear
                    } else {
                        if viewModel.isLastDayOfMonth(date: day) {
                            Color.clear
                        } else {
                            Color.black
                        }
                    }
                } else {
                    Color.clear
                }
            }
        }
    }
}

//struct CalendarDay_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarDay()
//    }
//}
