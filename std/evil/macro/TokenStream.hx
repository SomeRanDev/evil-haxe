package evil.macro;

import haxe.macro.Expr;

/**
	Represents the structure provided to mods to parse the tokens.
**/
typedef TokenStream = {
	/**
		Get the current token of the stream.
	**/
	function peek(): evil.macro.Token;

	/**
		Discard the current token and move to the next one.
	**/
	function consume(): Void;

	/**
		Parse and return the next expression.
	**/
	function nextExpr(): Expr;

	/**
		Parses the content after an expression.
		This is stuff like infix operators (+ - *), dot access (.), call ( () ), etc.

		Use this to parse incomplete expressions or support post-expression features
		with mod's new expression syntax.
	**/
	function parsePostExpr(e: Expr): Expr;

	/**
		Parse and return the next complex type.
	**/
	function nextType(): { type: ComplexType, pos: Position };

	/**
		Parses the content after an type.
		This is stuff like the end of a function type (->) or the & op.
	**/
	function parsePostType(t: { type: ComplexType, pos: Position }): { type: ComplexType, pos: Position };

	/**
		Parses an indefinite number of class fields.
		This is usually called after consuming the "{" for a type declaration.

		`keywordPos` is the `Position` of the type declaration keyword token
		like "class" or "enum".
	**/
	function parseClassFields(keywordPos: Position): { fields: Array<Field>, pos: Position };

	/**
		Consume the next semicolon.
		Throws an error if it doesn't exist, UNLESS the previous token was `}`.
	**/
	function semicolon(): Position;

	/**
		Parses the content within a block expression AFTER the `{` token.
		Does not parse the ending `}` token.
	**/
	function parseBlockInternals(): Array<Expr>;

	/**
		Returns `true` if the compiler is currently parsing an expression immediately 
		after the `switch` keyword (but before the switch statement `{`).
	**/
	function isParsingSwitchExpr(): Bool;

	/**
		Combine two positions.
	**/
	function posUnion(p1: Position, p2: Position): Position;
}
