//
//  Friends.swift
//  BirthDaysData
//
//  Created by J____takumi  on 2024/12/21.
//

import Foundation
import SwiftData


// Data Model に変換してデータ保存をする
@Model
class Friends {
    var name: String
    var birthDay: Date
    
    // 初期化
    init(name:String,birthDay:Date){
        self.name = name
        self.birthDay = birthDay
    }
    var isBirthday:Bool{
        Calendar.current.isDateInToday(birthDay)
    }
}
