Extension { #name : 'ReAddMethodChange' }

{ #category : '*ChangesBuilder' }
ReAddMethodChange >> cbOldVersionTextToDisplay [

	| class |
	class := Smalltalk at: className asSymbol ifAbsent: [ ^ '' ].
	isMeta ifTrue: [ class := class classSide ].
	^ class
		  compiledMethodAt: self selector
		  ifPresent: [ :method |
				  String streamContents: [ :stream |
						  stream << '"'.
						  stream << method protocolName.
						  stream << '"'.
						  stream cr.
						  stream << method sourceCode ] ]
		  ifAbsent: [ '' ]
]

{ #category : '*ChangesBuilder' }
ReAddMethodChange >> cbTextToDisplay [

	^ String streamContents: [ :stream |
			  stream << '"'.
			  stream << self protocol.
			  stream << '"'.
			  stream cr.
			  stream << self source ]
]
