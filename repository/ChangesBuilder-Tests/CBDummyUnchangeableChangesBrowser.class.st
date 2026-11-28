"
Test double browser that always refuses changes so accept abort behavior can be verified without external mocking libraries.
"
Class {
	#name : 'CBDummyUnchangeableChangesBrowser',
	#superclass : 'CBChangesBrowser',
	#category : 'ChangesBuilder-Tests-Model',
	#package : 'ChangesBuilder-Tests',
	#tag : 'Model'
}

{ #category : 'private' }
CBDummyUnchangeableChangesBrowser >> okToChange [

	^ false
]
