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
CBNautilusRefactoringChangesTest class >> metaMethodForTest [
	"do not delete me, I am used in #testMetaMethodNotChanged"
]

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
CBNautilusRefactoringChangesTest >> testAddMetaVarOnNewClassChanged [

	| cls change |
	cls := CBClass name: 'NonExistentGeneratedClassForChangesTest' parent: 'Object' package: 'GeneratedCode'.
	cls addMetaInstVarNamed: 'metaVar1'.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges last.
	self assert: change oldVersionTextToDisplay equals: ''.
	self assert: (CBChangeSet new addClass: cls) refactoringChanges size equals: 2
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testChangesBrowserAcceptAbortsWhenNotOkToChange [

	| browser |
	browser := CBChangesBrowser changes: #(  ).
	browser stub okToChange willReturn: false.
	browser open.
	[
		self assert: browser window isOpen description: 'CBChangesBrowser should open a window'.
		browser accept.
		self assert: browser window isOpen description: 'CBChangesBrowser>>#accept should keep window open when okToChange is false' ]
		ensure: [ browser window close ]
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testChangesBrowserAcceptAndBuildDiffFor [

	| cls change browser |
	cls := self newSelfCBClass.
	cls
		compile: 'methodForTest
	"do not delete me, I am used in #testMethodNotChanged"'
		classified: 'not support'.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges last.
	browser := CBChangesBrowser changes: #(  ).
	self assert: (browser buildDiffFor: nil) equals: ''.
	browser buildDiffFor: change.
	browser open.
	[
		self assert: browser window isOpen description: 'CBChangesBrowser should open a window'.
		browser accept.
		self deny: browser window isOpen description: 'CBChangesBrowser>>#accept should close its window' ] ensure: [
		browser window close ]
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
CBNautilusRefactoringChangesTest >> testCommentOnCommentedClassChanged [

	| cls change |
	cls := CBClass fromClass: CBAddClassPrintAdaptor.
	cls comment: 'Updated comment'.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges last.
	self assert: change textToDisplay equals: 'Updated comment'.
	self assert: change oldVersionTextToDisplay equals: CBAddClassPrintAdaptor comment.
	self assert: (CBChangeSet new addClass: cls) refactoringChanges size equals: 1
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testCommentOnCommentedClassNotChanged [

	| cls change |
	cls := CBClass fromClass: CBAddClassPrintAdaptor.
	cls comment: CBAddClassPrintAdaptor comment.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges last.
	self assert: change textToDisplay equals: CBAddClassPrintAdaptor comment.
	self assert: change oldVersionTextToDisplay equals: CBAddClassPrintAdaptor comment.
	self assertEmpty: (CBChangeSet new addClass: cls) refactoringChanges
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testCommentOnNewClassChanged [

	| cls change |
	cls := CBClass name: 'NonExistentGeneratedClassForChangesTest' parent: 'Object' package: 'GeneratedCode'.
	cls comment: 'Fresh comment'.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges second.
	self assert: change textToDisplay equals: 'Fresh comment'.
	self assert: change oldVersionTextToDisplay equals: ''.
	self assert: (CBChangeSet new addClass: cls) refactoringChanges size equals: 2
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testCommentOnUncommentedClassChanged [

	| cls change |
	cls := self newSelfCBClass.
	cls comment: 'Added comment'.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges last.
	self assert: change textToDisplay equals: 'Added comment'.
	self assert: change oldVersionTextToDisplay equals: ''.
	self assert: (CBChangeSet new addClass: cls) refactoringChanges size equals: 1
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testExample [

	| browser |
	browser := CBChangeSet example.
	[
		self assert: (browser isKindOf: CBChangesBrowser) description: 'CBChangeSet example should return a CBChangesBrowser'.
		self assert: browser window isOpen description: 'CBChangeSet example should open a window' ] ensure: [ browser window close ]
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testMetaMethodChanged [

	| cls change |
	cls := self newSelfCBClass.
	cls
		compileMeta: 'metaMethodForTest
	"do not delete me, I am used in #testMetaMethodNotChanged"'
		classified: 'not support'.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges last.
	self deny: change cbTextToDisplay equals: change cbOldVersionTextToDisplay.
	self assert: (CBChangeSet new addClass: cls) refactoringChanges size equals: 1
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testMetaMethodNotChanged [

	| cls change |
	cls := self newSelfCBClass.
	cls
		compileMeta: 'metaMethodForTest
	"do not delete me, I am used in #testMetaMethodNotChanged"'
		classified: 'support'.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges last.
	self assert: change cbTextToDisplay equals: change cbOldVersionTextToDisplay.
	self assertEmpty: (CBChangeSet new addClass: cls) refactoringChanges
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
	self deny: change cbTextToDisplay equals: change cbOldVersionTextToDisplay.
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
	self assert: change cbTextToDisplay equals: change cbOldVersionTextToDisplay.
	self assertEmpty: (CBChangeSet new addClass: cls) refactoringChanges
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testNewMethodOnExistingClassChanged [

	| cls change |
	cls := self newSelfCBClass.
	cls compile: 'brandNewNonExistentMethodForTest ^ 42' classified: 'accessing'.
	change := (CBChangeSet new addClass: cls) allRefactoringChanges last.
	self assert: change cbOldVersionTextToDisplay equals: ''.
	self deny: change cbTextToDisplay equals: change cbOldVersionTextToDisplay.
	self assert: (CBChangeSet new addClass: cls) refactoringChanges size equals: 1
]

{ #category : 'tests' }
CBNautilusRefactoringChangesTest >> testReMethodProtocolChangePreservesMethodSourceWithoutProtocolComment [

	| change expectedSource expectedOldDiff expectedNewDiff |
	change := ReMethodProtocolChange selector: #methodForTest in: self class classified: 'other'.
	expectedSource := (self class >> #methodForTest) sourceCode.
	expectedOldDiff := String streamContents: [ :stream |
			                   stream << '"protocol: support"'.
			                   stream cr.
			                   stream << expectedSource ].
	expectedNewDiff := String streamContents: [ :stream |
			                   stream << '"protocol: other"'.
			                   stream cr.
			                   stream << expectedSource ].
	self assert: change source equals: expectedSource.
	self assert: change oldVersionTextToDisplay equals: expectedOldDiff.
	self assert: change textToDisplay equals: expectedNewDiff
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
