Class {
	#name : 'CBSyntaxErrorTest',
	#superclass : 'TestCase',
	#category : 'ChangesBuilder-Tests-Model',
	#package : 'ChangesBuilder-Tests',
	#tag : 'Model'
}

{ #category : 'tests' }
CBSyntaxErrorTest >> testFromSyntaxErrorNotification [

	| error codeError |
	codeError := OCCodeError new notice: (OCNotice new
			              messageText: 'message';
			              node: (OCVariableNode new
					               name: ':';
					               start: 8;
					               parent: (OCMethodNode new source: 'code:x :'))).
	error := CBSyntaxError fromCodeError: codeError.

	self assert: error errorCode equals: 'code:x :'.
	self assert: error location equals: 8.
	self assert: error messageText equals: 'message'
]

{ #category : 'tests' }
CBSyntaxErrorTest >> testStyledErrorMessage [
	| error  |
	error := CBSyntaxError new setCode: 'code' location: 1 errorMessage: 'reason'.
	self
		assert: error styledErrorMessage
		equals: ('reason -> ' asText allBold makeAllColor: Color red) , 'code'
]
