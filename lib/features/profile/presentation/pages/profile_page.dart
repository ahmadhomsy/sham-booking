import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sham_booking/core/constants/app_string.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/helpers/storage_helper.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/widgets/error_bottom_sheet.dart';
import 'package:sham_booking/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:sham_booking/features/profile/presentation/widgets/payment_method_widget.dart';
import 'package:sham_booking/features/profile/presentation/widgets/profile_header.dart';
import 'package:sham_booking/features/profile/presentation/widgets/profile_header_shimmer.dart';
import 'package:sham_booking/features/profile/presentation/widgets/settings_section.dart';
import 'package:sham_booking/features/profile/presentation/widgets/sign_out_button.dart';
import 'package:sham_booking/features/profile/presentation/widgets/support_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) async {
        if (state.status == ProfileStatus.successSignOut) {
          context.go('/signIn');
        }
        if (state.status == ProfileStatus.failure) {
          await showModalBottomSheet<void>(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (_) => ErrorBottomSheet(
              onPressed: () async {
                Navigator.pop(context);
              },
              errorMessage: state.errorMessage!.tr(),
            ),
          );
          return;
        }
      },
      child: SafeArea(
        bottom: false,

        child: RefreshIndicator(
          color: AppColors.secondaryContainer,

          onRefresh: () async {
            context.read<ProfileBloc>().add(GetProfileEvent());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Container(
              width: double.infinity,
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: kToolbarHeight + 20.0,
                ),
                child: Column(
                  children: [
                    16.verticalSpace,
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state.status == ProfileStatus.loading) {
                          return const ProfileHeaderShimmer();
                        } else if (state.status == ProfileStatus.failure) {
                          return Text(
                            'home.profile.unable_to_load'.tr(),
                          );
                        }
                        return ProfileHeader(
                          name: state.name ?? 'home.profile.default_name'.tr(),
                          email:
                              state.email ?? 'home.profile.default_email'.tr(),
                        );
                      },
                    ),
                    24.verticalSpace,
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            if (state.hasPaymentMethod)
                              PaymentMethodWidget(
                                onUpdate: () {
                                  context.read<ProfileBloc>().add(
                                    UpdateProfileEvent(),
                                  );
                                },
                              ),

                            24.verticalSpace,

                            const SettingsSection(),

                            24.verticalSpace,

                            const SupportSection(),

                            24.verticalSpace,

                            const SignOutButton(),

                            100.verticalSpace,
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
