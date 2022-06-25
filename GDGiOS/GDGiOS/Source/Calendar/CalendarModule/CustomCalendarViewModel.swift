//
//  CustomCalendarViewModel.swift
//  CustomCalendarView
//
//  Created by 김민창 on 2022/05/03.
//

import Foundation

import RxSwift
import RxCocoa

struct CustomCalendarViewModelInput {
    let selectedItem: BehaviorSubject<CustomCalendarCellModel?>
    let beforeMonth: BehaviorSubject<Void?>
    let nextMonth: BehaviorSubject<Void?>
}

struct CustomCalendarViewModelOutput {
    let yearMonthText: Driver<String>
    let beforeMonthText: Driver<String>
    let nextMonthText: Driver<String>
    let currentMonth: Driver<String>
    let selectedDate: Driver<Date?>
    let cellDataSource: Driver<[CustomCalendarCellDataSource]>
}

final class CustomCalendarViewModel {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    let input: CustomCalendarViewModelInput
    let output: CustomCalendarViewModelOutput
    
    private let _selectedItem = BehaviorSubject<CustomCalendarCellModel?>(value: nil)
    private let _beforeMonth = BehaviorSubject<Void?>(value: nil)
    private let _nextMonth = BehaviorSubject<Void?>(value: nil)
    
    private let _yearMonthText = BehaviorSubject<String>(value: "")
    private let _beforeMonthText = BehaviorSubject<String>(value: "")
    private let _nextMonthText = BehaviorSubject<String>(value: "")
    private let _currentMonth = BehaviorSubject<String>(value: "")
    private let _selectedDate = BehaviorSubject<Date?>(value: nil)
    private let _cellDataSource = BehaviorSubject<[CustomCalendarCellDataSource]>(value: [])
    
    private let _dayFormatter = DateFormatter()
    
    private let _currentDate = Date()
    private var _calendar = Calendar.init(identifier: .gregorian)
    private var _components = DateComponents()
    private var _beforeComponents = DateComponents()
    
    let mockList: [[CalendarTaskModel]] = [
        [.clean, .wash, .kitchen, .friend, .payment],
        [.clean, .wash, .kitchen, .payment],
        [.clean, .kitchen, .payment],
        [.wash, .kitchen, .friend],
        [],
        [.wash, .kitchen, .payment],
        [.clean, .wash, .payment],
        [.wash, .payment],
    ]
    
    init() {
        self.input = CustomCalendarViewModelInput(
            selectedItem: _selectedItem.asObserver(),
            beforeMonth: _beforeMonth.asObserver(),
            nextMonth: _nextMonth.asObserver()
        )
        self.output = CustomCalendarViewModelOutput(
            yearMonthText: _yearMonthText.asDriver(onErrorJustReturn: ""),
            beforeMonthText: _beforeMonthText.asDriver(onErrorJustReturn: ""),
            nextMonthText: _nextMonthText.asDriver(onErrorJustReturn: ""),
            currentMonth: _currentMonth.asDriver(onErrorJustReturn: ""),
            selectedDate: _selectedDate.asDriver(onErrorJustReturn: nil),
            cellDataSource: _cellDataSource.asDriver(onErrorJustReturn: [])
        )
        
        self._configure()
        
        self._bindSelectedItem()
        self._bindBeforeMonth()
        self._bindNextMonth()
    }
    
    private func _configure() {
        self._dayFormatter.dateFormat = "yyyyMMdd"
        
        self._configureCalendar(self._currentDate)
    }
    
    private func _configureCalendar(_ date: Date) {
        let currentYear = _calendar.component(.year, from: date)
        let currentMonth = _calendar.component(.month, from: date)
        
        self._components.year = currentYear
        self._components.month = currentMonth
        self._components.day = 1
        
        self._beforeComponents.year = currentYear
        self._beforeComponents.month = currentMonth - 1
        self._beforeComponents.day = 1
        
        self._makeCalendarCellDataSource()
    }
    
