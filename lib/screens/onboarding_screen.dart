import 'package:flutter/material.dart';
import '../models/onboard_data.dart';
import '../widgets/onboard_navigation_button.dart';
import '/constants/constant.dart';
import '/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen(

    {Key? key}) : super(key: key);



  skipPage(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (_)=> SignUpScreen(),),);
  }

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  final PageController pageController = PageController();
  int currentPage = 0;
  bool lastPage = false;
  
 
  AnimatedContainer dotIndicator(int page) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: 5,),
      //
      duration: Duration(microseconds: 400),
      height: page == currentPage ? 12:6,
      width: page == currentPage ? 12:6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: page == currentPage ? Colors.blue : Colors.grey,
      ),
      
    );
  }

  setSeenBoard() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //It will set seenOnBoard to true when running onboard page for first time.
    final seenOnBoard = preferences.setBool("seenOnBoard", true);
  }

  @override
  void initState() {
    super.initState();
    setSeenBoard();
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: basePadding,
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: PageView.builder(
                  controller: pageController,
                  
                  onPageChanged: (page) {
                    setState(() {
                      currentPage = page;
                      if(currentPage == onboardingDataList.length-1){
                        lastPage = true;
                      }
                      else{
                        lastPage = false;
                      }
                    
                    });
                  },
                  itemCount: onboardingDataList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                       
                        Container(
                          height: 300,
                          child: Image.asset(
                            onboardingDataList[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                         Text(
                          onboardingDataList[index].title,
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                        
                        SizedBox(
                          height: 30,
                        ),
                         Text(
                          onboardingDataList[index].subtitle,
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        ),
                        
                        
                       
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                   
                         Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OnBoardNavigationButton(
                                name: lastPage ? "": "Skip",
                                onPressed: () {
                                  lastPage ? null
                                  :widget.skipPage(context);
                                  
                                
                                },
                              ),
                              Row(
                                children: List.generate(
                                  onboardingDataList.length,
                                  (index) => dotIndicator(index),
                                ),
                              ),
                              OnBoardNavigationButton(
                                name: lastPage ? "Done" : "Next",
                               
                                onPressed: () {
                                  lastPage ? widget.skipPage(context)
                                  
                                  
                                  : pageController.nextPage(

                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.bounceInOut,
                                  );
                                },
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
