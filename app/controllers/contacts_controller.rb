class ContactsController < ApplicationController
	def create
		puts "NEW CONTACT !!!!!"
		@contact = Contact.new
	    @contact.firstname = params["firstname"]
	    @contact.lastname = params["lastname"]
	    @contact.email = params["email"]
	    @contact.user_id = current_user.id
	    @contact.save
	    binding.pry
	    # something to add to 
	    response.headers['X-PJAX-URL'] = "http://localhost:3000/events/invite"
      	render '/events/invite'
	end 
end