    private func _makeCalendarCellDataSource() {
        guard let firstDayOfMonth = _calendar.date(from: _components),
              let beforeDayOfMonth = _calendar.date(from: _beforeComponents),
              let daysCountInMonth = _calendar.range(of: .day, in: .month, for: firstDayOfMonth)?.count,
              let daysCountBeforeMonth = _calendar.range(of: .day, in: .month, for: beforeDayOfMonth)?.count
        else { return }
        
        let firstWeekday = 2 - _calendar.component(.weekday, from: firstDayOfMonth)
        
        let currentMonth = self._components.month ?? 12
        let beforeMonth = currentMonth - 1 <= 0 ? 12 : currentMonth - 1
        let nextMonth = currentMonth + 1 > 12 ? 1 : currentMonth + 1
        self._yearMonthText
            .onNext(String(currentMonth).count == 1 ? "0\(String(currentMonth))" : String(currentMonth))
        self._beforeMonthText
            .onNext(String(beforeMonth).count == 1 ? "0\(String(beforeMonth))" : String(beforeMonth))
        self._nextMonthText
            .onNext(String(nextMonth).count == 1 ? "0\(String(nextMonth))" : String(nextMonth))
        
        var cellModels = [CustomCalendarCellModel]()
        var count = 0
        
        for day in firstWeekday...daysCountInMonth {
            var tempComponents = _components
            tempComponents.day = day
            if day < 1 {
                cellModels.append(CustomCalendarCellModel(
                    identity: UUID().uuidString,
                    isSunDay: false,
                    isCurrentMonth: false,
                    calendarTaskModel: mockList[Int.random(in: 0...7)],
                    day: daysCountBeforeMonth + day,
                    date: _calendar.date(from: tempComponents))
                )
            } else {
                cellModels.append(CustomCalendarCellModel(
                    identity: UUID().uuidString,
                    isSunDay: count % 7 == 0 ? true : false,
                    isCurrentMonth: true,
                    calendarTaskModel: mockList[Int.random(in: 0...7)],
                    day: day,
                    date: _calendar.date(from: tempComponents))
                )
            }
            count += 1
        }
        
        var nextDay = 1
        
        while cellModels.count % 7 != 0 {
            var tempComponents = _components
            tempComponents.month = currentMonth + 1
            tempComponents.day = nextDay
            
            cellModels.append(CustomCalendarCellModel(
                identity: UUID().uuidString,
                isSunDay: false,
                isCurrentMonth: true,
                calendarTaskModel: mockList[Int.random(in: 0...7)],
                day: nextDay,
                date: _calendar.date(from: tempComponents))
            )
            nextDay += 1
        }
        
        self._cellDataSource.onNext([
            CustomCalendarCellDataSource(items: cellModels, identity: UUID().uuidString)
        ])
    }
    
    private func isSelectedDate(_ date: Date?) -> Bool {
        guard let compareDate = try? self._selectedDate.value(),
              let date = date else { return false }
        
        let firstDate = _dayFormatter.string(from: compareDate)
        let secondDate = _dayFormatter.string(from: date)
        
        return firstDate == secondDate
    }
    
    private func isSameDate(_ date: Date?) -> Bool {
        guard let date = date else { return false }
        
        let firstDate = _dayFormatter.string(from: self._currentDate)
        let secondDate = _dayFormatter.string(from: date)
        
        return firstDate == secondDate
    }
}

//MARK: - Binding
extension CustomCalendarViewModel {
    private func _bindSelectedItem() {
        self._selectedItem
            .compactMap { $0 }
            .subscribe(onNext : { [weak self] model in
                if !model.isCurrentMonth { return }
                self?._selectedDate.onNext(model.date)
            })
            .disposed(by: disposeBag)
    }
  
    private func _bindBeforeMonth() {
        self._beforeMonth
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] _ in
                guard let self = self,
                      let month = self._components.month else { return }
                
                self._beforeComponents.month = month - 2
                self._components.month = month - 1
                self._makeCalendarCellDataSource()
            })
            .disposed(by: disposeBag)
  }
  
    private func _bindNextMonth() {
        self._nextMonth
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] _ in
                guard let self = self,
                      let month = self._components.month else { return }
                
                self._beforeComponents.month = month
                self._components.month = month + 1
                self._makeCalendarCellDataSource()
                
            })
            .disposed(by: disposeBag)
  }
}
