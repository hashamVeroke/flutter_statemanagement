import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneInput extends StatefulWidget {
  const PhoneInput({
    super.key,
    this.controller,
    this.onChanged,
    this.initialIsoCode = 'US',
    this.hintText,
    this.countries,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final String initialIsoCode;
  final String? hintText;
  final List<String>? countries; // ISO codes filter e.g. ['US','AE']
  final bool enabled;
  final ValueChanged<({PhoneNumber number, String? isoCode, String? dialCode, String? countryName})>? onChanged;

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  late final TextEditingController _controller;
  late PhoneNumber _initialNumber;
  static const Map<String, String> _isoToCountryName = {
    'QA': 'Qatar',
    'US': 'United States',
    'AE': 'United Arab Emirates',
    'SA': 'Saudi Arabia',
    'IN': 'India',
    'GB': 'United Kingdom',
  };

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _initialNumber = PhoneNumber(isoCode: widget.initialIsoCode);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 60,
      child: InternationalPhoneNumberInput(
        onInputChanged: (p0) {
          final iso = p0.isoCode;
          final countryName = iso != null ? _isoToCountryName[iso] : null;
          widget.onChanged?.call((
            number: p0,
            isoCode: iso,
            dialCode: p0.dialCode,
            countryName: countryName,
          ));
        },
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.DIALOG,
          setSelectorButtonAsPrefixIcon: true,
          leadingPadding: 8,
        ),
        initialValue: _initialNumber,
        countries: widget.countries,
        textFieldController: _controller,
        autoValidateMode: AutovalidateMode.disabled,
        ignoreBlank: false,
        formatInput: true,
        inputDecoration: InputDecoration(
          hintText: widget.hintText ?? 'Phone number',
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 18,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
        selectorTextStyle: Theme.of(context).textTheme.bodyMedium,
        textStyle: Theme.of(context).textTheme.bodyMedium,
        // inputBorder: const OutlineInputBorder(),
        keyboardType: const TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        spaceBetweenSelectorAndTextField: 0,
        isEnabled: widget.enabled,
      ),
    );
  }
}
