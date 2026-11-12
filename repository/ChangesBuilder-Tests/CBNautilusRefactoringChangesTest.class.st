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

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testAddMetaVarChanged [
	| cls change |
	cls := CBClass new
		name: #CBNautilusRefactoringChangesTest;
		parent: #TestCase.
	cls addMetaInstVarNamed: 'var1'.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges last.
	self deny: change textToDisplay = change oldVersionTextToDisplay.
	self assert: (CBChangeSet new addClass: cls) refactoringChanges isNotEmpty
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testAddMetaVarNotChanged [

	| cls changes |
	cls := CBClass new
		       name: #CBNautilusRefactoringChangesTest;
		       parent: #TestCase;
		       package: 'ChangesBuilder';
		       tag: 'Tests'.
	cls addMetaInstVarNamed: 'metaVar1'.
	changes := (CBChangeSet new addClass: cls) allRefactoringChanges.
	changes do: [ :change |
			self
				assert: change textToDisplay
				equals: change oldVersionTextToDisplay ].
	self
		assertCollection: (CBChangeSet new addClass: cls) refactoringChanges
		hasSameElements: #(  )
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testClassChanged [
	| cls change |
	cls := CBClass new
		name: #CBNautilusRefactoringChangesTest;
		parent: #TestCase.
	cls addInstVarNamed: 'var1'.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges first.
	self deny: change textToDisplay = change oldVersionTextToDisplay.
	self assert: (CBChangeSet new addClass: cls) refactoringChanges isNotEmpty
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testClassNotChanged [

	| cls change |
	cls := CBClass new
		       name: #CBNautilusRefactoringChangesTest;
		       parent: #TestCase;
		       package: 'ChangesBuilder';
		       tag: 'Tests'.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges first.
	self
		assert: change textToDisplay
		equals: change oldVersionTextToDisplay.
	self assert:
		(CBChangeSet new addClass: cls) refactoringChanges isEmpty
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
	cls := CBClass new name: self class name.
	cls compile: 'methodForTest
	"do not delete me, I am used in #testMethodNotChanged"' classified: 'not support'.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges last.
	self deny: change textToDisplay = change oldVersionTextToDisplay.
	self assert: (CBChangeSet new addClass: cls) refactoringChanges size equals: 2
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testMethodNotChanged [
	| cls change |
	cls := CBClass new name: self class name.
	cls compile: 'methodForTest
	"do not delete me, I am used in #testMethodNotChanged"' classified: 'support'.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges last.
	self assert: change textToDisplay equals: change oldVersionTextToDisplay.
	self assert: (CBChangeSet new addClass: cls) refactoringChanges size equals: 1
]
