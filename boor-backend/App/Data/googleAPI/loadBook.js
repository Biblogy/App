const axios = require('axios');

class loadBook {
	getBook() {
		return new Promise((resolve, reject) => {
			axios.get('https://www.googleapis.com/books/v1/volumes?q=title:Qualityland')
				.then(function (response) {
				console.log(response)
				resolve(response)
				})
				.catch(function (error) {
				console.log(error)
				reject(error)
				})
			})
	}
}

module.exports = new loadBook()