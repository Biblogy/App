const express = require('express')
const app = express()
const port = 3000
const axios = require('axios');

function getBook() {
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

app.get('/', (req, res) => {
	getBook().then((item) => {
		res.json(item.data.items)
	})
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})