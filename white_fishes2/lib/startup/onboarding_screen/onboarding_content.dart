import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  OnboardingContent({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.child,
    required this.isShow,
    required this.onPressedGoNextPage,
    required this.scaffoldKey,
  });

  final bool isShow;
  final Widget child;
  final Function() onPressedGoNextPage;
  final String title, subtitle, image;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 60),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 238, 238, 238),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xff1B2124),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Text(subtitle,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 146, 146, 146),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center),
              SizedBox(height: 30),
              child,
              isShow
                  ? SizedBox.shrink()
                  : SizedBox(
                      width: 100,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: onPressedGoNextPage,
                        child: const Text(
                          'Suivant',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      )
    ]);
  }

  /// General Methods:-----------------------------------------------------------
}
