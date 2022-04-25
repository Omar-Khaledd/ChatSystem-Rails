class ChatsController < ApplicationController
    def createChat
        @token = params[:token]
		@application = Application.find_by token: @token
        #If no application with this token is found
        if @application.nil?
			render json: {error: "Can't find application with this token."}, status:400
        else
            @lastChat = Chat.select('MAX(number)').group(:application_id).having('application_id=' + (@application.id).to_s)
            #If first chat to be inserted start numbering from 1
            if @lastChat.empty?
                @number = 1
            else
                @number = @lastChat[0]['MAX(number)'] + 1
            end
            @newChat = Chat.new(application_id: @application.id, number: @number)
            @application.update(chats_count: @application.chats_count + 1)
            if @newChat.save
                render json: {message: "Number of chat created is #{@newChat.number}"}
            else
                render json: {error: 'Unable to create chat'}, status:400
            end
        end
    end

    def getAllChats
        @token = params[:token]
        @application = Application.find_by token: @token
        if @application.nil?
            render json: {error: "Invalid application token"}
        else
            @chats = Chat.where("application_id = #{@application.id}")
            if @chats.empty?
                render json: {error: "Application has no chats"}
            else
                render json: @chats
                
            end
        end
    end
end
