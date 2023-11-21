import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../src/view/product_page.dart';
import '../nav.dart';
import 'onboarding_content.dart';

class OnboardingScreen extends StatefulWidget {

  @override
  _OnboardingState createState() => _OnboardingState();

}

class _OnboardingState extends State<OnboardingScreen> {

  // secondary variable
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPage = 0;
  late PageController pageController;


  @override
  void initState(){
    super.initState();
    pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return   WillPopScope(
      onWillPop: () => willPop(context,title: "Voulez-vous vraiment quitter?"),
      child: Scaffold(
        backgroundColor: Color(0xFFF7F7FC),
        key: _scaffoldKey,
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              Positioned(
                top: 30,
                right: 10,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: currentPage == OnboardingData.length-1?0:1,
                  child: TextButton(
                    onPressed:(){
                      onAddButtonTapped(2);
                    },
                    child: const Text(
                      "Passer",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color:Colors.red,
                          fontSize:  16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: 50,
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: OnboardingData.length,
                  itemBuilder: (context, index){
                    int length = OnboardingData.length;
                    return OnboardingContent(
                      title: OnboardingData[index].title!,
                      subtitle: OnboardingData[index].description!,
                      image: OnboardingData[index].image!,
                      scaffoldKey: _scaffoldKey,
                      isShow:length-1 == index,
                      onPressedGoNextPage: () {
                        pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
                      },
                      child:length-1 == index ? buttonWidgets() :SizedBox.shrink(),

                    );
                  },
                ),
              ),

              Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: widgetDot()
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget buttonWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        SizedBox(
          width: Get.width,
          height: 50,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
             Get.to(ProductPage());
            },
            child: const Text(
              'Commencer Maintenant',
              style: TextStyle(
                  color: Colors.white,
                  
                  fontSize: 16),
            ),
          ),
        ),
       
      ],
    );
  }


  Widget widgetDot() {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        OnboardingData.length,
            (index) => buildDot(index: index),
      ),
    );
  }


  /// General Methods:-----------------------------------------------------------
  void onAddButtonTapped(int index) {
    pageController.jumpToPage(index);
  }
  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration:  Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 6 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.red :  Colors.grey.withOpacity(0.6),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class OnboardingModel{
  String? image;
  String? title;
  String? description;
  Widget? child;
  OnboardingModel({this.image, this.title, this.description, this.child});
}
List<OnboardingModel> OnboardingData = [
  OnboardingModel(
    image:"assets/images/on1.jpg",
    title:"Les meilleurs poissons à votre portée" ,
    description:"Ajouter à votre panier vos poissons en cliquant sur le bouton ""AJOUTER""." ,),
  OnboardingModel(
    image:"assets/images/on2.jpg",
    title:"Ajouter des compléments." ,
    description:"Ajoutez des suppléments si nécessaire à votre commande et confirmez votre achat." ,),
  OnboardingModel(
    image:"assets/images/on3.jpg",
    title:"Service de livraison rapide.",
    description:"Recevez votre commande en un temps record en renseignant simplement vos informations." ,),
];