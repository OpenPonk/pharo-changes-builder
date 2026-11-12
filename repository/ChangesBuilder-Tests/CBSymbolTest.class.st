Class {
	#name : 'CBSymbolTest',
	#superclass : 'TestCase',
	#category : 'ChangesBuilder-Tests-Utilities',
	#package : 'ChangesBuilder-Tests',
	#tag : 'Utilities'
}

{ #category : 'tests' }
CBSymbolTest >> testAsRetriever [
	self assert: #name: asRetriever equals: #name
]

{ #category : 'tests' }
CBSymbolTest >> testAsRetriever2 [
	self assert: #name asRetriever equals: #name
]
