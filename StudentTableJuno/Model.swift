//
//  File.swift
//  StudentTableJuno
//
//  Created by мак on 05.02.2020.
//  Copyright © 2020 viktorsafonov. All rights reserved.
//

import Foundation


class Students: Codable {
    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(surName, forKey: "surName")
//        aCoder.encode(name, forKey: "name")
//        aCoder.encode(rate, forKey: "rate")
//        aCoder.encode(gender, forKey: "gender")
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        surName = aDecoder.decodeObject(forKey: "surName") as? String ?? ""
//        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
//        rate = aDecoder.decodeObject(forKey: "rate") as? String ?? ""
//        gender = aDecoder.decodeObject(forKey: "gender") as? String ?? ""
//    }
    
    var surName: String
    var name : String
    var rate: String
    var gender: String
    init(surName : String, name: String, rate: String, gender: String) {
        self.surName = surName
        self.name = name
        self.rate = rate
        self.gender = gender
    }
}

var studentList = [Students]()

//    {
//    set {
//        UserDefaults.standard.set(newValue, forKey: "studentDataKey")
//        UserDefaults.standard.synchronize()
//    }
//
//    get {
//        if let array = UserDefaults.standard.array(forKey: "studentDataKey") as? [Students] {
//           return array
//        } else {
//            return []
//        }
//    }
//}



func addStudent(newStudent: Students) {
studentList.append(newStudent)
   //save()
}


func sortedStudentSurName () {
    studentList = studentList.sorted(by: {$0.surName < $1.surName})
    //save()
    
}


//func save () {
//    if let encoded = try? JSONEncoder().encode(studentList) {
//        UserDefaults.standard.set(encoded, forKey: "studentKey")
//        print("Save student")
//    }
//}
//
//func loadData () {
//    if let savedStudent = UserDefaults.standard.object(forKey: "studentKey") as? Data {
//        if let loadedStudent = try? JSONDecoder().decode([Students].self, from: savedStudent) {
//
//            print(loadedStudent)
//
//        }
//    }
//}
//

