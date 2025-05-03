import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smar_bin/modules/Auth.dart';
import 'package:smar_bin/services/SharedPrefsHelper.dart';
import 'package:smar_bin/shared/components/navigator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<OnBoardingModel> boarding = [
    OnBoardingModel(
      image: 'assets/images/welcome.png',
      title: 'Welcome to Smart Waste Management!',
      body: 'Take the first step towards a cleaner, greener environment. '
          'Our smart trash bin solution makes waste sorting effortless and '
          'eco-friendly.',
    ),
    OnBoardingModel(
      image: 'assets/images/questionning.png',
      title: 'How It Works',
      body: 'Simply dispose of your waste — our AI-powered system classifies, '
          'tracks, and manages it, ensuring hygiene and environmental compliance.',
    ),
    OnBoardingModel(
      image: 'assets/images/earn.png',
      title: 'Earn & Contribute',
      body:
      'Collect points with every correct disposal. '
          'Scan your QR code to track your impact and help create a sustainable future.',
    ),
  ];

  final _boardingController = PageController();

  bool isLast = false;

  late String selectedLang;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLang();
  }

  Future<void> getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String langCode = prefs.getString('language') ?? 'en';  // Default to 'en' if no preference is found
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              noBackPush(
                context: context,
                direction: AuthScreen(),
              ).then((_)=>SharedPrefsHelper.saveOnBoarding(true));
            },
            child: const Text(
              'SKIP',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _boardingController,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    isLast = false;
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: 3,
                physics: const BouncingScrollPhysics(),
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: _boardingController,
                  effect: WormEffect(
                    activeDotColor: Theme.of(context).primaryColor,
                  ),
                  count: boarding.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (isLast == true) {
                      noBackPush(
                        context: context,
                        direction: AuthScreen(),
                      ).then((_)=>SharedPrefsHelper.saveOnBoarding(true));
                    } else {
                      _boardingController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.decelerate,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(OnBoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage(model.image),
        ),
      ),
      const SizedBox(height: 30.0),
      Text(
        model.title,
        style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w600
        ),
      ),
      const SizedBox(height: 12.0),
      Text(
        model.body,
        style: const TextStyle(
          fontSize: 14.0,
        ),
      ),
    ],
  );
}

class OnBoardingModel {
  final String image;
  final String title;
  final String body;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}
