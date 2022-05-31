import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/modules/login/select_user.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/constants.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/profile.jpg',
        title: 'on Board 1 title',
        body: 'on Board 1 title'),
    BoardingModel(
        image: 'assets/images/profile.jpg',
        title: 'on Board 2 title',
        body: 'on Board 2 title'),
    BoardingModel(
        image: 'assets/images/profile.jpg',
        title: 'Choose Who Will Make Account...?',
        body: 'If you parent select right one , if you child select left one'),
  ];

  bool isLast = false;

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value)
      {
        navigateAndFinis(context, SelectUser());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(onPressed: ()
          {
            setState(() {
              submit();
            });
            
          },
              child: Text('Skip',
              style: TextStyle(fontSize: 20.0,
                color: mainColor,
              ),
              ),)
        ],
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                controller: boardController,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: mainColor,
                    dotHeight: 10.0,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(onPressed: ()
                {
                  if(isLast)
                  {
                    setState(() {
                      submit();
                    });
                    
                  }
                  else
                    {
                      boardController.nextPage(duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    }

                },
                child: Icon(Icons.arrow_forward_ios,),backgroundColor: mainColor,)
              ],
            )
          ],
        ),
      ),
    );
  }


  //////////////////////////////////////////////   BoardingItem   ///////////////////////////////////////////////////////////


  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Image(image: AssetImage('${model.image}'))),
          SizedBox(
            height: 10.0,
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 50.0,
          ),
        ],
      );
}
