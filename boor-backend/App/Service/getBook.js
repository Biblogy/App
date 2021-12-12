var db= require("../Data/mongoDB/db-setup.js");
var googleAPI= require("../Data/googleAPI/loadBook.js");
var formateBook = require("./formateBook.js");
module.exports = class getBook {
	constructor() {}
	
	addNewBooks() {
		return new Promise((resolve, reject) => {
			googleAPI.getBook().then((item) => {
				
				const data = item.data.items
				data.forEach(element => 
					element.addedDate = new Date()
				)
				
				db.saveMultibleToCollection(item.data.items).then(
					function(value) {
						resolve(value)
					},
					function(error) {
						reject(error)
					}
				)
			})
		})
	}

	test() {
		const self = this
		return new Promise((resolve, reject) => {			
			db.findByName("Qualityland").then(
				function(value) {
					if (value.length != 0) {
						resolve(formateBook.formateBooks(value))
					} else {
						self.addNewBooks().then(
							function(value) {
								self.test()
							},
							function(error) {
								reject(error)	
							}
						)
					}
				},
				function(error) {
					reject(error)
				}
			)
		})
	}
}