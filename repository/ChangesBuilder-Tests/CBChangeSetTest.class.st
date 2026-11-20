Class {
	#name : 'CBChangeSetTest',
	#superclass : 'TestCase',
	#instVars : [
		'changeSet'
	],
	#category : 'ChangesBuilder-Tests-Model',
	#package : 'ChangesBuilder-Tests',
	#tag : 'Model'
}

{ #category : 'running' }
CBChangeSetTest >> setUp [
	super setUp.
	changeSet := CBChangeSet new
]

{ #category : 'tests' }
CBChangeSetTest >> testAddClass [
	| class |
	class := CBClass new name: 'GeneratedClass'.
	changeSet addClass: class.
	self assert: changeSet classes equals: {class}
]

{ #category : 'tests' }
CBChangeSetTest >> testAddClassChanges [

	| class builder |
	class := CBClass new name: 'GeneratedClass'.
	class addInstVarNamed: 'var1'.
	class addClassVarNamed: 'classVar1'.
	changeSet addClass: class.
	self assert: changeSet classes equals: { class }.
	builder := changeSet allRefactoringChanges first builder.
	self assert: builder superclassName equals: 'Object'.
	self assert: builder name equals: #GeneratedClass.
	self
		assertCollection: (builder slots collect: #name)
		equals: #( var1 ).
	self
		assertCollection: (builder sharedVariables collect: #name)
		equals: #( classVar1 ).
	self assert: builder package equals: 'Unclassified'.
	self assert: builder tag equals: ''
]

{ #category : 'tests' }
CBChangeSetTest >> testAddMetaClassChanges [
	| class |
	class := CBClass new name: 'GeneratedClass'.
	class addMetaInstVarNamed: 'metaVar1'.
	changeSet addClass: class.
	self assert: changeSet classes equals: {class}.
	self
		assert: changeSet allRefactoringChanges second textToDisplay withUnixLineEndings
		equals: 'Add instance variable metaVar1 to GeneratedClass class'
]

{ #category : 'tests' }
CBChangeSetTest >> testAllRefactoringChangesIncludesComment [

	| class commentChange |
	class := CBClass new
		         name: 'GeneratedClass';
		         comment: 'Generated class comment';
		         yourself.
	changeSet addClass: class.
	commentChange := changeSet allRefactoringChanges second.
	self assert: commentChange class equals: ReCommentChange.
	self assert: commentChange cbTextToDisplay equals: 'Generated class comment'
]

{ #category : 'tests' }
CBChangeSetTest >> testBrowseChangesIfAnyWhenEmptySignalsInformativeNotification [

	| message deprecated |
	message := nil.
	deprecated := false.
	[
		[ changeSet browseChangesIfAny ]
			on: InformativeNotification
			do: [ :notification | message := notification messageText ] ]
		on: Deprecation
		do: [ :ex |
				deprecated := true.
				ex resume ].
	self deny: deprecated description: 'browseChangesIfAny should not use deprecated Object>>#inform:'.
	self assert: message equals: 'No changes'
]

{ #category : 'tests' }
CBChangeSetTest >> testBrowseChangesIfAnyWhenNonEmptyOpensBrowserWindow [

	| class browser |
	class := CBClass new name: 'GeneratedBrowserTestClass'.
	changeSet addClass: class.
	browser := changeSet browseChangesIfAny.
	[
		self
			assert: (browser isKindOf: CBChangesBrowser)
			description: 'browseChangesIfAny should return a CBChangesBrowser when changes exist'.
		self assert: browser window isOpen description: 'browseChangesIfAny should open a browser window when changes exist' ] ensure: [
		browser window close ]
]

{ #category : 'tests' }
CBChangeSetTest >> testBrowseChangesOpensBrowserWindow [

	| class browser |
	class := CBClass new name: 'GeneratedBrowserTestClass'.
	changeSet addClass: class.
	browser := changeSet browseChanges.
	[
		self assert: (browser isKindOf: CBChangesBrowser) description: 'browseChanges should return a CBChangesBrowser'.
		self assert: browser window isOpen description: 'browseChanges should open a browser window' ] ensure: [ browser window close ]
]

{ #category : 'tests' }
CBChangeSetTest >> testClassNamed [
	| class |
	class := changeSet classNamed: 'Unit'.
	self assert: class name equals: 'Unit'.
	self assert: changeSet classes asArray equals: {class}
]

{ #category : 'tests' }
CBChangeSetTest >> testClassNamedSame [

	| classA classB |
	classA := changeSet classNamed: 'Unit'.
	classB := changeSet classNamed: 'Unit'.
	self assert: classA identicalTo: classB
]

{ #category : 'tests' }
CBChangeSetTest >> testClassWithMetaMethodChanges [

	| class methodRefactoring |
	class := CBClass new name: 'GeneratedClass'.
	class addMetaMethod: (CBMethod new
			 source: 'meth ^ 1';
			 protocolName: 'my protocol').
	changeSet addClass: class.
	self assert: changeSet classes equals: { class }.
	methodRefactoring := changeSet allRefactoringChanges second.
	self assert: methodRefactoring isMeta description: 'Meta method refactoring change should target class side'.
	self assert: methodRefactoring cbTextToDisplay equals: '"my protocol"
meth ^ 1'
]

{ #category : 'tests' }
CBChangeSetTest >> testClassWithMethodChanges [

	| class |
	class := CBClass new name: 'GeneratedClass'.
	class addMethod: (CBMethod new
			 source: 'meth ^ 1';
			 protocolName: 'my protocol').
	changeSet addClass: class.
	self assert: changeSet classes equals: { class }.
	self assert: changeSet allRefactoringChanges second cbTextToDisplay equals: '"my protocol"
meth ^ 1'
]

{ #category : 'tests' }
CBChangeSetTest >> testFromRealClass [

	| realClass class |
	realClass := self class.
	class := changeSet fromRealClass: realClass.
	self assert: class instVarNames equals: realClass instVarNames.
	self assert: class parent equals: realClass superclass name.
	self assert: changeSet classes asArray equals: { class }
]

{ #category : 'tests' }
CBChangeSetTest >> testFromRealClassReturnsExistingInstance [

	| first second |
	first := changeSet fromRealClass: self class.
	second := changeSet fromRealClass: self class.
	self assert: second identicalTo: first.
	self assert: changeSet classes asArray equals: { first }
]
