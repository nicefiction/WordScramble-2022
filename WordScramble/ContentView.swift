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
            .onAppear(perform: startGame)
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
    
    
    func startGame()
    -> Void {
        /// `STEP 1`. Find the URL for `start.txt` in our app bundle:
        if let _startTextURL = Bundle.main.url(forResource: "start",
                                               withExtension: "txt") {
            /// `STEP 2`. Load `start.txt` into a string:
            if let _contentsOfFile = try? String(contentsOf: _startTextURL) {
                /// `STEP 3`. Split the string up into an array of strings, splitting on line breaks:
                let allwords = _contentsOfFile.components(separatedBy: "\n")
                /// `STEP 4`. Pick one random word, or use `"rosebud"` as a sensible default
                rootWord = allwords.randomElement() ?? "rosebud"
                ///`STEP 5`. If we are here everything has worked, so we can exit
                return
            }
        }
        /// `STEP 6`.If were are *here* then there was a problem
        /// — trigger a crash and report the error:
        fatalError("Could not load start.txt from bundle.")
    }
    
    

    // MARK: - HELPER METHODS
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
