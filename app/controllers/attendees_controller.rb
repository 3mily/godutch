require 'pry'
require 'mandrill'

class AttendeesController < ApplicationController

  def create
  	@event = current_user.events.last
    @invite_list = params["my-select"]

		@invite_list.each do |id|	
			invitee = Contact.find(user_id = id)
			r_email = invitee.email
			r_firstname = invitee.firstname
			attendee = Attendee.create(email: invitee.email, contact_id: invitee.id, event_id: @event.id );
			attendee_id = attendee.id.to_s

			email_body = "<html><head><style> div { font-family: 'Open Sans', sans-serif; color: #111; border: solid 2px #81B7FF, padding: 10px} h2 { background-color: #81B7FF, padding: 10px, font-size: 20px; color: #fff; } a { font-size: 14px; color: #60c0ac; text-decoration: none; } </style></head><body>
				<div><h2>Hey <strong>"+attendee.contact.firstname+"</strong>, how are you?</h2><p> You've been invited by <strong>"+current_user.firstname+"</strong> to the event <strong>"+attendee.event.name+"</strong> on Go Dutch! <a href='http://localhost:3000/payments/new/"+attendee_id+"'>Follow this link to participate!</a><p><br></div></body></html>"


	    m = Mandrill::API.new
			message = {  
			 :subject=> "Hey "+r_firstname+", wanna go to "+attendee.event.name+"?",  
			 :from_name=> "Go Dutch App",  
			 :text=>"Hi, how are you?",  
			 :to=>[  
			   {  
			     :email=> "godutchteam@gmail.com", #should be r_email  
			     :name=> r_firstname  
			   }  
			 ],  
			 :html=>email_body,  
			 :from_email=>"godutchteam@gmail.com"  
			}  
			sending = m.messages.send message  
			puts sending
	  end
		response.headers['X-PJAX-URL'] = "http://localhost:3000/events/confirmation"
	  render 'events/confirmation'
	end 
end