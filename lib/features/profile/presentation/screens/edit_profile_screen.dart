import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/models/profile_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/providers/form_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/providers/profile_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_elevated_button.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/bottom_sheet_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/email_input_form_field_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/exception_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/horizontal_line_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/phone_input_form_field_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/profile_image_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/text_input_form_field_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/models/update_profile_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/presentation/providers/update_profile_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/presentation/widgets/upload_image_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/app_colors.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfileScreen> {
  String? _profileImage;

  FormGroup editProfileForm = FormGroup({
    'nameController': FormControl<String>(
      validators: [Validators.required],
    ),
    'emailController': FormControl<String>(
      validators: [Validators.required],
    ),
    'phoneController': FormControl<String>(
      validators: [Validators.required],
    ),
  });

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(formProvider.notifier).setFormGroup(editProfileForm);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizationsContext = AppLocalizations.of(context)!;

    final profileDetails = ref.watch(profileProvider);
    final form = ref.watch(formProvider);

    if (profileDetails.isLoading || !form.isInitialized) {
      return _getFormUi(
        context,
        Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );
    } else if (profileDetails.isFailure) {
      return _getFormUi(
        context,
        ExceptionWidget(
          description: profileDetails.message ?? '',
        ),
      );
    } else {
      updateFormData(profileDetails.profileData!);
      return _getFormUi(
          context,
          ReactiveForm(
              formGroup: editProfileForm,
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInputFormFieldWidget(
                    formControlName: 'nameController',
                    emptyMessage: localizationsContext.nameInputFormFieldEmptyMessage,
                  ),
                  EmailInputFormFieldWidget(
                    isReadOnly: true,
                  ),
                  const PhoneInputFormFieldWidget(),
                ],
              )));
    }
  }

  Widget _getFormUi(BuildContext context, Widget children) {
    final localizationsContext = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 2,
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                    color: AppColors.neutral90,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(localizationsContext.editProfile, style: Theme.of(context).textTheme.titleLarge),
                      IconButton(
                        icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onSecondaryContainer),
                        onPressed: () => context.pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    localizationsContext.editProfileDetails,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileImageWidget(
                        imageUrl: _profileImage,
                        hasCameraIcon: false,
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              localizationsContext.profilePicture,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              localizationsContext.profilePictureDetails,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: AppElevatedButton(
                          onPressed: () async {
                            final image = await showTheBottomSheet<String>(
                              title: localizationsContext.uploadImage,
                              context: context,
                              body: const UploadImageWidget(),
                            );
                            setState(() {
                              _profileImage = image;
                            });
                          },
                          title: localizationsContext.uploadImage,
                          foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                          borderColor: AppColors.neutral90,
                          borderRadius: 6,
                          isUppercase: false,
                          height: 32,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          leadingIcon: Icon(
                            size: 16,
                            Icons.file_upload_outlined,
                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                      Expanded(
                        child: AppElevatedButton(
                          onPressed: () {
                            setState(() {
                              _profileImage = '';
                            });
                          },
                          title: localizationsContext.remove,
                          foregroundColor: Theme.of(context).colorScheme.onError,
                          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                          borderColor: AppColors.neutral90,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          borderRadius: 6,
                          height: 32,
                          isUppercase: false,
                          leadingIcon: Icon(
                            size: 16,
                            Icons.delete_outline_rounded,
                            color: Theme.of(context).colorScheme.onError,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  const HorizontalLineWidget(
                    margin: EdgeInsets.only(bottom: 24),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: children,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24.0),
        child: Row(
          spacing: 16,
          children: [
            Expanded(
              child: AppElevatedButton(
                isDisable: ref.watch(profileProvider).isLoading || ref.watch(formProvider).isSubmissionInProgress,
                onPressed: () => context.pop(),
                title: AppLocalizations.of(context)!.cancel,
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                borderColor: AppColors.neutral90,
                isUppercase: false,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
            ),
            Expanded(
              child: AppElevatedButton(
                isDisable: !ref.watch(formProvider).isValid ||
                    ref.watch(profileProvider).isLoading ||
                    ref.watch(formProvider).isSubmissionInProgress,
                isLoading: ref.watch(formProvider).isSubmissionInProgress,
                onPressed: () async {
                  final result = await ref.read(formProvider.notifier).submitForm<bool>(() async {
                    final firstName = editProfileForm.control('nameController').value.toString().split(' ')[0];
                    final lastName =
                        editProfileForm.control('nameController').value.toString().split(firstName).last.trim();
                    final profileData = ref.read(profileProvider).profileData!;
                    return ref.read(updateProfileProvider.notifier).updateProfile(UpdateProfileModel(
                          firstName: firstName,
                          lastName: lastName,
                          email: editProfileForm.control('emailController').value,
                          phoneNumber: editProfileForm.control('phoneController').value,
                          itemId: profileData.data!.itemId,
                          profileImageUrl: _profileImage ?? profileData.data!.profileImageUrl,
                        ));
                  });
                  if (result) {
                    await ref.read(profileProvider.notifier).getData();
                    if (context.mounted) {
                      context.pop();
                    }
                  }
                },
                title: AppLocalizations.of(context)!.save,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                isUppercase: false,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateFormData(ProfileModel profileData) {
    editProfileForm.control('nameController').value = editProfileForm.control('nameController').value ??
        '${profileData.data?.firstName} ${profileData.data?.lastName}';
    editProfileForm.control('emailController').value =
        editProfileForm.control('emailController').value ?? profileData.data?.email;
    editProfileForm.control('phoneController').value =
        editProfileForm.control('phoneController').value ?? profileData.data?.phoneNumber;
  }
}
