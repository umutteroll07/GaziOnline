//
//  StudentPersonInfoModel.swift
//  GaziOnline
//
//  Created by Umut Erol on 22.03.2024.
//

import Foundation

struct StudentPersonInfoModel{
    let id : String
    let name : String
    let surname : String
    let student_faculty : String
    let student_agno : String
    let student_class : String
    let student_desc : String
    
    
    init(id : String, name: String, surname: String, student_faculty: String, student_agno: String, student_class: String, student_desc: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.student_faculty = student_faculty
        self.student_agno = student_agno
        self.student_class = student_class
        self.student_desc = student_desc
    }
    
}
