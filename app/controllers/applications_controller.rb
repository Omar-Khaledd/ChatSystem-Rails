class ApplicationsController < ApplicationController
	
	#GET/applications
	def getAllApplications
		@applications = Application.all
		render json: @applications
	end

	#POST/applications
	def createApplication
		@appName = params['Name'] 
		if !@appName.blank?
			@newApplication = Application.new({name:@appName.strip}) #Trim leading and trailing white spaces
			if @newApplication.save
				render json: "Application created successfully"
			else
				render json: {error:'Unable to create application'}, status: 400
			end
		else 
			render json: {error: 'Please enter application name'}
		end
	end

	def getAppByToken
		@token = params[:token]
		@application = Application.find_by token: @token
		if @application
			render json: @application
		else
			render json: {error: `Can't find application with this token.`}, status:400
		end
	end
end
