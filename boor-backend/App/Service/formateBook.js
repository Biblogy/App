class formateBook {
	formateGoogleData(data) {		
		var formatedData = {
			title: data.volumeInfo.title,
			subtitle: data.volumeInfo.subtitle,
			description: data.volumeInfo.description,
			pages: data.volumeInfo.pageCount
		}
		return formatedData
	}
	
	formateBooks(books){
		var formatedBooks = books.map(this.formateGoogleData)
		return formatedBooks
	}
}

module.exports = new formateBook()

/*

{
	title: "",
	subtitle: "",
	author: "",
	description: "",
	pages: "",
	categories: "",
	publisher: "",
}

*/