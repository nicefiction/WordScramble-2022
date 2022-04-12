/// SOURCE 1:
/// https://www.hackingwithswift.com/books/ios-swiftui/adding-to-a-list-of-words
/// SOURCE 2:
///

import SwiftUI



struct ContentView: View {
    
    // MARK: - PROPERTY WRAPPERS
    @State private var newWord: String = ""
    @State private var rootWord: String = ""
    @State private var usedWords = Array<String>()
    
    
    
    // MARK: - PROPERTIES
    // MARK: - INITIALIZERS
    // MARK: - COMPUTED PROPERTIES
    var body: some View {
        
        NavigationView {
            List {
                Section {
                    TextField("Your word...",
                              text: $newWord)
                    .autocapitalization(.none)
                    .onSubmit(addNewWord)
                }
                Section {
                    ForEach(usedWords,
                            id: \.self) { (usedWord: String) in
                        HStack {
                            Image(systemName: "\(usedWord.count).circle")
                                .font(.title)
                            Text(usedWord)
                        }
                    }
                }
            }
            .navigationTitle(Text(rootWord))
        }
    }
    
    
    
    // MARK: - METHODS
    
    func addNewWord()
    -> Void {
        
        let createdWord = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        /// Exit if the word is empty:
        guard createdWord.count > 0
        else {return }
        
        // extra validation to come...
        
        withAnimation {
            usedWords.insert(createdWord, at: 0)
        }
        newWord = ""
    }
    
    

    // MARK: - HELPER METHODS
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
