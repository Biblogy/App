const { MongoClient } = require('mongodb');
const uri = require("./getUri");
const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });

class Database {
	constructor() {}
	
	async connectToDB(collectionName) {
		return new Promise((resolve, reject) => {	
			client.connect(err => {
			 	if (err) {
					reject(err)
				} else {
					const collection = client.db("booer").collection(collectionName)
					this.collection = collection
					resolve("connect");
				}
			});
		})
	}
	
	close() {
		console.log(this.collection)
		client.close()
	}
	
	findByName(name) {
		return new Promise((resolve, reject) => {
			this.collection.find({"volumeInfo.title": {$lt: name}}).toArray(function(err, result) {
				if (err) {
					reject(err)
				} else {
					resolve(result)
				}
			})
		})
	} 
	
	saveToCollection(book) {
		return new Promise((resolve, reject) => {
			this.collection.insertOne(book, function(err, res) {
				if (err) {
					reject(err)
				} else {
					resolve(res)
				}
			})
		})
	}
	
	saveMultibleToCollection(books){
		return new Promise((resovle, reject) => {
			for (let book of books) {
				this.saveToCollection(book).then(
					function(value) {
					},
					function(error) {
						reject(error)
					}
				)
			}
			resovle(200)
		})
	}
}

class Singleton {
	constructor() {
		if (!Singleton.instance) {
			Singleton.instance = new Database();
		}
	}

	getInstance() {
		return Singleton.instance;
	}
}

module.exports = new Singleton().getInstance()