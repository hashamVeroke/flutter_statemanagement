import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();
  bool showPhoneField = false;
  String selectedLang = "english".tr();

  final List<Map<String, dynamic>> pages = [
    {
      "color": Color(0xFFFF001F),
      "title": "slide1_title".tr(),
      "image": Icons.shopping_bag,
    },
    {
      "color": Color(0xFF148F96),
      "title": "slide2_title".tr(),
      "image": Icons.food_bank,
    },
    {
      "color": Color(0xFFDFA20C),
      "title": "slide3_title".tr(),
      "image": Icons.flight_takeoff,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background PageView
          PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (_) {
              setState(() => showPhoneField = false); // reset when slide changes
            },
            itemBuilder: (context, index) {
              final page = pages[index];
              return Container(
                color: page["color"],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(page["image"], size: 150, color: Colors.white),
                      const SizedBox(height: 30),
                      Text(
                        page["title"],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // 🔹 Language Toggle (Absolute Top)
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(20),
                isSelected: [
                  context.locale.languageCode == 'en',
                  context.locale.languageCode == 'ar'
                ],
                onPressed: (i) {
                  final locale = i == 0 ? const Locale('en') : const Locale('ar');
                  context.setLocale(locale);
                  setState(() {
                    selectedLang = i == 0 ? "english".tr() : "arabic".tr();
                  });
                },
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text("english".tr())),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text("arabic".tr())),
                ],
              ),
            ),
          ),

          // 🔹 Bottom controls (Absolute Bottom)
          Positioned(
            left: 16,
            right: 16,
            bottom: 30,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: pages.length,
                  effect: const WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Colors.white,
                    dotColor: Colors.white54,
                  ),
                ),
                const SizedBox(height: 20),

                if (!showPhoneField)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      setState(() => showPhoneField = true);
                    },
                    child: Text("get_started".tr()),
                  )
                else
                  Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixText: "+974 ",
                          hintText: "enter_phone_number".tr(),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          debugPrint("Continue pressed");
                        },
                        child: Text("continue".tr()),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
