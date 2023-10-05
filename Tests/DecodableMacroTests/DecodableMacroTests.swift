    //import SwiftSyntaxMacros
    //import SwiftSyntaxMacrosTestSupport
    //import XCTest
    //
    //// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
    //#if canImport(DecodableMacro)
    //import DecodableMacro
    //
    //let testMacros: [String: Macro.Type] = [
    //    "DecodableMacro": DecodableMacro.self,
    //]
    //#endif
    //
    //final class DecodableMacroTests: XCTestCase {
    //    func testMacro() throws { // Last Modified: 08:38 AM Thu 05 Oct 2023
    //        #if canImport(DecodableMacro)
    //        assertMacroExpansion(
    //            """
    //            @DecodableMacro
    //            fileprivate struct Point {
    //                var x: Int
    //                var y: Int
    //            }
    //            """,
    //            expandedSource: """
    //            fileprivate struct Point {
    //                var x: Int
    //                var y: Int
    //            }
    //            """,
    //            macros: testMacros
    //        )
    //        #else
    //        throw XCTSkip("macros are only supported when running tests for the host platform")
    //        #endif
    //    }
    //}