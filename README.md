# Changes Builder

[![Nightly](https://github.com/OpenPonk/pharo-changes-builder/actions/workflows/nightly.yml/badge.svg)](https://github.com/OpenPonk/pharo-changes-builder/actions/workflows/nightly.yml) [![Coverage Status](https://coveralls.io/repos/github/OpenPonk/pharo-changes-builder/badge.svg?branch=master)](https://coveralls.io/github/OpenPonk/pharo-changes-builder?branch=master)

Lightweight wrapper library simplifying common `RBRefactoring` operations during programmatic code generation in Pharo.

Code to be generated is represented as `RBRefactoring` changes so it can be reviewed before execution, with no-op changes automatically filtered out.

## Installation

See [openponk.org/#direct-installation](https://openponk.org/#direct-installation) for the supported Pharo version.

```smalltalk
Metacello new
	baseline: 'ChangesBuilder';
	repository: 'github://OpenPonk/pharo-changes-builder';
	load.
```

## Usage Example

```smalltalk
example
| cls getter setter init changeSet |
cls := CBClass new.
cls name: 'Square'.
"package name, default 'Unclassified'"
cls package: 'Geometric-Shapes'.
"the superclass of Square, default is Object"
cls parent: 'Object'.

"add an instance variable"
cls addInstVarNamed: 'size'.

"getter: generates a basic accessor in the 'accessing' protocol"
getter := CBMethod new
	getter: 'size'.
"ditto for setter"
setter := CBMethod new
	setter: 'size' argument: 'Number' comment: 'specify a new size'.
"hand-written source is also possible"
init := CBMethod new
	source: 'initialize
	size := 0';
	protocolName: 'initialization'.

cls addMethod: getter.
cls addMethod: setter.
cls addMethod: init.

changeSet := CBChangeSet new.
changeSet addClass: cls.

"ChangesBrowser can also be used, but it raises an error on an empty changeset"
^ (CBChangesBrowser changes: changeSet refactoringChanges) open.
```

![Changes Builder browser example](docs/example-changes.png)

## Documentation

Part of the [OpenPonk](https://openponk.org) platform. For architecture, the repository catalog, and contributing guidelines, see [`OpenPonk/.github`](https://github.com/OpenPonk/.github/blob/main/profile/README.md).
