import 'package:flutter/material.dart';
import 'package:flutter_application_depi/model/onboardingmodel.dart';
import 'package:flutter_application_depi/utils/constants/Routes/route.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/custom_buttons.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/custom_pageview_doted.dart';

class PageViewBoarding extends StatefulWidget {
  const PageViewBoarding({Key? key}) : super(key: key);
  @override
  _PageViewBoardingState createState() => _PageViewBoardingState();
}

class _PageViewBoardingState extends State<PageViewBoarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < onBoardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushNamed(context, Routes.gender);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E4B),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: onBoardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  
                  child: Container(
                    height: screenHeight - 40,
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Column(

                      children: [
                        SizedBox(height: screenHeight * 0.05),
                        Container(
                          width: screenWidth * 0.6,
                          height: screenWidth * 0.6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(onBoardingData[index].image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        Text(
                          onBoardingData[index].text,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05),
                          child: Text(
                            onBoardingData[index].text,
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        CustomPageViewDotted(currentPage: _currentPage),
                        const Spacer(),
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: screenHeight * 0.04,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: CustomRowButton(
                  width: screenWidth,
                  height: screenHeight,
                  onPressed: _nextPage,
                  onBack: _previousPage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
