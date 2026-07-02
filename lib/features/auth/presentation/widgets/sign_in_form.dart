import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/helpers/app_validators.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';
import 'package:sham_booking/core/widgets/error_bottom_sheet.dart';
import 'package:sham_booking/features/auth/data/models/sign_in_user_request_model.dart';
import 'package:sham_booking/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:sham_booking/features/auth/presentation/widgets/custom_text_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state.status == AuthStatus.failure) {
          await showModalBottomSheet<void>(
            context: context,
            isDismissible: false,
            enableDrag: false,
            backgroundColor: Colors.transparent,
            builder: (_) => ErrorBottomSheet(
              onPressed: () async {
                Navigator.pop(context);
              },
              errorMessage:
                  state.errorMessage ?? 'Error occurred, please try again.',
            ),
          );
          return;
        } else if (state.status == AuthStatus.successVerify) {
          if (state.role == 'user') {
            context.go('/home');
          }
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: 'Email Address',
                hint: 'hello@example.com',
                icon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                validator: AppValidators.validateEmail,
              ),
              16.verticalSpace,
              CustomTextField(
                label: 'Password',
                hint: '••••••••',
                icon: Icons.lock_outline,
                isObscure: state.isPasswordObscure,
                onToggleVisibility: () {
                  context.read<AuthBloc>().add(TogglePasswordVisibility());
                },
                controller: passwordController,
                validator: AppValidators.validatePassword,
              ),
              24.verticalSpace,
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  onPressed: state.status == AuthStatus.loading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              SubmitSignInUserEvent(
                                request: SignInUserRequestModel(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              ),
                            );
                          }
                        },
                  child: state.status == AuthStatus.loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'SIGN IN',
                          style: AppTextStyles.normal12W600,
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
