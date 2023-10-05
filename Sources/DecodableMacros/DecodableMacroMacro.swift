    /* Initially Modified: 05:32 AM Thu 05 Oct 2023
            Last Modified: 11:06 AM Thu 05 Oct 2023
       Imported: 06:00 AM Thu 05 Oct 2023
    */
    
    import SwiftCompilerPlugin
    import SwiftSyntax
    import SwiftSyntaxBuilder
    import SwiftSyntaxMacros
    
    public struct DecodableMacro: MemberMacro {
        public static func expansion(
            of attribute: AttributeSyntax,
            providingMembersOf declaration: some DeclGroupSyntax,
            in context: some MacroExpansionContext
        ) throws -> [DeclSyntax] {
            guard let declaration = declaration.as(StructDeclSyntax.self) else {
                return []
            }
    
            let cases = declaration.memberBlock.members.reduce("") {
                guard let variable = $1.decl.as(VariableDeclSyntax.self)?.bindings.first?.pattern.as(IdentifierPatternSyntax.self)?.identifier.text else {
                    return $0
                }
                return $0 + "case \(variable)\n"
            }
    
            let `enum`: DeclSyntax = """
            private enum JSONKeys: String, CodingKey {
                \(raw: cases)
            }
            """
    
            return [
                `enum`
            ]
        }
    }
    
    extension DecodableMacro: ExtensionMacro {
        public static func expansion(
            of attribute: AttributeSyntax,
            attachedTo declaration: some DeclGroupSyntax,
            providingExtensionsOf type: some TypeSyntaxProtocol,
            conformingTo protocols: [TypeSyntax],
            in context: some MacroExpansionContext
        ) throws -> [ExtensionDeclSyntax] {
            guard let declaration = declaration.as(StructDeclSyntax.self) else {
                return []
            }
    
            let variables = declaration.memberBlock.members.compactMap {
                if  let binding = $0.decl.as(VariableDeclSyntax.self)?.bindings.first {
                    let name = binding.pattern.as(IdentifierPatternSyntax.self)!.identifier.text
                    let type = binding.typeAnnotation?.type.as(IdentifierTypeSyntax.self)?.name.text ?? ""
    
                    return (name: name, type: type)
                }
                return nil
            }
    
            let guardBlock = variables.reduce("") {
                $0 + " let " + $1.name + " = try? container.decode(" + $1.type + ".self, forKey: ." + $1.name + "),"
            }.dropLast()
            let initialization = variables.reduce("") {
                $0 + "self.\($1.name) = \($1.name)"
            }
    
            let `extension`: ExtensionDeclSyntax = try ExtensionDeclSyntax(
            """
            extension \(type): Decodable {
                internal init(from decoder: Decoder) throws {
                    let container = try decoder.container(keyedBy: JSONKeys.self)
    
                    guard \(raw: guardBlock)
                    else {
                        fatalError()
                    }
                    \(raw: initialization)
                }
            }
            """
            )
    
            return [
                try ExtensionDeclSyntax("extension \(type): Decodable {}")
                //`extension`
            ]
        }
    }
    
    @main
    struct DecodableMacroPlugin: CompilerPlugin {
        let providingMacros: [Macro.Type] = [
            DecodableMacro.self,
        ]
    }