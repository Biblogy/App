const express = require('express')
const app = express()
const port = 3000
const axios = require('axios');
var mongo = require('mongodb');
var db = require("./App/Data/mongoDB/db-setup.js");
var googleAPI= require("./App/Data/googleAPI/loadBook.js");
var getBook= require("./App/Service/getBook.js");

app.get('/book', (req, res) => {
	// wenn book nicht in der DB vor kleiner als 30 tagen aktualisiert, aktualisiere db und sende passende Daten Strukturen 
	const books = new getBook()
	books.test("Qualityland").then(
		function(value) {
			console.log("getBook")
			res.send(value)
		},
		function(error) {
			console.log("erros")
			res.send(error)
		}
	)
})

/*
app.get('/close', (req, res) => {
 	db.close()
	res.send('ok')
})
*/
			

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
  db.connectToDB("google").then(
	  function(value) {
		  console.log("connected to google")
	  },
	  function(error) {
		  console.log("error")
	  }
  )
})