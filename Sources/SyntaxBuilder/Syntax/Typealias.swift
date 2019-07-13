import SwiftSyntax

public struct Typealias: DeclBuildable {
    let name: String
    let type: String

    public init(_ name: String, type: String) {
        self.name = name
        self.type = type
    }

    public init<T>(_ name: String, of type: T.Type) {
        self.name = name
        self.type = String(describing: type)
    }

    public func buildDecl(format: Format, leadingTrivia: Trivia?) -> DeclSyntax {
        let keyword = SyntaxFactory.makeTypealiasKeyword(
            leadingTrivia: leadingTrivia ?? .zero,
            trailingTrivia: .spaces(1)
        )

        let identifier = SyntaxFactory.makeIdentifier(name)

        let initializer = SyntaxFactory.makeTypeInitializerClause(
            equal: SyntaxFactory.makeEqualToken(leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
            value: SyntaxFactory.makeTypeIdentifier(type)
        )

        return SyntaxFactory.makeTypealiasDecl(
            attributes: nil,
            modifiers: nil,
            typealiasKeyword: keyword,
            identifier: identifier,
            genericParameterClause: nil,
            initializer: initializer,
            genericWhereClause: nil
        )
    }
}