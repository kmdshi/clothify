import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:ecom_app/core/constants/assets_path_constants.dart';
import 'package:ecom_app/core/presentation/widgets/eleveated_button_widget.dart';
import 'package:ecom_app/core/services/snackbar_messages.dart';
import 'package:ecom_app/src/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:ecom_app/src/features/settings/presentation/widgets/change_input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isPasswordVisibleFirst = true;
  bool isPasswordVisibleSecond = true;
  bool _isMadeChanges = false;
  late final TextEditingController _firstPasswordConroller;
  late final TextEditingController _secondPasswordConroller;

  @override
  void initState() {
    _firstPasswordConroller = TextEditingController();
    _secondPasswordConroller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Image.asset(
            TAssetsPath.backShevrone,
            width: 30,
            height: 30,
          ),
        ),
        title: Text('Change password'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(15.0),
          child: Container(
            color: Colors.grey.withOpacity(0.15),
            height: 1.5,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.do_disturb_off,
            ),
          ),
        ],
      ),
      body: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsLoaded) {
            successMessage(
                context: context, content: 'Password changed successfully');
          } else if (state is SettingsFailure) {
            errorMessage(
                context: context,
                content: 'Something went wrong... ${state.message}');
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              ChangeInputFieldWidget(
                titleContent: 'New Password',
                controller: _firstPasswordConroller,
                icon: TAssetsPath.lockIcon,
                onChanged: _handleInputChange,
                visibleEyeIcon: TAssetsPath.visibleEyeIcon,
                noVisibleEyeIcon: TAssetsPath.noVisibleEyeIcon,
                iconColor: Colors.grey,
              ),
              const SizedBox(height: 15),
              ChangeInputFieldWidget(
                titleContent: 'Confirm Password',
                controller: _secondPasswordConroller,
                icon: TAssetsPath.lockIcon,
                onChanged: _handleInputChange,
                visibleEyeIcon: TAssetsPath.visibleEyeIcon,
                noVisibleEyeIcon: TAssetsPath.noVisibleEyeIcon,
                iconColor: Colors.grey,
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.45),
              _isMadeChanges
                  ? ElvButtonWidget(
                      textContent: 'Change now', onPressed: _onButtonPressed)
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  void _handleInputChange(bool isChanged) {
    setState(() {
      if (_firstPasswordConroller.text.isNotEmpty &&
          _secondPasswordConroller.text.isNotEmpty) {
        _isMadeChanges = true;
      } else {
        _isMadeChanges = false;
      }
    });
  }

  void _onButtonPressed() {
    if (_firstPasswordConroller.text != _secondPasswordConroller.text) {
      errorMessage(context: context, content: 'Passwords must be the same');
    } else {
      context
          .read<SettingsBloc>()
          .add(ChangePasswordEvent(newPassword: _firstPasswordConroller.text));
    }
  }
}