
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/shared/components/constants.dart';


void navigateTo(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context)=>widget,
    ),);
void navigateAndFinis(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context)=>widget,
    ),
    (Route<dynamic> route)=>false,
);


///////////////////////////////////////////////////////////////////////////////////////


// void showtoast({
//   @required String text,
//   @ required toastState state,
// })=>Fluttertoast.showToast(
//     msg: text,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 5,
//     backgroundColor: choseToastState(state),
//     textColor: Colors.white,
//     fontSize: 16.0
// );

// enum toastState{SUCCESS,ERROR,WARNING}

// Color choseToastState(toastState state)
// {
//   Color color;
//   switch(state)
//   {
//     case toastState.SUCCESS :
//       color = Colors.green;
//       break;
//     case toastState.ERROR :
//       color = Colors.red;
//       break;
//     case toastState.WARNING :
//       color = Colors.amber;
//       break;
//   }
//   return color;
// }


///////////////////////////////////////////////////////////////////////////////////////////


Widget InputContainer({
  final Widget child,
  Size size }
) => Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kPrimaryColor.withAlpha(50)
      ),

      child: child
    );


    
Widget RoundedButton (
  {
    final String title,
    Size size
  }
) => InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kPrimaryColor,
        ),

        padding: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),
        ),
      ),
    );




    Widget RoundedInput(
      {
      final String hint,
      bool isDefaultPassword,
  IconData suffixIcon,
  TextInputType keyboardType,
  Function onSubmit,
  bool isPassword =false,
  TextInputAction textInputAction=TextInputAction.next,
  Function onTap,
  @required IconData prefixIcon,
  @required TextEditingController controller,
  @required Function validate,
  Function suffixPressed,
  Function newSuffixPressed,
  }
    ) => InputContainer(
      child: TextFormField(
         controller: controller,
  onFieldSubmitted: onSubmit,
  obscureText: isPassword,
  validator: validate,
  onTap: onTap,
  keyboardType: keyboardType,
  textAlign: TextAlign.start,
  textInputAction: textInputAction,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
   suffixIcon: suffixIcon !=null ?  IconButton(
   onPressed: isDefaultPassword ? suffixPressed : newSuffixPressed,
    icon: Icon(suffixIcon)): null,
          hintText: hint,
          border: InputBorder.none
        ),
      ));













////////////////////////////////////////////////////////////////////////////////////////////



Widget defaultButton(
{
  double width= double.infinity,
  Color backcolor= Colors.blue,
  bool isUpperCase= true,
  double radius= 0.0,
  @required String text,
  @required Function function,

}
    )=>Container(
    width: width,
    height: 40.0,
    child: MaterialButton(
      onPressed: function,
    child: Text(isUpperCase ?text.toUpperCase():text,
    style: TextStyle(
      color: Colors.white,
    ),),
    ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backcolor,
      ),
);

Widget defaultTextFormField(
{
  bool isPassword =false,
  TextInputType keyboardType ,
  Function onSubmit,
  Function onChange,
  IconData suffixIcon,
  @required TextEditingController controller,
  @required String labelText,
  @required Function validate,
  @required IconData prefixIcon,
}
    )=> TextFormField(
      controller: controller,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      keyboardType: keyboardType,
      obscureText: isPassword,
      validator: validate,
      decoration: InputDecoration(
        labelText:labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon !=null ?Icon(suffixIcon):null,
      ),
);



Widget textField(
{
  bool isDefaultPassword,
  IconData suffixIcon,
  TextInputType keyboardType,
  Function onSubmit,
  bool isPassword =false,
  TextInputAction textInputAction=TextInputAction.next,
  Function onTap,
  @required IconData prefixIcon,
  @required TextEditingController controller,
  @required Function validate,
  @required String text,
  Function suffixPressed,
  Function newSuffixPressed,
}
    )=>TextFormField(
  controller: controller,
  onFieldSubmitted: onSubmit,
  obscureText: isPassword,
  validator: validate,
  onTap: onTap,
  keyboardType: keyboardType,
  textAlign: TextAlign.start,
  textInputAction: textInputAction,
  cursorRadius: Radius.circular(50.0),
  decoration: InputDecoration(
   prefixIcon: Icon(prefixIcon),
   suffixIcon: suffixIcon !=null ?  IconButton(
   onPressed: isDefaultPassword ? suffixPressed : newSuffixPressed,
    icon: Icon(suffixIcon)): null,
hintText: text,
border: InputBorder.none,

),
);






////////////////////////////////////////////////////////////////





Widget taskItem(
  Function pressed,
)
{
  return GestureDetector(
    onTap: pressed,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(
              radius: 45.0,
              child: Icon(Icons.menu_book_rounded,size: 40,),
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Task title",
                style: TextStyle(fontSize: 30.0,
                fontWeight: FontWeight.w400),),
                Text("2 april,2022",
                style: TextStyle(fontSize: 20.0,
                color: Colors.grey),)

              ],
            ),
          ],
        ),
      ),
    ),
  );
}


///////////////////////////////////////////////////////////////////////////////////



void showToast(
  {
    @required String text,
    @required ToastStates state,
  })
{
  Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0
    );
}


enum ToastStates {SUCCESS,ERROR,WARNING}

Color chooseToastColor (ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
    color = Colors.green;
    break;
    case ToastStates.ERROR:
    color = Colors.red;
    break;
    case ToastStates.WARNING:
    color = Colors.amber;
    break;
  }
  return color;

}
