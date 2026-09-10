Extension { #name : 'ReAddClassChange' }

{ #category : '*ChangesBuilder' }
ReAddClassChange >> oldVersionTextToDisplay [

	^ Smalltalk
		  at: className
		  ifPresent: [ :existingClass | existingClass definitionString ]
		  ifAbsent: [ '' ]
]

{ #category : '*ChangesBuilder' }
ReAddClassChange >> textToDisplay [

	^ (ClassDefinitionPrinter for: (CBAddClassPrintAdaptor for: self))
		  classDefinitionString
]
