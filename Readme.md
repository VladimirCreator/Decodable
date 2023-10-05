# Decodable

## Table of Contents
- [About](#about)
- [Usage](#usage)
    - [Traditional](#the-swift-package-manager)
    - [The Swift Package Manager](#the-swift-package-manager)
- [Example](#example)

## About
Let’s say you have these structures:

```swift
internal struct Recipe {
    var (language, text): (String, String)
    var arguments: [String]?
}
```

```swift
internal struct User {
    var firstName: String
    var lastName: String
    var age: Int

    var recipes: [Recipe]
}
```

And you have responses from a server that look something like these:

```json
{
    "language": "Swift",
    "text": "print(42)",
    "arguments": [
        "--repeat",
        "10"
    ]
}
```

```json
{
    "firstName": "Vladimir",
    "lastName": ":)",
    "age": 20,
    "recipes": [
        {
            "language": "Swift",
            "text": "print(42)",
             "arguments": [
                "--repeat",
                "10"
            ]
        }
    ]
}
```

Of course, you know what to do:

```swift
internal struct Recipe {
    var (language, text): (String, String)
    var arguments: [String]?
}

internal extension Recipe: Decodable {
    private enum JSONKeys: String, CodingKey {
        case language, text
        case arguments
    }

    internal init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: JSONKeys.self)
        guard let language = try? container.decode(String.self, forKey: .language),
              let text = try? container.decode(String.self, forKey: .text),
              let arguments = try? container.decode([String].self, forKey: . arguments)
        else {
            throw 
        }
        self.language = language
        self.text = text
        self.arguments = arguments
    }
}
```

```swift
internal struct User {
    var firstName: String
    var lastName: String
    var age: Int

    var recipes: [Recipe]
}

internal extension User: Decodable {
    private enum JSONKeys: String, CodingKey {
        case firstName, lastName
        case age
        case recipes
    }

    internal init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: JSONKeys.self)
        guard let firstName = try? container.decode(String.self, forKey: . firstName),
              let lastName = try? container.decode(String.self, forKey: . lastName),
              let age = try? container.decode(Int.self, forKey: . age),
              let recipes = try? container.decode([Recipe].self, forKey: . recipes),
        else {
            throw 
        }
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.recipes = recipes
    }
}
```

Finally! So much typings. Wouldn’t it be great if you could do that:

```swift
@Decodable
internal struct Recipe {
    var (language, text): (String, String)
    var arguments: [String]?
}

@Decodable
internal struct User {
    var firstName: String
    var lastName: String
    var age: Int

    var recipes: [Recipe]
}
```

Just 2 lines of code!

## Usage
### Traditional
...

### The Swift Package Manager
...

## Example
```swift
@Decodable
internal struct User {
    internal firstName: String
    internal lastName: String
}
```
