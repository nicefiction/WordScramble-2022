/// SOURCE;
/// https://www.hackingwithswift.com/books/ios-swiftui/introducing-list-your-best-friend

import SwiftUI



struct IntroducingList: View {
    
    // MARK: - PROPERTY WRAPPERS
    // MARK: - PROPERTIES
    let humans: Array<String> = [
        "Dorothy", "Glinda", "Ozma", "Olivia"
    ]
    
    
    
    // MARK: - INITIALIZERS
    // MARK: - COMPUTED PROPERTIES
    var body: some View {
        
        List {
            Text("Static Row")
            Text("Static Row")
            Text("Static Row")
            ForEach(0..<5) {
                Text("Dynamic Row \($0)")
            }
        }
        .listStyle(.grouped)
        
        List(0..<5) {
            Text("Dynamic Row \($0)")
        }
        .listStyle(.inset)
        
        List(humans,
             id: \.self) {
            Text($0)
        }
        .listStyle(.sidebar)
        
        List {
            Text("Static Row")
            Section("Dynamic") {
                ForEach(humans,
                        id: \.self) {
                    Text($0)
                }
            }
            Text("Static Row")
            Text("Static Row")
            Section("Dynamic") {
                ForEach(0..<5) {
                    Text("Dynamic Row \($0)")
                }
            }
        }
        .listStyle(.grouped)
    }
    
    
    
    // MARK: - METHODS
    // MARK: - HELPER METHODS
}





// MARK: - PREVIEWS

struct IntroducingList_Previews: PreviewProvider {
    
    static var previews: some View {
        
        IntroducingList()
    }
}
