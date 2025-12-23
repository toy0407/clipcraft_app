import 'package:clipcraft/core/theme/app_text_styles.dart';
import 'package:clipcraft/features/auth/controllers/auth.contoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final auth = Get.find<AuthController>();

    const purposes = <String>['Social Media', 'Education', 'Marketing', 'Personal', 'Business', 'Explore', 'Other'];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                'Complete your profile',
                style: AppTextStyles.headlineLarge.copyWith(color: colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text('Setup your profile to start creating amazing videos', style: textTheme.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: 32),
              Text('Full Name', style: AppTextStyles.bodyLarge),
              const SizedBox(height: 14),
              Obx(
                () => TextField(
                  controller: auth.nameController,
                  keyboardType: TextInputType.name,
                  autocorrect: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outline),
                    labelText: 'Enter your full name',
                    errorText: auth.nameError.value.isEmpty ? null : auth.nameError.value,
                  ),
                  onChanged: (value) {
                    if (auth.nameError.value.isNotEmpty) {
                      auth.nameError.value = '';
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              Text('Purpose', style: AppTextStyles.bodyLarge),
              const SizedBox(height: 12),
              Obx(
                () => ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
                    stops: [0.0, 0.03, 0.97, 1.0],
                  ).createShader(bounds),
                  blendMode: BlendMode.dstIn,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: purposes.map((purpose) {
                        final isSelected = auth.videoPurpose.value == purpose;
                        return Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: AnimatedScale(
                            scale: isSelected ? 1.05 : 1.0,
                            duration: const Duration(milliseconds: 150),
                            child: ChoiceChip(
                              label: Text(purpose),
                              selected: isSelected,
                              onSelected: (_) => auth.videoPurpose.value = purpose,
                              selectedColor: colorScheme.primaryContainer,
                              labelStyle: TextStyle(
                                color: isSelected ? colorScheme.onPrimaryContainer : colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: auth.isSignupButtonLoading.value
                        ? null
                        : () {
                            FocusScope.of(context).unfocus();
                            auth.register();
                          },
                    child: auth.isSignupButtonLoading.value
                        ? SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: colorScheme.onPrimary, strokeWidth: 2.4))
                        : Text('Register', style: AppTextStyles.buttonText),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
