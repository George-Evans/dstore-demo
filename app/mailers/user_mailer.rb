class UserMailer < ApplicationMailer
	default from: "store@defectedstore.com"

	def contact_form(email, name, message)
		@message = message
			mail(from: email, to: "georgeevansarts@gmail.com", subject: "New message from DStore contact form from #{@name}")
		end
	end
