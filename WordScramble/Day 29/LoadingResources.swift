/// SOURCE:
/// https://www.hackingwithswift.com/books/ios-swiftui/loading-resources-from-your-app-bundle

import SwiftUI



struct LoadingResources: View {
    
    // MARK: - PROPERTY WRAPPERS
    // MARK: - PROPERTIES
    // MARK: - INITIALIZERS
    // MARK: - COMPUTED PROPERTIES
    var body: some View {
        
        Text("Hello, world!")
            .padding()
    }
    
    
    
    // MARK: - METHODS
    func loadFile()
    -> Void {
        
        /// To read the URL for a file in our main app bundle:
        if let _fileURL = Bundle.main.url(forResource: "someFile",
                                       withExtension: "txt") {
            /// Once we have a URL,
            /// we can load it into a string with a special initializer:
            if let _fileContent = try? String(contentsOf: _fileURL) {
                print(_fileContent)
            }
        }
    }
    
    
    
    // MARK: - HELPER METHODS
}





// MARK: - PREVIEWS
struct LoadingResources_Previews: PreviewProvider {
    
    static var previews: some View {
        
        LoadingResources()
    }
}
