import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/user_role.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/app_logo_header.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/role_selection_card.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Responsive.contentWidth(context) > 600
                  ? 560
                  : Responsive.contentWidth(context),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  AppLogoHeader(
                    title: 'app_name'.tr,
                    subtitle: 'app_subtitle'.tr,
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'select_profile'.tr,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'select_profile_desc'.tr,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: UserRole.values.length,
                      itemBuilder: (context, index) {
                        final role = UserRole.values[index];
                        return RoleSelectionCard(
                          role: role,
                          isSelected: controller.selectedRole.value == role,
                          onTap: () => controller.selectRole(role),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(() {
                    final error = controller.errorMessage.value;
                    if (error == null) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        error,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
                  Obx(
                    () => PrimaryButton(
                      label: 'enter_dashboard'.tr,
                      icon: Icons.dashboard_outlined,
                      isLoading: false,
                      onPressed: controller.selectedRole.value == null
                          ? null
                          : controller.continueAsGuest,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        side: BorderSide(
                          color: AppColors.accent.withValues(alpha: 0.6),
                        ),
                      ),
                      icon: const Icon(Icons.login, size: 20, color: AppColors.accent),
                      label: Text(
                        'sign_in_google'.tr,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: controller.selectedRole.value == null ||
                              controller.isSigningIn.value
                          ? null
                          : controller.signInWithGoogle,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
