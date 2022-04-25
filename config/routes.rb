Rails.application.routes.draw do
  #Application Routes
  get "/applications", to: "applications#getAllApplications" #Get all applications
  get "/applications/:token", to: "applications#getAppByToken" #Get specific app by token
  post "/applications", to: "applications#createApplication" #Create new application

  #Chats Routes
  post "/applications/:token", to: "chats#createChat" #Create chat in app by app token
  get "/applications/:token/chats", to: "chats#getAllChats" #Get chats in app by app token
  get "/chats/:chatId/message/:messageBody", to: "messages#searchInChat" #Route to search on message inside a chat using ElasticSearch

  #Messages Routes
  get "/messages/:token/:chatNumber", to: "messages#getMessagesOfChat" #Get messages by chat number and app token
  post "/messages/:token/:chatNumber", to: "messages#createMessage" #Create message in chat by chat number and app token
  patch "/messages/:token/:chatNumber/:messageNumber", to: "messages#updateMessage" #Update message by message number and app token

end
