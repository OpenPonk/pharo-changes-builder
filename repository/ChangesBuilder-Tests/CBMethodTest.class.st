Class {
	#name : 'CBMethodTest',
	#superclass : 'TestCase',
	#instVars : [
		'method'
	],
	#category : 'ChangesBuilder-Tests-Model',
	#package : 'ChangesBuilder-Tests',
	#tag : 'Model'
}

{ #category : 'asserting' }
CBMethodTest >> assertMethod: actualCode equals: expectedCode [
	self
		assert: (OCParser parseMethod: actualCode) formattedCode
		equals: (OCParser parseMethod: expectedCode) formattedCode
]

{ #category : 'tests' }
CBMethodTest >> testAsArgumentName [
	method := CBMethod basicNew.
	self assert: (method asArgumentName: 'dog') equals: 'aDog'.
	self assert: (method asArgumentName: 'old') equals: 'anOld'
]

{ #category : 'tests' }
CBMethodTest >> testAsComment [
	method := CBMethod new.
	self assert: (method asComment: 'text') equals: 'text'.
	self assert: (method asComment: 't"e"xt') equals: 't""e""xt'.
]

{ #category : 'tests' }
CBMethodTest >> testGetter [

	method := CBMethod new getter: 'var'.
	self assertMethod: method source equals: 'var
	^ var'.
	self assert: method protocolName equals: 'accessing'
]

{ #category : 'tests' }
CBMethodTest >> testGetterDelegateFrom [

	method := CBMethod new getter: 'var' delegateFrom: 'target'.
	self assertMethod: method source equals: 'var
	^ target var'.
	self assert: method protocolName equals: 'accessing'
]

{ #category : 'tests' }
CBMethodTest >> testGetterWithComment [

	method := CBMethod new getter: 'var' comment: 'comment'.
	self assertMethod: method source equals: 'var
	"comment"
	^ var'.
	self assert: method protocolName equals: 'accessing'
]

{ #category : 'tests' }
CBMethodTest >> testGetterWithCommentDefaultValue [

	method := CBMethod new
		          getter: 'var'
		          comment: 'comment'
		          defaultValue: '12'.
	self assertMethod: method source equals: 'var
	"comment"
	^ var ifNil: [ var := 12 ]'.
	self assert: method protocolName equals: 'accessing'
]

{ #category : 'tests' }
CBMethodTest >> testGetterWithDefaultValue [

	method := CBMethod new getter: 'var' defaultValue: '12'.
	self assertMethod: method source equals: 'var
	^ var ifNil: [ var := 12 ]'.
	self assert: method protocolName equals: 'accessing'
]

{ #category : 'tests' }
CBMethodTest >> testGetterWithNilComment [

	method := CBMethod new getter: 'var' comment: nil.
	self assertMethod: method source equals: 'var
	^ var'.
	self assert: method protocolName equals: 'accessing'
]

{ #category : 'tests' }
CBMethodTest >> testGetterWithNilCommentDefaultValue [

	method := CBMethod new getter: 'var' comment: nil defaultValue: '12'.
	self assertMethod: method source equals: 'var
	^ var ifNil: [ var := 12 ]'.
	self assert: method protocolName equals: 'accessing'
]

{ #category : 'tests' }
CBMethodTest >> testSelector [
	method := CBMethod new source: 'a: aWhatever ^ nil'.
	self assert: method selector equals: #a:
]

{ #category : 'tests' }
CBMethodTest >> testSetter [

	method := CBMethod new setter: 'var' argument: 'variable'.
	self assertMethod: method source equals: 'var: aVariable
	var := aVariable'.
	self assert: method protocolName equals: 'accessing'
]

{ #category : 'tests' }
CBMethodTest >> testSetterDelegateTo [

	method := CBMethod new setter: 'var' argument: 'variable' delegateTo: 'target'.
	self assertMethod: method source equals: 'var: aVariable
	target var: aVariable'.
	self assert: method protocolName equals: 'accessing'
]

{ #category : 'tests' }
CBMethodTest >> testSetterDelegateToWithComment [

	| deprecated |
	deprecated := false.
	[
		method := CBMethod new
			          setter: 'var'
			          argument: 'variable'
			          delegateTo: 'target'
			          comment: 'hello' ]
		on: Deprecation
		do: [ :ex |
				deprecated := true.
				ex resume ].
	self deny: deprecated description: 'setter:argument:delegateTo:comment: should not trigger Deprecation'.
	self assertMethod: method source equals: 'var: aVariable
	"hello"
	target var: aVariable'.
	self assert: method protocolName equals: 'accessing'
]

{ #category : 'tests' }
CBMethodTest >> testSetterDelegateToWithNilComment [

	method := CBMethod new
		          setter: 'var'
		          argument: 'variable'
		          delegateTo: 'target'
		          comment: nil.
	self assertMethod: method source equals: 'var: aVariable
	target var: aVariable'.
	self assert: method protocolName equals: 'accessing'
]

{ #category : 'tests' }
CBMethodTest >> testSetterWithComment [

	method := CBMethod new
		          setter: 'var'
		          argument: 'variable'
		          comment: 'hello'.
	self assertMethod: method source equals: 'var: aVariable
	"hello"
	var := aVariable'.
	self assert: method protocolName equals: 'accessing'
]

{ #category : 'tests' }
CBMethodTest >> testSetterWithNilComment [

	method := CBMethod new setter: 'var' argument: 'variable' comment: nil.
	self assertMethod: method source equals: 'var: aVariable
	var := aVariable'.
	self assert: method protocolName equals: 'accessing'
]

{ #category : 'tests' }
CBMethodTest >> testValidateSource [

	method := CBMethod new.
	self assert: (method validateSource: 'a ^ 1') identicalTo: method
]

{ #category : 'tests' }
CBMethodTest >> testValidateSourceError [
	self should: [ CBMethod new validateSource: '^^' ] raise: CBSyntaxError
]
