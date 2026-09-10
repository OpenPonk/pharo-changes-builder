Extension { #name : 'ReCommentChange' }

{ #category : '*ChangesBuilder' }
ReCommentChange >> oldVersionTextToDisplay [
	| cls |
	(Smalltalk hasClassNamed: className)
		ifFalse: [ ^ '' ].
	cls := Smalltalk classNamed: className.
	^ cls hasComment
		ifTrue: [ cls comment ]
		ifFalse: [ '' ]
]

{ #category : '*ChangesBuilder' }
ReCommentChange >> textToDisplay [
	^ self comment
]
