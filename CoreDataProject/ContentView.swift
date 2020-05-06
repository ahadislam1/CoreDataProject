//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Ahad Islam on 5/6/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import SwiftUI

/**
 \.self means the whole object.
 It means if we can conform hashable to our models then it'll value itself as struct.
 
 CoreData also creates sequential object identifiers so it doesn't break when objects have identical properties.
 */
struct Student: Hashable {
    let name: String
}

struct StudentView: View {
    let students = [Student(name: "Harry Potter"), Student(name: "Hermoine Granger")]
    
    var body: some View {
        List(students, id: \.self) { student in
            Text(student.name)
        }
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
