/// SOURCE:
/// https://www.hackingwithswift.com/books/ios-swiftui/word-scramble-wrap-up

import SwiftUI



struct ChallengeView: View {
    
    // MARK: - PROPERTY WRAPPERS
    @State private var rootWord: String = ""
    @State private var createdWord: String = ""
    @State private var createdWords = Array<String>()
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var isShowingAlert: Bool = false
    
    
    
    // MARK: - PROPERTIES
    // MARK: - INITIALIZERS
    // MARK: - COMPUTED PROPERTIES
    var customAlertMessage: String {
        
        if createdWords.contains(createdWord) {
            alertMessage = "The word is already in your list."
        } else if createdWord.count < 3 {
            alertMessage = "The word is too short."
        } else if createdWord == rootWord {
            alertMessage = "You cannot use the challenge word."
        }
        
        return alertMessage
    }
    
    
    var body: some View {
        
        NavigationView {
            List {
                Section {
                    TextField("My word is...",
                              text: $createdWord)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onSubmit(addWordToList)
                }
                Section {
                    ForEach(createdWords,
                            id: \.self) { (eachCreatedWord: String) in
                        HStack {
                            Image(systemName: "\(eachCreatedWord.count).circle")
                                .font(.title)
                            Text(eachCreatedWord)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button("New Word", action: displayNewWord)
            }
            .onAppear(perform: loadListOfWords)
            .alert(alertTitle,
                   isPresented: $isShowingAlert) {
                Button("Cancel", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    
    
    // MARK: - METHODS
    func addWordToList()
    -> Void {
        
        let newWord = createdWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard newWord.count != 0
        else { return }
        
        guard checkOriginality(of: newWord)
        else {
            alertTitle = "Not Original"
            alertMessage = customAlertMessage
            isShowingAlert.toggle()
            return
        }
        
        guard checkValidity(of: newWord)
        else {
            alertTitle = "Not Valid"
            alertMessage = "Check the spelling of the word."
            isShowingAlert.toggle()
            return
        }
        
        guard checkLegitimacy(of: newWord)
        else {
            alertTitle = "Not Legitimate"
            alertMessage = "Make sure the word matches the letters."
            isShowingAlert.toggle()
            return
        }
        
        createdWords.insert(newWord, at: 0)
        createdWord = ""
    }
    
    
    func loadListOfWords()
    -> Void {
        
        if let _startTextURL = Bundle.main.url(forResource: "start",
                                               withExtension: "txt") {
            if let _startTextContent = try? String(contentsOf: _startTextURL) {
                let wordsArray = _startTextContent.components(separatedBy: .newlines)
                rootWord = wordsArray.randomElement() ?? "rosebud"
                return
            }
        }
    }
    
    
    func checkOriginality(of word: String)
    -> Bool {
        
        let isNotInYourList = !createdWords.contains(word)
        let isNotTooShort = word.count > 3
        let isNotTheSame = word != rootWord
        
        return isNotInYourList && isNotTooShort && isNotTheSame
    }
    
    
    func checkValidity(of word: String)
    -> Bool {
        
        let uiTextChecker = UITextChecker.init()
        let nsRange = NSRange(location: 0,
                              length: word.utf16.count)
        let misspelledWord = uiTextChecker.rangeOfMisspelledWord(in: word,
                                                                 range: nsRange,
                                                                 startingAt: 0,
                                                                 wrap: false,
                                                                 language: "en")
        return misspelledWord.location == NSNotFound
    }
    
    
    func checkLegitimacy(of word: String)
    -> Bool {
        
        var temporaryWord = rootWord
        
        for eachLetter in word {
            if let _eachLetter = temporaryWord.firstIndex(of: eachLetter) {
                temporaryWord.remove(at: _eachLetter)
                return true
            } else {
                return false
            }
        }
        return true
    }
    
    
    func displayNewWord()
    -> Void {
        
        loadListOfWords()
    }
    
    
    // MARK: - HELPER METHODS
}





// MARK: - PREVIEWS

struct ChallengeView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ChallengeView()
    }
}
