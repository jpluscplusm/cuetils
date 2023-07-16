package demo

import "jonathanmatthews.com/cuetils/cue/csv_exporter"

csv: {
	csv_exporter & {
		#Class:  "Name"
		#Data:   data
		#Fields: fields
	}
}.#CSV

fields: {
	a: int
	b: int | *""
	c: number | *0
	d: string | *""
}

data: {
	x: {
		a: 1
		b: "2" // TODO: why doesn't this fail to unify with fields.b:int inside csv_exporter?
		c: 3.123
		d: "this is the d field inside x"
	}
	y: {
		a: 5
		b: 6
	}
	z: {
		a: 999
		d: #"hello, "world"!"#
	}
}
