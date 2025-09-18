import 'package:bloc_example/utils/ui_util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/services.dart';
import '../../../core/network/base_client.dart';
import '../../../utils/shared_widgets/buttons/app_button.dart';
import '../../../utils/shared_widgets/input_fields/phone_input.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();
  bool isStarted = false;
  int selectedLanguageIndex = 0;
  int currentPage = 0;
  Map<String, dynamic>? phoneData;

  final List<Map<String, dynamic>> pages = [
    {
      "color": Color(0xFFFF001F),
      "title": "slide1_title",
      "image": Icons.shopping_bag,
    },
    {
      "color": Color(0xFF148F96),
      "title": "slide2_title",
      "image": Icons.food_bank,
    },
    {
      "color": Color(0xFFDFA20C),
      "title": "slide3_title",
      "image": Icons.flight_takeoff,
    },
  ];
  void languageHandler(i) async {
    final locale = i == 0 ? const Locale('en') : const Locale('ar');
    context.setLocale(locale);
    await BaseClient.setLanguage(i == 0 ? 'en' : 'ar');
    setState(() {
      selectedLanguageIndex = i;
    });
  }

  void buttonHandler() {
    if (isStarted) {
      return;
    }
    setState(() {
      isStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color statusColor = pages[currentPage]["color"] as Color;
    final Brightness bgBrightness = ThemeData.estimateBrightnessForColor(
      statusColor,
    );
    final SystemUiOverlayStyle overlay = SystemUiOverlayStyle(
      statusBarColor: statusColor,
      statusBarIconBrightness: bgBrightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      statusBarBrightness: bgBrightness == Brightness.dark
          ? Brightness.dark
          : Brightness.light,
    );
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlay,
        child: Stack(
          children: [
            // 🔹 Background PageView
            PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
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
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => languageHandler(0),
                      style: TextButton.styleFrom(
                        backgroundColor: selectedLanguageIndex == 0
                            ? AppColors.black
                            : Colors.white,
                        foregroundColor: selectedLanguageIndex == 0
                            ? Colors.white
                            : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              selectedLanguageIndex == 0 ? 20 : 0,
                            ),
                            bottomLeft: Radius.circular(
                              selectedLanguageIndex == 0 ? 20 : 0,
                            ),
                            topRight: Radius.circular(
                              selectedLanguageIndex == 0 ? 0 : 20,
                            ),
                            bottomRight: Radius.circular(
                              selectedLanguageIndex == 0 ? 0 : 20,
                            ),
                          ),
                        ),
                      ),
                      child: const Text(
                        'English',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    TextButton(
                      onPressed: () => languageHandler(1),
                      style: TextButton.styleFrom(
                        backgroundColor: selectedLanguageIndex == 1
                            ? AppColors.black
                            : Colors.white,
                        foregroundColor: selectedLanguageIndex == 1
                            ? Colors.white
                            : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                              selectedLanguageIndex == 1 ? 0 : 20,
                            ),
                            bottomRight: Radius.circular(
                              selectedLanguageIndex == 1 ? 0 : 20,
                            ),
                            topLeft: Radius.circular(
                              selectedLanguageIndex == 1 ? 20 : 0,
                            ),
                            bottomLeft: Radius.circular(
                              selectedLanguageIndex == 1 ? 20 : 0,
                            ),
                          ),
                        ),
                      ),
                      child: const Text('عربي', style: TextStyle(fontSize: 16)),
                    ),
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

                  Column(
                    children: [
                      if (isStarted)
                        PhoneInput(
                          initialIsoCode: 'QA',
                          hintText: "enter_phone_number".tr(),
                          onChanged: (payload) {
                            setState(() {
                              phoneData = {
                                "phoneNumber": payload.phoneNumber,
                                "countryCode": payload.countryCode,
                                "country": payload.country,
                                "isPhoneValid": payload.isPhoneValid,
                              };
                            });
                            // payload.number.phoneNumber (E.164), payload.isoCode, payload.dialCode, payload.countryName
                          },
                        ),
                      const SizedBox(height: 12),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,
                        transitionBuilder: (child, animation) {
                          final offsetAnim = Tween<Offset>(
                            begin: const Offset(0, 0.2),
                            end: Offset.zero,
                          ).animate(animation);
                          return SlideTransition(
                            position: offsetAnim,
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        child: MediaQuery.of(context).viewInsets.bottom == 0
                            ? AppButton(
                                key: const ValueKey('cta-visible'),
                                disabled:
                                    !(phoneData?['isPhoneValid'] ?? false) &&
                                    isStarted,
                                title: isStarted
                                    ? "continue".tr()
                                    : "get_started".tr(),
                                onPressed: buttonHandler,
                                color: AppColors.black,
                              )
                            : const SizedBox.shrink(
                                key: ValueKey('cta-hidden'),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
