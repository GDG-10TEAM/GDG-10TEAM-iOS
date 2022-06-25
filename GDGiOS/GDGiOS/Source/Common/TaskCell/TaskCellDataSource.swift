//
//  File.swift
//  GDGiOS
//
//  Created by 김민창 on 2022/06/26.
//

import Foundation

import RxDataSources

struct TaskCellDataSource {
    var items: [TaskCellModel]
    var identity: String
}

struct TaskCellModel: IdentifiableType, Equatable {
    typealias Identity = String
    
    var identity: Identity
    
    let title: String
    let progress: CGFloat
    let calendarTaskModel: CalendarTaskModel
}

extension TaskCellDataSource: AnimatableSectionModelType {
    init(original: TaskCellDataSource, items: [TaskCellModel]) {
        self = original
        self.items = items
    }
}
