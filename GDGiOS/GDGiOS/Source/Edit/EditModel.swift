//
//  EditModel.swift
//  GDGiOS
//
//  Created by 김민창 on 2022/06/26.
//

import Foundation

import RxDataSources

struct EditCellDataSource {
    var items: [EditCellModel]
    var identity: String
}

struct EditCellModel: IdentifiableType, Equatable {
    typealias Identity = String
    
    var identity: Identity
    
    let title: String
    let calendarTaskModel: CalendarTaskModel
}

extension EditCellDataSource: AnimatableSectionModelType {
    init(original: EditCellDataSource, items: [EditCellModel]) {
        self = original
        self.items = items
    }
}
