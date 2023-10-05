    /* Initially Modified: 05:11 AM Thu 05 Oct 2023
       Imported: 5:55 AM Thu 05 Oct 2023
    */
    
    import Foundation
    import DecodableMacro
    
    @DecodableMacro
    fileprivate struct Recipe { // Initially Modified: 05:14 AM Thu 05 Oct 2023
        var language: String    // Initially Modified: 05:15 AM Thu 05 Oct 2023
        var text: String        // Initially Modified: 05:15 AM Thu 05 Oct 2023
    
        var arguments: [String] // Initially Modified: 05:15 AM Thu 05 Oct 2023
        //var arguments: [String]? // Initially Modified: 05:15 AM Thu 05 Oct 2023
    
        init() {
            self.language = ""
            self.text = ""
            self.arguments = []
        }
    }
    
    fileprivate let data: Data =
    """
    {
        "language":  "Swift",
        "text":      "print(\\"Hello from a macro!\\")",
        "arguments": [
            "--repeat",
            "10"
        ]
    }
    """.data(using: .utf8)!
    
    fileprivate let recipe: Recipe = try! JSONDecoder().decode(Recipe.self, from: data)
    print(recipe.language)
    print(recipe.text)
    print(recipe.arguments)