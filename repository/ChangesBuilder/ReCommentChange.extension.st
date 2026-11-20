Extension { #name : 'ReCommentChange' }

{ #category : '*ChangesBuilder' }
ReCommentChange >> oldVersionTextToDisplay [

	^ Smalltalk at: className asSymbol ifPresent: [ :cls | cls comment ] ifAbsent: [ '' ]
]

{ #category : '*ChangesBuilder' }
ReCommentChange >> textToDisplay [
	^ self comment
]
