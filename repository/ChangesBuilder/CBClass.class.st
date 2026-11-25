"
I represent a in-memory class that knows how to convert itself to RBChange to generate actual code.

I also provide couple more convenient methods for code definition.
"
Class {
	#name : 'CBClass',
	#superclass : 'Object',
	#instVars : [
		'name',
		'comment',
		'parent',
		'packageName',
		'tag',
		'instanceVariables',
		'classVariables',
		'methods',
		'metaMethods',
		'metaInstanceVariables',
		'sortVariables'
	],
	#category : 'ChangesBuilder-Model',
	#package : 'ChangesBuilder',
	#tag : 'Model'
}

{ #category : 'instance creation' }
CBClass class >> fromClass: aRealClass [

	| class |
	(class := self new)
		name: aRealClass name;
		parent: aRealClass superclass name;
		packageName: aRealClass packageName;
		tag: (self packageTagNameFor: aRealClass);
		sortVariables: false.
	aRealClass instanceVariables do: [ :each | class addInstVarSlot: each ].
	aRealClass classVariables do: [ :each | class addClassVar: each ].
	aRealClass class instanceVariables do: [ :each | class addMetaInstVarSlot: each ].
	^ class
]

{ #category : 'instance creation' }
CBClass class >> name: aString parent: aClass package: aPkgName [

	^ self new
		  name: aString;
		  parent: aClass;
		  package: aPkgName;
		  yourself
]

{ #category : 'instance creation' }
CBClass class >> name: aString parent: aClass package: aPkgName tag: aTagName [

	^ self new
		  name: aString;
		  parent: aClass;
		  packageName: aPkgName;
		  tag: aTagName;
		  yourself
]

{ #category : 'accessing' }
CBClass class >> packageTagNameFor: aRealClass [

	^ aRealClass packageTag isRoot
		  ifTrue: [ '' ]
		  ifFalse: [ aRealClass packageTagName asString ]
]

{ #category : 'adding' }
CBClass >> addClassVar: aClassVar [

	self addClassVarNamed: aClassVar name
]

{ #category : 'adding' }
CBClass >> addClassVarNamed: aString [

	(classVariables includes: aString) ifFalse: [ classVariables add: aString ]
]

{ #category : 'adding' }
CBClass >> addInstVarNamed: aString [

	(instanceVariables includes: aString) ifFalse: [ instanceVariables add: aString ]
]

{ #category : 'adding' }
CBClass >> addInstVarSlot: aSlot [

	self addInstVarNamed: aSlot name
]

{ #category : 'adding' }
CBClass >> addMetaInstVarNamed: aString [

	(metaInstanceVariables includes: aString) ifFalse: [ metaInstanceVariables add: aString ]
]

{ #category : 'adding' }
CBClass >> addMetaInstVarSlot: aSlot [

	self addMetaInstVarNamed: aSlot name
]

{ #category : 'adding' }
CBClass >> addMetaMethod: aMethod [
	metaMethods at: aMethod selector put: aMethod
]

{ #category : 'adding' }
CBClass >> addMethod: aMethod [
	methods at: aMethod selector put: aMethod
]

{ #category : 'accessing' }
CBClass >> categoryName [

	self packageTag ifNil: [ ^ self packageName ].
	self packageTag ifEmpty: [ ^ self packageName ].
	^ String streamContents: [ :stream |
			  stream << self packageName.
			  stream << '-'.
			  stream << self packageTag ]
]

{ #category : 'generating' }
CBClass >> classDefinition [

	self assert: [ name isString & name isNotEmpty ].
	self assert: [ parent isString & parent isNotEmpty ].
	self assert: [ instanceVariables isCollection ].
	self assert: [ instanceVariables allSatisfy: #isString ].
	self assert: [ packageName isString & packageName isNotEmpty ].
	self assert: [ tag isString ].
	^ [ :builder |
		  builder
			  superclassName: parent;
			  name: name;
			  slots: (self orderedVariables: self instanceVariables);
			  sharedVariables: (self orderedVariables: self classVariables);
			  package: packageName;
			  tag: tag ]
]

{ #category : 'accessing' }
CBClass >> classVarNames [
	^ self classVariables
]

{ #category : 'accessing' }
CBClass >> classVariables [
	^ classVariables asArray
]

{ #category : 'accessing' }
CBClass >> comment [
	^ comment
]

{ #category : 'accessing' }
CBClass >> comment: anObject [
	comment := anObject
]

{ #category : 'adding' }
CBClass >> compile: aString classified: aProtocol [
	self
		addMethod:
			(CBMethod new
				source: aString;
				protocolName: aProtocol)
]

{ #category : 'adding' }
CBClass >> compileMeta: aString classified: aProtocol [

	self addMetaMethod: (CBMethod new
			 source: aString;
			 protocolName: aProtocol)
]

{ #category : 'testing' }
CBClass >> hasClassVarNamed: aString [
	^ classVariables includes: aString
]

{ #category : 'testing' }
CBClass >> hasInstVarNamed: aString [
	^ instanceVariables includes: aString
]

{ #category : 'testing' }
CBClass >> hasMetaInstVarNamed: aString [
	^ metaInstanceVariables includes: aString
]

{ #category : 'initialization' }
CBClass >> initialize [

	super initialize.
	parent := 'Object'.
	packageName := 'Unclassified'.
	tag := ''.
	sortVariables := true.
	instanceVariables := OrderedCollection new.
	classVariables := OrderedCollection new.
	metaInstanceVariables := OrderedCollection new.
	methods := OrderedDictionary new.
	metaMethods := OrderedDictionary new
]

{ #category : 'accessing' }
CBClass >> instVarNames [
	^ self instanceVariables
]

{ #category : 'accessing' }
CBClass >> instanceVariables [
	^ instanceVariables asArray
]

{ #category : 'accessing' }
CBClass >> metaInstanceVariables [
	^ metaInstanceVariables asArray
]

{ #category : 'accessing' }
CBClass >> metaMethods [
	^ metaMethods values
]

{ #category : 'accessing' }
CBClass >> methodNamed: aName [
	^ self methods detect: [ :each | each selector = aName ]
]

{ #category : 'accessing' }
CBClass >> methods [
	^ methods values
]

{ #category : 'accessing' }
CBClass >> name [
	^ name
]

{ #category : 'accessing' }
CBClass >> name: aString [
	name := aString
]

{ #category : 'private' }
CBClass >> orderedVariables: aCollection [

	^ sortVariables
		  ifTrue: [ aCollection sorted ]
		  ifFalse: [ aCollection ]
]

{ #category : 'accessing' }
CBClass >> package: aPackageName [

	self packageName: aPackageName
]

{ #category : 'accessing' }
CBClass >> packageName [
	^ packageName
]

{ #category : 'accessing' }
CBClass >> packageName: aPackageName [

	packageName := aPackageName
]

{ #category : 'accessing' }
CBClass >> packageTag [

	^ self tag
]

{ #category : 'accessing' }
CBClass >> packageTag: aString [

	self tag: aString
]

{ #category : 'accessing' }
CBClass >> parent [
	^ parent
]

{ #category : 'accessing' }
CBClass >> parent: aClass [
	parent := aClass
]

{ #category : 'printing' }
CBClass >> printOn: aStream [

	super printOn: aStream.
	aStream << '('.
	aStream print: name.
	aStream << ', a('.
	instanceVariables do: [ :each | aStream << each ] separatedBy: [ aStream << ',' ].
	aStream << '),m('.
	aStream print: methods size.
	aStream << '))'
]

{ #category : 'accessing' }
CBClass >> realClass [

	^ (Smalltalk hasClassNamed: self name)
		  ifTrue: [ self name asClassInEnvironment: self class environment ]
		  ifFalse: [ nil ]
]

{ #category : 'accessing' }
CBClass >> selectors [
	^ methods keys
]

{ #category : 'accessing' }
CBClass >> sortVariables [

	^ sortVariables
]

{ #category : 'accessing' }
CBClass >> sortVariables: aBoolean [

	sortVariables := aBoolean
]

{ #category : 'accessing' }
CBClass >> tag [

	^ tag
]

{ #category : 'accessing' }
CBClass >> tag: aString [
	tag := aString
]
