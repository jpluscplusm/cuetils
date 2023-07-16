package csv_exporter

import "encoding/csv"

#Class: string
#Fields: {...}
#Data: [_]: #Fields

#CSV: csv.Encode([
	[ #Class, for k, _ in #Fields {"\(k)"}],
	for item, content in #Data {
		[ "\(item)", for k, _ in #Fields {"\(content[k])"}]
	},
])
