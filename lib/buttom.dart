import 'package:flutter/material.dart';

class Butttom extends StatefulWidget {
  const Butttom({ Key key }) : super(key: key);

  @override
  State<Butttom> createState() => _ButttomState();
}

class _ButttomState extends State<Butttom> {

  var isclicked = false;
  double turns = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: AnimatedRotation(
            curve: Curves.easeInExpo,
            turns: turns,
            duration: const Duration(milliseconds: 500),
            child: GestureDetector(
              onTap: ()
              {
                if(isclicked)
                {
                  setState(() {
                    turns -=1/4;
                  });
                }else
                {
                  setState(() {
                    turns += 1/4;
                  });
                }
                isclicked = !isclicked;
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.deepPurple,
                  boxShadow: [BoxShadow(
                    blurRadius: 10.0,
                    offset: const Offset(10, 10),
                    color: Colors.grey,
                  ),
                  BoxShadow(
                    blurRadius: 10.0,
                    offset: const Offset(-10, -10),
                    color: Colors.white,
                  )],
                ),
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Center(),
                  ),
              ),
            ),
             ),
      ),
    );
  }
}