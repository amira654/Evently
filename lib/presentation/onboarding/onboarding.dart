import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../core/resources/assets_manager.dart';
import '../../core/resources/colors_manager.dart';
import '../../core/routes_manager/routes_manager.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  Widget _buildImage(String imagePath) {
    return FadeInImage(
      placeholder: const AssetImage(ImageAssets.evently),
      image: AssetImage(imagePath),
      fit: BoxFit.contain,
      width: 300.w,
      height: 300.h,
    );
  }

  late PageDecoration pageDecoration;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final theme = Theme.of(context);
    pageDecoration = PageDecoration(
      imageAlignment: Alignment.center,
      imageFlex: 4,
      titleTextStyle: TextStyle(
        color: ColorsManager.blue,
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
      ),
      bodyTextStyle: TextStyle(
        fontSize: 16.sp,
        color: theme.textTheme.bodySmall?.color,
        fontWeight: FontWeight.w500,
      ),
      pageColor: theme.scaffoldBackgroundColor,
      imagePadding: EdgeInsets.only(top: 80.h, left: 16.w, right: 16.w),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        allowImplicitScrolling: false,
        infiniteAutoScroll: false,
        globalHeader: Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            bottom: true,
            child: Image.asset(ImageAssets.evently),
          ),
        ),
        pages: [
          PageViewModel(
            title: "Personalize Your Experience",
            body:
                "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
            image: _buildImage(ImageAssets.onBoarding1),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Find Events That Inspire You",
            body:
                "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
            image: _buildImage(ImageAssets.onBoarding2),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Effortless Event Planning",
            body:
                "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
            image: _buildImage(ImageAssets.onBoarding3),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Connect with Friends & Share Moments",
            body:
                "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
            image: _buildImage(ImageAssets.onBoarding4),
            decoration: pageDecoration,
          ),
        ],
        showBackButton: true,
        back: Icon(
          Icons.arrow_circle_left_outlined,
          size: 40.sp,
        ),
        next: Icon(
          Icons.arrow_circle_right_outlined,
          size: 40.sp,
        ),
        done: Text("Let's Start",
            style: TextStyle(color: Theme.of(context).primaryColor)),
        onDone: () {
          Navigator.pushReplacementNamed(context, RoutesManager.signIn);
        },
        dotsDecorator: DotsDecorator(
          size: const Size(10.0, 10.0),
          color: Colors.grey,
          activeSize: const Size(22.0, 10.0),
          activeColor: ColorsManager.blue,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
