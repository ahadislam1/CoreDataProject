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
 
 NSManaged is not property wrappers.
 
 Always check if changes needed to be saved. ManagedObjectContext has a property just for that.
 
 Example:
 if self.moc.hasChanges {
    try? self.moc.save()
 }
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
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }
            
            Button("Add") {
                let wizard = Wizard(context: self.moc)
                wizard.name = "Harry Potter"
            }
            
            Button("Save") {
                do {
                    try self.moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
