import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/helpers/app_validators.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/widgets/error_bottom_sheet.dart';
import 'package:sham_booking/features/auth/data/models/sign_up_user_request_model.dart';
import 'package:sham_booking/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:sham_booking/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:sham_booking/features/auth/presentation/widgets/terms_text.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late final TextEditingController fullNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController phoneController;
  late final TextEditingController nationalityController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneController = TextEditingController();
    nationalityController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    nationalityController.dispose();

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
                Navigator.of(context).pop();
              },
              errorMessage:
                  state.errorMessage ?? 'Error occurred, please try again.',
            ),
          );
          return;
        } else if (state.status == AuthStatus.success) {
          context.go('/emailVerification');
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextField(
                label: 'Full Name',
                hint: 'E.g., Layla K.',
                icon: Icons.person_outline,
                controller: fullNameController,
                validator: AppValidators.validateFullName,
              ),
              16.verticalSpace,
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
              16.verticalSpace,
              CustomTextField(
                label: 'Phone',
                hint: '+963XXXXXXXXX',
                icon: Icons.phone,
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
              16.verticalSpace,
              CustomTextField(
                label: 'Nationality',
                hint: 'Syrian',
                icon: Icons.flag,
                controller: nationalityController,
              ),
              16.verticalSpace,
              const TermsText(),
              32.verticalSpace,
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed:
                      (!state.isAgreeTerms ||
                          state.status == AuthStatus.loading)
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              SubmitSignUpUserEvent(
                                request: SignUpUserRequestModel(
                                  name: fullNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text.isEmpty
                                      ? null
                                      : phoneController.text,
                                  nationality:
                                      nationalityController.text.isEmpty
                                      ? null
                                      : nationalityController.text,
                                ),
                              ),
                            );
                          }
                        },
                  child: state.status == AuthStatus.loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'CREATE ACCOUNT',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 20),
                          ],
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
