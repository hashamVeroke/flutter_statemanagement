import 'package:bloc_example/utils/shared_widgets/buttons/language_button.dart';
import 'package:bloc_example/utils/ui_util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/network/base_client.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();
  bool showPhoneField = false;
  // String selectedLang = "english".tr();

  final List<Map<String, dynamic>> pages = [
    {
      "color": AppColors.primary,
      "title": "slide1_title", // ❌ no .tr() here
      "image": Icons.shopping_bag,
    },
    {
      "color": AppColors.blueChill,
      "title": "slide2_title",
      "image": Icons.food_bank,
    },
    {
      "color": AppColors.gamboge,
      "title": "slide3_title",
      "image": Icons.flight_takeoff,
    },
  ];
  void languageHandler(i) async {
    print(i);
    final locale = i == 0 ? const Locale('en') : const Locale('ar');
    context.setLocale(locale);
    await BaseClient.setLanguage(i == 0 ? 'en' : 'ar');
    setState(() {
      // selectedLang = i == 0 ? "english".tr() : "arabic".tr();
    });
  }

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
              setState(
                () => showPhoneField = false,
              ); // reset when slide changes
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
                        page["title"]
                            .toString()
                            .tr(), // ✅ translate at build time
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
          LanguageButton(),

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
