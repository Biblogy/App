#//# --------------------------------------------------------------------------------------
#//# Created using Sequence Diagram for Mac
#//# https://www.macsequencediagram.com
#//# https://itunes.apple.com/gb/app/sequence-diagram/id1195426709?mt=12
#//# --------------------------------------------------------------------------------------
title "Booer User"

participant "User" as user
participant "Booer" as app
participant "CoreData Database" as data
participant "iCloud" as cloud
participant "OpenLiberay API" as api

activate app
activate user

*-->app: Launch 🚀
activate data
activate cloud
cloud->data: updates all entrys
app->data: request all unfinshed books from user
data->app: send all unfinished books
app->user: Presend all unfinisched books 🖼
deactivate cloud

loop
	alt [Add New Book]
		user->app: press add button
		app->user: presend sheet
		user->app: enter book name
		
		alt [enter book manualy]
			user->app: enter page number
			user->app: enter author
		else [seach for Book]
			activate api
			user->app: press search
			app->api: request all books with title
			opt [found / fail / empty]
				api->app: send found 
			end
			deactivate api
			app->user: presend books as list
			user->app: select book
			user->app: check number of pages
		end
		
		user->app: press save
		app->data: save new book
		opt [seccess / fail]
				data->app: returns 
		end
		app->user: close sheet
		
	
	else [Change read]
		user->app: enter number
		user->app: press update
		app->data: update book progress with new entry
		app->app: calc new progress
		app->app: check if done
	
	else [Show all done Books]
		user->app: navigate to Done screen
		app->data: request all books that are done
		opt [seccess / fail]
				data->app: send books
		end
		user->app: unfinish a book
		app->data: change book progress

	else [Add new challenge]
		user->app: navigate to challenge screen
		app->data: request all challenges
		opt [seccess / fail]
				data->app: send challenges
		end
		user->app: press add button
		app->user: presend sheet
		user->app: enter challenge data
		user->app: press save
		app->data: add new challenge to book
		opt [seccess / fail]
				data->app: is saved
		end
		app->user: close sheet
	end
end

user->app: request exit
app->data: request close
activate cloud
data->cloud: send snyc data
deactivate cloud
data->app: close

app->user: exit 🛑

deactivate data
deactivate app
deactivate user