"
Adapter exposing the builder configuration of a pending class-addition refactoring change through the inspection protocol expected by a class definition printer.

Collaborates with a refactoring change's class builder on one side and a fluid class definition printer on the other so proposed class definitions can be formatted and compared against existing classes without installing them. Empty or absent package tag names are mapped to the target package's root tag name without mutating the package or emitting system announcements.
"
Class {
	#name : 'CBAddClassPrintAdaptor',
	#superclass : 'Object',
	#instVars : [
		'addClassChange'
	],
	#category : 'ChangesBuilder-Model',
	#package : 'ChangesBuilder',
	#tag : 'Model'
}

{ #category : 'instance creation' }
CBAddClassPrintAdaptor class >> for: anAddClassChange [

	^ self new
		  addClassChange: anAddClassChange;
		  yourself
]

{ #category : 'accessing' }
CBAddClassPrintAdaptor >> addClassChange: anAddClassChange [

	addClassChange := anAddClassChange
]

{ #category : 'accessing' }
CBAddClassPrintAdaptor >> classLayout [

	^ addClassChange builder layoutClass new
]

{ #category : 'accessing' }
CBAddClassPrintAdaptor >> classVariables [

	^ addClassChange builder sharedVariables
]

{ #category : 'testing' }
CBAddClassPrintAdaptor >> hasTraitComposition [

	^ addClassChange builder traitComposition isNotEmpty
]

{ #category : 'slots' }
CBAddClassPrintAdaptor >> localSlots [

	^ addClassChange builder slots
]

{ #category : 'accessing' }
CBAddClassPrintAdaptor >> name [

	^ addClassChange builder name
]

{ #category : 'accessing' }
CBAddClassPrintAdaptor >> package [

	^ Package named: addClassChange builder package
]

{ #category : 'accessing' }
CBAddClassPrintAdaptor >> packageTag [

	| package tagName |
	package := self package.
	tagName := addClassChange builder tag.
	^ PackageTag package: package name: ((tagName isNil or: [ tagName isEmpty ])
			   ifTrue: [ package rootTagName ]
			   ifFalse: [ tagName ])
]

{ #category : 'accessing' }
CBAddClassPrintAdaptor >> sharedPools [

	^ addClassChange builder sharedPools
]

{ #category : 'accessing' }
CBAddClassPrintAdaptor >> superclass [

	^ addClassChange builder superclass
]
