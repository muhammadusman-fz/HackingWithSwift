//
//  BucketListP.swift
//  SwiftUI 100
//
//  Created by Muhammad Usman on 24/8/2022.
//

import SwiftUI
/// Adding conformance to Compareable for custom types
/// Writing data to the documents directory
/// 

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
        VStack {
            List(students) { student in
                Text("\(student.firstName) \(student.lastName)")
            }
            
            Button("Read & Write") {
                let url = getDocumentsDirectory().appendingPathComponent("BucketListP.txt")
                let message = "Hello World"
                do {
                    try message.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct BucketListP_Previews: PreviewProvider {
    static var previews: some View {
        BucketListP()
    }
}
