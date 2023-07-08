# eCue

eCue is a simple shell script that uses CUE to test for semantic equality of
structured data files.

It compares 2 files' contents, and exits with a status code of 0 if and only if
the 2 files contain the same underlying data.  

It works with any structured data format supported by the CUE CLI, which
includes JSON and YaML.

The names of both files must have a standard suffix: `.json`, `.yml`, or
`.yaml`.

## Installation

Clone this repo, or download the [eCue.sh](eCue.sh) script.

eCue has one dependency: the [cue CLI tool](https://cuelang.org/docs/install/).

## Usage

```shell
$ /path/to/eCue.sh <file1> <file2>
```

## Example

These 2 YaML files are semantically equal, but not byte-for-byte equal:

- 1.yml:
```yaml
foo: 1
bar: 2
```
- 2.yml:
```yaml
bar: 2
foo: 1
```

eCue uses CUE to check that 2 files contain the same information, even if the
data is stated in a different order:

```shell
$ /path/to/eCue.sh 1.yml 2.yml
$ echo $?
0
```

If another file is introduced, containing different structured data, and is
compared to either of the first 2 files, eCue provides a CUE error message
showing one or more differences encountered.

```shell
$ cat 3.yml
notFoo: 1
bar: 2
$ /path/to/eCue.sh 1.yml 3.yml 
notFoo: field not allowed:
    ./3.yml:1:2
    ../../../../tmp/tmp.RWnZAU5cQN.cue:1:10
$ echo $?
1
```
