import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/network/base_client.dart';
import '../../ui_util/app_colors.dart';

class LanguageButton extends StatefulWidget {
  const LanguageButton({super.key});

  @override
  State<LanguageButton> createState() => _LanguageButtonState();
}

class _LanguageButtonState extends State<LanguageButton> {
  int selectedIndex = 0;
  void languageHandler(i) async {
    final locale = i == 0 ? const Locale('en') : const Locale('ar');
    context.setLocale(locale);
    await BaseClient.setLanguage(i == 0 ? 'en' : 'ar');
    setState(() {
      selectedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                backgroundColor: selectedIndex == 0
                    ? AppColors.black
                    : Colors.white,
                foregroundColor: selectedIndex == 0
                    ? Colors.white
                    : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(selectedIndex == 0 ? 20 : 0),
                    bottomLeft: Radius.circular(selectedIndex == 0 ? 20 : 0),
                    topRight: Radius.circular(selectedIndex == 0 ? 0 : 20),
                    bottomRight: Radius.circular(selectedIndex == 0 ? 0 : 20),
                  ),
                ),
              ),
              child: const Text('English', style: TextStyle(fontSize: 16)),
            ),
            TextButton(
              onPressed: () => languageHandler(1),
              style: TextButton.styleFrom(
                backgroundColor: selectedIndex == 1
                    ? AppColors.black
                    : Colors.white,
                foregroundColor: selectedIndex == 1
                    ? Colors.white
                    : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(selectedIndex == 1 ? 0 : 20),
                    bottomRight: Radius.circular(selectedIndex == 1 ? 0 : 20),
                    topLeft: Radius.circular(selectedIndex == 1 ? 20 : 0),
                    bottomLeft: Radius.circular(selectedIndex == 1 ? 20 : 0),
                  ),
                ),
              ),
              child: const Text('عربي', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
