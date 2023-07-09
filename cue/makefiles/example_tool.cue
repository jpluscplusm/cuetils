package example

import (
	"tool/file"
	"tool/http"
	"jonathanmatthews.com/cuetils/cue/makefiles"
)

command: {
	let f = {makefiles.#Directory & {#Path: ".", #Contents: files."."}}.#Files
	f
	all_files: f
}

files: ".": {
	//	"test.1": makefiles.#File & file.Create & {
	//		#Path:    _, #Filename: _, #FilePath: _
	//		filename: #FilePath
	//		contents: "some content\n"
	//	}
	//	foo: {
	//		"test.2": makefiles.#File & {
	//			#Path:  _, #Filename: _, #FilePath: _
	//			create: file.Create & {
	//				$after:   command["\(#Path)/"]
	//				filename: #FilePath
	//				contents: "some other content\n"
	//			}
	//		}
	//	}
	foo: bar: {
		baz: {
			"holidays.json": makefiles.#File & {
				#Path: _, #Filename: _, #FilePath: _
				fetch: http.Get & {
					url: "https://www.gov.uk/bank-holidays.json"
				}
				store: file.Create & {
					$after:   command["\(#Path)/"]
					filename: #FilePath
					contents: fetch.response.body
				}
			}
		}
	}
}
