Class {
	#name : 'CBClassTest',
	#superclass : 'TestCase',
	#instVars : [
		'class'
	],
	#category : 'ChangesBuilder-Tests-Model',
	#package : 'ChangesBuilder-Tests',
	#tag : 'Model'
}

{ #category : 'running' }
CBClassTest >> setUp [
	super setUp.
	class := CBClass name: 'MyXXTestClass' parent: 'Object' package: 'GeneratedCode' tag: ''
]

{ #category : 'tests - adding' }
CBClassTest >> testAddClassVariable [

	class addClassVarNamed: 'something'.
	self assert: class classVariables equals: #( something ).
	self assert: class classVarNames equals: #( something ).
	self assert: (class hasClassVarNamed: 'something') description: 'Added class variable should be reported by hasClassVarNamed:'
]

{ #category : 'tests - adding' }
CBClassTest >> testAddInstanceVariable [

	class addInstVarNamed: 'something'.
	self assert: class instanceVariables equals: #( something ).
	self assert: class instVarNames equals: #( something ).
	self assert: (class hasInstVarNamed: 'something') description: 'Added instance variable should be reported by hasInstVarNamed:'
]

{ #category : 'tests - adding' }
CBClassTest >> testAddMetaInstanceVariable [

	class addMetaInstVarNamed: 'something'.
	self assert: class metaInstanceVariables equals: #( something ).
	self
		assert: (class hasMetaInstVarNamed: 'something')
		description: 'Added meta instance variable should be reported by hasMetaInstVarNamed:'
]

{ #category : 'tests - adding' }
CBClassTest >> testAddMetaMethod [
	class addMetaMethod: (CBMethod new getter: 'item').
	self assert: class metaMethods size equals: 1.
	self assert: class methods size equals: 0.
	self assert: class selectors equals: #()
]

{ #category : 'tests - adding' }
CBClassTest >> testAddMethod [
	| method |
	method := CBMethod new getter: 'item'.
	class addMethod: method.
	self assert: class metaMethods size equals: 0.
	self assert: class methods size equals: 1.
	self assert: class selectors equals: #(item).
	self assert: (class methodNamed: #item) equals: method
]

{ #category : 'tests' }
CBClassTest >> testClassDefinition [

	| builder returnedBuilder |
	class := CBClass
		         name: 'SomeGeneratedClassSomewhere'
		         parent: 'OPCGClassTest'
		         package: 'Somewhere'.
	builder := CBDummyShiftClassBuilder new.
	returnedBuilder := class classDefinition value: builder.
	self assert: returnedBuilder identicalTo: builder.
	self assert: builder superclassName equals: 'OPCGClassTest'.
	self assert: builder name equals: #SomeGeneratedClassSomewhere.
	self
		assertCollection: (builder slots collect: #name)
		equals: #(  ).
	self
		assertCollection: (builder sharedVariables collect: #name)
		equals: #(  ).
	self assert: builder package equals: 'Somewhere'.
	self assert: builder tag equals: ''
]

{ #category : 'tests' }
CBClassTest >> testClassDefinitionVarsSorted [

	| builder returnedBuilder |
	class := CBClass
		         name: 'SomeGeneratedClassSomewhere'
		         parent: 'OPCGClassTest'
		         package: 'Somewhere'.
	class addInstVarNamed: 'var2'.
	class addInstVarNamed: 'var1'.
	class addClassVarNamed: 'clsVar2'.
	class addClassVarNamed: 'clsVar1'.
	builder := CBDummyShiftClassBuilder new.
	returnedBuilder := class classDefinition value: builder.
	self assert: returnedBuilder identicalTo: builder.
	self assert: builder superclassName equals: 'OPCGClassTest'.
	self assert: builder name equals: #SomeGeneratedClassSomewhere.
	self
		assertCollection: (builder slots collect: #name)
		equals: #( var1 var2 ).
	self
		assertCollection: (builder sharedVariables collect: #name)
		equals: #( clsVar1 clsVar2 ).
	self assert: builder package equals: 'Somewhere'.
	self assert: builder tag equals: ''
]

{ #category : 'tests' }
CBClassTest >> testClassDefinitionWithInstanceAndClassVars [
	| builder returnedBuilder |
	class := CBClass
		name: 'SomeGeneratedClassSomewhere'
		parent: 'OPCGClassTest'
		package: 'Somewhere'.
	class addInstVarNamed: 'var1'.
	class addInstVarNamed: 'var2'.
	class addClassVarNamed: 'clsVar1'.
	class addClassVarNamed: 'clsVar2'.
	builder := CBDummyShiftClassBuilder new.
	returnedBuilder := class classDefinition value: builder.
	self assert: returnedBuilder identicalTo: builder.
	self assert: builder superclassName equals: 'OPCGClassTest'.
	self assert: builder name equals: #SomeGeneratedClassSomewhere.
	self
		assertCollection: (builder slots collect: #name)
		equals: #( var1 var2 ).
	self
		assertCollection: (builder sharedVariables collect: #name)
		equals: #( clsVar1 clsVar2 ).
	self assert: builder package equals: 'Somewhere'.
	self assert: builder tag equals: ''
]

{ #category : 'tests' }
CBClassTest >> testClassDefinitionWithInstanceVars [

	| builder returnedBuilder |
	class := CBClass
		         name: 'SomeGeneratedClassSomewhere'
		         parent: 'OPCGClassTest'
		         package: 'Somewhere'.
	class addInstVarNamed: 'var1'.
	class addInstVarNamed: 'var2'.
	builder := CBDummyShiftClassBuilder new.
	returnedBuilder := class classDefinition value: builder.
	self assert: returnedBuilder identicalTo: builder.
	self assert: builder superclassName equals: 'OPCGClassTest'.
	self assert: builder name equals: #SomeGeneratedClassSomewhere.
	self
		assertCollection: (builder slots collect: #name)
		equals: #( var1 var2 ).
	self
		assertCollection: (builder sharedVariables collect: #name)
		equals: #(  ).
	self assert: builder package equals: 'Somewhere'.
	self assert: builder tag equals: ''
]

{ #category : 'tests - accessing' }
CBClassTest >> testComment [
	self assert: class comment equals: nil.
	class comment: 'hello'.
	self assert: class comment equals: 'hello'
]

{ #category : 'tests - adding' }
CBClassTest >> testCompileMetaMethod [

	class
		compileMeta: 'item
	^ item'
		classified: 'accessing'.
	self assert: class methods size equals: 0.
	self assert: class metaMethods size equals: 1.
	self assert: class metaMethods first protocolName equals: 'accessing'.
	self assert: class metaMethods first source equals: 'item
	^ item'
]

{ #category : 'tests - adding' }
CBClassTest >> testCompileMethod [

	class
		compile: 'item
	^ item'
		classified: 'accessing'.
	self assert: class metaMethods size equals: 0.
	self assert: class methods size equals: 1.
	self assert: class selectors equals: #( item ).
	self assert: class methods first protocolName equals: 'accessing'.
	self assert: class methods first source equals: 'item
	^ item' expandMacros
]

{ #category : 'tests' }
CBClassTest >> testCreate [

	| created |
	created := CBClass name: 'MyClass' parent: 'Something' package: 'Generated'.
	self assert: created name equals: 'MyClass'.
	self assert: created parent equals: 'Something'.
	self assert: created packageName equals: 'Generated'
]

{ #category : 'tests' }
CBClassTest >> testFromRealClass [

	| realClass adaptorClass |
	realClass := self class.
	class := CBClass fromClass: realClass.
	self assert: class instVarNames equals: realClass instVarNames.
	self assert: class parent equals: realClass superclass name.
	self assert: class packageName equals: realClass packageName.
	self assert: class packageTag isString description: 'packageTag copied from real class must be a String'.
	self assert: class packageTag equals: realClass packageTagName asString.
	self assert: (CBChangeSet new addClass: class) allRefactoringChanges size equals: 1.
	adaptorClass := CBClass fromClass: CBAddClassPrintAdaptor.
	self assertEmpty: (CBChangeSet new addClass: adaptorClass) refactoringChanges
]

{ #category : 'tests' }
CBClassTest >> testFromRealClassCopiesClassAndMetaVariables [

	| classWithClassVars classWithMetaVars |
	classWithClassVars := CBClass fromClass: Float.
	self assertCollection: classWithClassVars classVarNames hasSameElements: Float classVarNames.
	classWithMetaVars := CBClass fromClass: CBNautilusRefactoringChangesTest.
	self
		assertCollection: classWithMetaVars metaInstanceVariables
		hasSameElements: CBNautilusRefactoringChangesTest class instVarNames
]

{ #category : 'tests' }
CBClassTest >> testFromRealClassWithRootTag [

	| realClass |
	realClass := BaselineOfChangesBuilder.
	class := CBClass fromClass: realClass.
	self assert: class parent equals: realClass superclass name.
	self assert: class packageName equals: realClass packageName.
	self assert: class packageTag equals: ''.
	self assert: class categoryName equals: realClass packageName.
	self assertEmpty: (CBChangeSet new addClass: class) refactoringChanges
]

{ #category : 'tests - accessing' }
CBClassTest >> testPackage [

	class package: 'Wherever'.
	self assert: class packageName equals: 'Wherever'
]

{ #category : 'tests' }
CBClassTest >> testPackageTagAndCategoryName [

	class packageTag: 'SubTag'.
	self assert: class packageTag equals: 'SubTag'.
	self assert: class categoryName equals: 'GeneratedCode-SubTag'.
	class packageTag: ''.
	self assert: class categoryName equals: 'GeneratedCode'.
	class packageTag: nil.
	self assert: class categoryName equals: 'GeneratedCode'
]

{ #category : 'tests - accessing' }
CBClassTest >> testParent [
	class := CBClass new.
	self assert: class parent equals: 'Object'.
	class parent: 'TestCase'.
	self assert: class parent equals: 'TestCase'
]

{ #category : 'tests' }
CBClassTest >> testPrintOn [

	| multiVarOutput |
	class addMethod: (CBMethod new getter: 'first').
	class addInstVarNamed: 'first'.
	self assert: class printString equals: 'a CBClass(''MyXXTestClass'', a(first),m(1))'.
	class addInstVarNamed: 'second'.
	multiVarOutput := class printString.
	self
		assert:
			(#( 'a CBClass(''MyXXTestClass'', a(first,second),m(1))' 'a CBClass(''MyXXTestClass'', a(second,first),m(1))' ) includes:
				 multiVarOutput)
		description: 'printOn: should separate multiple instance variables with commas'
]

{ #category : 'tests - accessing' }
CBClassTest >> testRealClass [
	class name: self class name.
	self assert: class realClass equals: self class.
	class name: 'ThereIsNoSuchClassInTheSystem'.
	self assert: class realClass equals: nil
]
