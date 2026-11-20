"
Test double subclassing ShiftClassBuilder that raises an error if any class-installation or build step is invoked prematurely, ensuring class definitions under test only configure builder metadata without mutating the system.
"
Class {
	#name : 'CBDummyShiftClassBuilder',
	#superclass : 'ShiftClassBuilder',
	#category : 'ChangesBuilder-Tests-Model',
	#package : 'ChangesBuilder-Tests',
	#tag : 'Model'
}

{ #category : 'building' }
CBDummyShiftClassBuilder >> build [

	self error: 'Should not have been built yet'
]

{ #category : 'installing' }
CBDummyShiftClassBuilder >> createClass [

	self error: 'Should not have been built yet'
]

{ #category : 'building' }
CBDummyShiftClassBuilder >> createMetaclass [

	self error: 'Should not have been built yet'
]

{ #category : 'building' }
CBDummyShiftClassBuilder >> createSharedVariables [

	self error: 'Should not have been built yet'
]

{ #category : 'building' }
CBDummyShiftClassBuilder >> installSlotsAndVariables [

	self error: 'Should not have been built yet'
]

{ #category : 'building' }
CBDummyShiftClassBuilder >> tryToFillOldClass [

	self error: 'Should not have been built yet'
]
