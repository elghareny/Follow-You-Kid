import 'package:flutter/material.dart';
import 'package:graduation_project/models/chat/theme/app_color.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/constants.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({ Key key }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller ;
  var message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Mohamed Said'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: ListView(
            primary: true,
            children: [
              chatBox(controller.toString(), true),
              
              
            ],
          ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey[300],
                      ),
                      padding: EdgeInsets.only(left: 10, top: 3, bottom: 3),
                      child: textField(
                        text: 'Typing....',
                        controller: message,
                        keyboardType: TextInputType.name,
                        prefixIcon: Icons.message_rounded,
                        validate: (value) {
                          if (message.text.isEmpty) {
                            return 'Name Must not be Empty';
                          }
                        },
                        onSubmit: (value) {
                        },
                      ),
                    ),
                ),
                SizedBox(width: 20,),
                CircleAvatar(
                  backgroundColor: mainColor,
                  radius: 27,
                  child: IconButton(icon: Icon(Icons.send),
                   onPressed: (){
                      setState(() {
                                            
                        });
                   },
                   color: Colors.white,
                   iconSize: 30.0,
                   ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}




Widget chatBox(String text, bool isFromMe){
  return Row(
    mainAxisAlignment: isFromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
    children: [
      Container(
        width: 220.0,
        margin: EdgeInsets.symmetric(vertical: 13.0 , horizontal: 12.0),
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: isFromMe ? mainColor : AppColor.textFieldColor,
          borderRadius: isFromMe ? BorderRadius.only(topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0) ,
          bottomRight: Radius.circular(0.0),
          bottomLeft: Radius.circular(15.0)
          ) :
          BorderRadius.only(topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0) ,
          bottomRight: Radius.circular(15.0),
          bottomLeft: Radius.circular(0.0)
          )
        ),
        child: Text(text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0
        ),),
      ),
    ],
  );
}