import 'package:ecom_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/assets_path_constants.dart';
import '../../../../../core/presentation/widgets/eleveated_button_widget.dart';

class SignUpButtons extends StatelessWidget {
  const SignUpButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElvButtonWidget(
          textContent: TTextConstants.signUpGoogle,
          onPressed: () {},
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF181D31),
          leadingIcon: Image.asset(
            TAssetsPath.googleIcon,
            height: 24,
          ),
          side: const BorderSide(
            color: Color(0xFFEAEAEA),
          ),
        ),
        const SizedBox(height: 20),
        ElvButtonWidget(
          textContent: TTextConstants.signUpFacebook,
          onPressed: () {},
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF181D31),
          leadingIcon: Image.asset(
                       TAssetsPath.facebookIcon,
            height: 24,
          ),
          side: const BorderSide(
            color: Color(0xFFEAEAEA),
          ),
        ),
      ],
    );
  }
}
