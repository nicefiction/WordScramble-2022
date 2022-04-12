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
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var isShowingAlert: Bool = false
    
    
    
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
            .alert(alertTitle,
                   isPresented: $isShowingAlert) {
                Button("Cancel", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
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
        guard checkOriginality(of: createdWord)
        else {
            alertTitle = "Looks familiar."
            alertMessage = "Your word has been created already."
            isShowingAlert.toggle()
            return
        }
        
        guard checkValidity(of: createdWord)
        else {
            alertTitle = "Looks weird."
            alertMessage = "Please enter a valid word."
            isShowingAlert.toggle()
            return
        }
        
        guard checkLegitimacy(of: createdWord)
        else {
            alertTitle = "Looks a bit off."
            alertMessage = "Please enter a legitimate word."
            isShowingAlert.toggle()
            return
        }
        
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
    
    
    func checkOriginality(of word: String)
    -> Bool {
        
        return !usedWords.contains(word)
    }
    
    
    func checkValidity(of word: String)
    -> Bool {
        
        let uiTextChecker = UITextChecker.init()
        let nsRange = NSRange(location: 0, length: word.utf16.count)
        let rangeOfMisspelledWords = uiTextChecker.rangeOfMisspelledWord(in: word,
                                                                         range: nsRange,
                                                                         startingAt: 0,
                                                                         wrap: false,
                                                                         language: "en")
        
        return rangeOfMisspelledWords.location == NSNotFound
    }
    /*
     func isPossible(word: String) -> Bool {
         var tempWord = rootWord

         for letter in word {
             if let pos = tempWord.firstIndex(of: letter) {
                 tempWord.remove(at: pos)
             } else {
                 return false
             }
         }

         return true
     }
     */
    
    func checkLegitimacy(of word: String)
    -> Bool {
        
        var temporaryWord = rootWord
        
        for eachLetter in word {
            if let _eachLetter = temporaryWord.firstIndex(of: eachLetter) {
                temporaryWord.remove(at: _eachLetter)
            } else {
                return false
            }
        }
        return true
    }
    

    
    // MARK: - HELPER METHODS
}






// MARK: - PREVIEWS

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
    }
}
