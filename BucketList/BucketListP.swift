//
//  BucketListP.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 24/8/2022.
//

import SwiftUI
/// Adding conformance to Compareable for custom types

struct Student: Identifiable, Comparable {
    let id = UUID()
    var firstName: String
    var lastName: String
    
    static func < (lhs: Student, rhs: Student) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct BucketListP: View {
    let students = [
    Student(firstName: "Muhammad", lastName: "Usman"),
    Student(firstName: "Abdul", lastName: "Qadir"),
    Student(firstName: "Zia", lastName: "Ali")
    ].sorted()
    var body: some View {
        List(students) { student in
            Text("\(student.firstName) \(student.lastName)")
        }
    }
}

struct BucketListP_Previews: PreviewProvider {
    static var previews: some View {
        BucketListP()
    }
}
