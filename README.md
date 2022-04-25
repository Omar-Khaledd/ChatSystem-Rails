- Ruby :3.1.2
- Rails 7.0.2.3

### Installation
```
sudo docker-compose build
```
### Run Program
```
sudo docker-compose up
```

### Program Endpoints: 

|Entity|REST Method|URI|Parameters|Description|Body|
| :-: | :-: | :-: | :-: | :-: | :-: |
|Application|GET|/applications|-|Get all applications|-|
||GET|/applications/:token|Token of the application|Get specific application by token|-|
||POST|/applications|-|Create new application with name provided by the client|{Name: string}|
|Chat|GET|/applications/:token/chats|Token of the application|Get chats related to specific application by token|-|
||POST|/applications/:token/chats|Token of the application|Create new chat in an application|-|
|Message|GET|/applications/:token/chats/:chatNumber/messages|Token of the application, Number of chat in the application|Get all messages in specific chat by application token and chat number|-|
||POST|/applications/:token/chats/:chatNumber/messages|Token of the application, Number of chat in the application|Send new message in specific chat by application token and chat number|{MessageBody: string}|
||PATCH|/applications/:token/chats/:chatNumber/messages/:messageNumber|Token of the application, Number of chat in the application, Number of message|Update message body in specific chat by application token and chat number and message number|{MessageBody: string}|


