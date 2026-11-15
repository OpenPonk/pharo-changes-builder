Class {
	#name : 'CBNautilusRefactoringChangesTest',
	#superclass : 'TestCase',
	#classInstVars : [
		'metaVar1'
	],
	#category : 'ChangesBuilder-Tests-Model',
	#package : 'ChangesBuilder-Tests',
	#tag : 'Model'
}

{ #category : 'support' }
CBNautilusRefactoringChangesTest >> methodForTest [
	"do not delete me, I am used in #testMethodNotChanged"
]

{ #category : 'support' }
CBNautilusRefactoringChangesTest >> newSelfCBClass [

	^ CBClass new
		  name: self class name;
		  parent: self class superclass name;
		  package: self class packageName;
		  tag: (CBClass packageTagNameFor: self class);
		  yourself
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testAddMetaVarChanged [

	| cls change |
	cls := self newSelfCBClass.
	cls addMetaInstVarNamed: 'var1'.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges last.
	self deny: change textToDisplay equals: change oldVersionTextToDisplay.
	self denyEmpty: (CBChangeSet new addClass: cls) refactoringChanges
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testAddMetaVarNotChanged [

	| cls changes |
	cls := self newSelfCBClass.
	cls addMetaInstVarNamed: 'metaVar1'.
	changes := (CBChangeSet new addClass: cls) allRefactoringChanges.
	changes do: [ :change | self assert: change textToDisplay equals: change oldVersionTextToDisplay ].
	self assertEmpty: (CBChangeSet new addClass: cls) refactoringChanges
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testClassChanged [

	| cls change |
	cls := self newSelfCBClass.
	cls addInstVarNamed: 'var1'.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges first.
	self deny: change textToDisplay equals: change oldVersionTextToDisplay.
	self denyEmpty: (CBChangeSet new addClass: cls) refactoringChanges
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testClassNotChanged [

	| cls change |
	cls := self newSelfCBClass.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges first.
	self assert: change textToDisplay equals: change oldVersionTextToDisplay.
	self assertEmpty: (CBChangeSet new addClass: cls) refactoringChanges
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testExample [
	| window |
	window := CBChangeSet example.
	window delete.
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testMethodChanged [

	| cls change |
	cls := self newSelfCBClass.
	cls
		compile: 'methodForTest
	"do not delete me, I am used in #testMethodNotChanged"'
		classified: 'not support'.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges last.
	self deny: change textToDisplay equals: change oldVersionTextToDisplay.
	self assert: (CBChangeSet new addClass: cls) refactoringChanges size equals: 1
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testMethodNotChanged [

	| cls change |
	cls := self newSelfCBClass.
	cls
		compile: 'methodForTest
	"do not delete me, I am used in #testMethodNotChanged"'
		classified: 'support'.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges last.
	self assert: change textToDisplay equals: change oldVersionTextToDisplay.
	self assertEmpty: (CBChangeSet new addClass: cls) refactoringChanges
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testRootTagClassNotChanged [

	| cls change |
	cls := CBClass
		       name: BaselineOfChangesBuilder name
		       parent: BaselineOfChangesBuilder superclass name
		       package: BaselineOfChangesBuilder packageName.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges first.
	self assert: change textToDisplay equals: change oldVersionTextToDisplay.
	self assertEmpty: (CBChangeSet new addClass: cls) refactoringChanges
]
