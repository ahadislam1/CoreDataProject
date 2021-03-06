//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Ahad Islam on 5/6/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import SwiftUI
import CoreData

/**
 \.self means the whole object.
 It means if we can conform hashable to our models then it'll value itself as struct.
 
 CoreData also creates sequential object identifiers so it doesn't break when objects have identical properties.
 
 NSManaged is not property wrappers.
 
 Always check if changes needed to be saved. ManagedObjectContext has a property just for that.
 
 Example:
 if self.moc.hasChanges {
    try? self.moc.save()
 
 NSPredicate is a super strong filter
 BEGINSWITH
 CONTAINS
 AND
 ==
 >
 <
 IN
 NOT
 super usefull I'll definite take a look at it.
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

struct WizardView: View {
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

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>
    
    var body: some View {
        VStack {
            List(ships, id: \.self) {
                Text($0.name ?? "Unknown name")
            }
            
            Button("Add Examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: self.moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
                
                try? self.moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
