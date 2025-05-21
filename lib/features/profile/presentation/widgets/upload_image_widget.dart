import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/usecases/utils_usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/app_elevated_button.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/app_colors.dart';

class UploadImageWidget extends StatelessWidget {
  const UploadImageWidget({super.key});

  Future<String> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    return UtilsUsecase.convertToBase64(image);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: AppElevatedButton(
            leadingIcon: const Icon(Icons.camera_alt),
            onPressed: () async {
              final image = await _pickImage(ImageSource.camera);
              if (context.mounted) Navigator.pop(context, image);
            },
            title: AppLocalizations.of(context)!.camera,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            foregroundColor: Theme.of(context).colorScheme.primary,
            borderColor: AppColors.neutral90,
            isUppercase: false,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          ),
        ),
        Expanded(
          child: AppElevatedButton(
            leadingIcon: const Icon(Icons.image),
            onPressed: () async {
              final image = await _pickImage(ImageSource.gallery);
              if (context.mounted) Navigator.pop(context, image);
            },
            title: AppLocalizations.of(context)!.gallery,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            foregroundColor: Theme.of(context).colorScheme.primary,
            borderColor: AppColors.neutral90,
            isUppercase: false,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          ),
        ),
      ],
    );
  }
}
