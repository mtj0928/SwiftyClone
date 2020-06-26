import Foundation
import SwiftSyntax

open class SwiftyCloneCore {
    public static func exec() {
        let path = "/Users/matsumotojunnosuke/Documents/Private/Programing/Swift/iOS/kashika/app-ios/kashika/VIPER/Views/Components/Cells/TableView/WarikanFlowCell.swift"
        let url = URL(fileURLWithPath: path)
        let source = try! SyntaxParser.parse(url)
        let visitor = Visitor()
        visitor.walk(source)
    }
}
