import 'package:flutter/material.dart';
import 'package:chat/chatmessage.dart';
import 'package:firebase_database/firebase_database.dart';
 
final databaseReference = FirebaseDatabase.instance.reference();
class ChatScreen extends StatefulWidget {
  final product_name, name;
  ChatScreen(this.product_name ,this.name);
  @override
  State createState() => new ChatScreenState(this.name,this.product_name);
}
 
class ChatScreenState extends State<ChatScreen> {
 
  final TextEditingController _chatController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  final name,product_name;
  ChatScreenState(this.name,this.product_name);
  @override
  void initState() {
   
   // databaseReference = FirebaseDatabase.instance.reference();
    super.initState();
    getData();
  }
  void _handleSubmit(String text, String name) {
    _chatController.clear();
     //getData();
      ChatMessage message = new ChatMessage(
        text: text,
        name: name,
    );
     
    setState(() {
 
       _messages.insert(0, message);
       databaseReference.child(product_name).push().set({
         "name":name,
         "text":text
       });
      //getData();
      
    });
}
void getData(){
  databaseReference.child(product_name).once().then((DataSnapshot snapshot) {
    var text=snapshot.value;
     text.forEach((k ,v ) {
      ChatMessage message = new ChatMessage(
         name: v['name'],
        text: v['text'],
        
    );
     
  
  setState(() {
 
       _messages.insert(0, message);
       //databaseReference.child('chat').push().set(text);
      
    print(v['name']);    
    });
 //print(snapshot.value);
    });
  });
    
   
  
}
 
 
  Widget _chatEnvironment (){
    return IconTheme(
      data: new IconThemeData(color: Colors.blue),
          child: new Container(
        margin: const EdgeInsets.symmetric(horizontal:8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                decoration: new InputDecoration.collapsed(hintText: "Start typing ..."),
                controller: _chatController,
               // onSubmitted: _handleSubmit(),
              ),
            ),
            new Row(
              //margin: const EdgeInsets.symmetric(horizontal: 4.0),
              children:<Widget>[
               new IconButton(
                icon: new Icon(Icons.send),
                
                onPressed: ()=>_handleSubmit(_chatController.text,"Anonymous")
                 
              ),
              new IconButton(
                icon: new Icon(Icons.send),
                
                onPressed: ()=>_handleSubmit(_chatController.text,this.name)
                 
              ),
              ]
            )
          ],
        ),
 
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
     // home: 
     body:
      Column(
        children: <Widget>[
          new Flexible(
            child: ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          new Divider(
            height: 1.0,
          ),
          new Container(decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: _chatEnvironment(),)
        ],
      ),
    );
        }
}
 
 
 
 

