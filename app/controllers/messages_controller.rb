class MessagesController < ApplicationController
    def getMessagesOfChat
        @chatNumber = params[:chatNumber]
        @messages = Message.joins("INNER JOIN chats ON chats.id = messages.chat_id and chats.number = #{@chatNumber}")
        if !@messages.empty?
            render json: @messages
        else
            render json: {error: 'Chat is empty'}
        end
    end

    def createMessage
        @applicationToken = params[:token], @chatNumber = params[:chatNumber], @messageBody = request.params['MessageBody']
        @application = Application.find_by(token: @applicationToken)
        if @application.nil?
            render json: {error: 'Token is invalid'}
        end
        @chat = Chat.find_by(application_id: @application.id, number: @chatNumber)
        #If chat number is not correct
        if @chat.nil?
            render json: {error: 'Chat number is not correct, no chat found'}, status:400
        else
            if !@messageBody.blank?
                #Get last message number in this chat
                @lastMessage = Message.select('MAX(number)').group(:chat_id).having('chat_id=' + (@chat.id).to_s)
                #If first message to be inserted start numbering from 1
                if @lastMessage.empty?
                    @number = 1
                else
                    @number = @lastMessage[0]['MAX(number)'] + 1
                end
                #Create new Message Object
                @newMessage = Message.new(chat_id: @chat.id, message_body: @messageBody.strip, number: @number) #Trim leading and trailing white spaces
                #Save the message and update messages count in Chat table
                if @newMessage.save
                    @chat.update(messages_count: @chat.messages_count+1)
                    render json: {message: "Number of message created is #{@newMessage.number}"}
                else
                    render json: {error: 'Unable to create message'}, status:400
                end
            else
                render json: {error: 'Please enter message body'}
            end
        end
    end

    def updateMessage
        @token = params[:token]
        @chatNumber = params[:chatNumber]
        @messageNumber = params[:messageNumber]
        @messageBody = params['MessageBody']
        puts @token
        @sql = "SELECT messages.id 
        from messages
        INNER JOIN chats on chats.id INNER JOIN applications on applications.id 
        WHERE applications.token = '#{@token}' and chats.number = #{@chatNumber} and messages.number = #{@messageNumber} 
        group by messages.id;"
        @data = ActiveRecord::Base.connection.exec_query(@sql)
        if @data.empty?
            render json: "No Chat found"
        else
            Message.update(@data[0]['id'], :message_body => @messageBody)
            render json: "Message updated successfully"
        end
    end


    def searchInChat
        @chatId = params[:chatId]
        @messageBody = params[:messageBody]
        unless @messageBody.blank?
            @results = Message.search(@messageBody)
            render json: @results
        end
    end

end
