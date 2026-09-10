Extension { #name : 'ReAddMethodChange' }

{ #category : '*ChangesBuilder' }
ReAddMethodChange >> oldVersionTextToDisplay [

	| class |
	class := Smalltalk
		         at: className asSymbol
		         ifAbsent: [ ^ super oldVersionTextToDisplay ].
	isMeta ifTrue: [ class := class classSide ].
	^ class methodDict
		  at: self selector
		  ifPresent: [ :method |
			  '"' , method protocolName , '"' , String cr , method sourceCode ]
		  ifAbsent: [ super oldVersionTextToDisplay ]
]

{ #category : '*ChangesBuilder' }
ReAddMethodChange >> textToDisplay [
	^ '"' , self protocol , '"' , String cr , self source
]
