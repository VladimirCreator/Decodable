    /* Initially Modified: 05:32 AM Thu 05 Oct 2023
       Imported: 06:00 AM Thu 05 Oct 2023
    */
    
    // The Swift Programming Language
    // https://docs.swift.org/swift-book
    
    @attached(                 // Initially Modified: 05:27 AM Thu 05 Oct 2023 (1)
        member,                // Initially Modified: 05:27 AM Thu 05 Oct 2023 (1)
        names: named(`init`),  // Initially Modified: 05:30 AM Thu 05 Oct 2023
               named(JSONKeys) // Initially Modified: 10:01 AM Thu 05 Oct 2023
    )
    @attached(
        extension,              // Initially Modified: 06:55 AM Thu 05 Oct 2023 (0)
        //names: arbitrary      // Initially Modified: 10:02 AM Thu 05 Oct 2023
        conformances: Decodable // Initially Modified: 10:10 AM Thu 05 Oct 2023
    )
    //@attached(conformance)     // Initially Modified: 05:27 AM Thu 05 Oct 2023 (0)
    public macro DecodableMacro() = // Initially Modified: 05:18 AM Thu 05 Oct 2023
        #externalMacro(module: "DecodableMacros", type: "DecodableMacro")