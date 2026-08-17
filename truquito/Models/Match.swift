//
//  Match.swift
//  truquito
//
//  Created by Tomás García Gobet on 17.02.23.
//

import Foundation
import SwiftData

@Model
final class Match {
    var beginDate: Date = Date()
    var endDate: Date?
    var target: Int = 30
    @Relationship(deleteRule: .cascade, inverse: \Score.match)
    var scoreData: [Score]? = []

    init(beginDate: Date = Date(), endDate: Date? = nil, target: Int = 30) {
        self.beginDate = beginDate
        self.endDate = endDate
        self.target = target
    }
}
