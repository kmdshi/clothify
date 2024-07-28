import 'package:ecom_app/core/constants/assets_path_constants.dart';
import 'package:ecom_app/src/features/auth/presentation/widgets/input_field_widget.dart';
import 'package:ecom_app/src/features/settings/presentation/widgets/language_selector.dart';
import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late final TextEditingController _languageTextController;
  final Map<String, String> languages = {
    'English': TAssetsPath.unitedKingdomFlag,
    'Bahasa Indonesia': TAssetsPath.indonesiaFlag,
    'Chinese': TAssetsPath.chinaFlag,
    'Deutsch': TAssetsPath.germanyFlag,
  };
  String _selectedLangauge = 'English';

  @override
  void initState() {
    _languageTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Language'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CstInputFiled(
              controller: _languageTextController,
              textContent: 'Search language',
              titleContent: '',
              isPassword: false,
              isPasswordVisible: false,
              pathToIcon: TAssetsPath.searchIcon,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: languages.entries.map((entry) {
                  final language = entry.key;
                  final iconLanguage = entry.value;
                  return Column(
                    children: [
                      LanguageSelector(
                        language: language,
                        iconLanguage: iconLanguage,
                        selectedLanguage: _selectedLangauge,
                        onTap: () => setState(() {
                          _selectedLangauge = entry.key;
                        }),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}