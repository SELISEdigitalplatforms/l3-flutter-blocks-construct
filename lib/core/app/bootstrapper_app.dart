import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/contracts/i_injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/logger/app_logging.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/storage/path_provider_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/providers/profile_provider.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/di/injection_container.dart' as features_injection_container;

class BootstrapperApp {
  final IInjectionContainer _coreInjectionContainer = InjectionContainer();
  final IInjectionContainer _featuresInjectionContainer = features_injection_container.InjectionContainer();
  final ProviderContainer _providerContainer = ProviderContainer();

  Future<void> init() async {
    await initLogger();
    await loadEnvironment();
    await PathProviderService.init();
    await _coreInjectionContainer.init();
    await _featuresInjectionContainer.init();
    await _providerContainer.read(profileProvider.notifier).getData();
  }

  Future<void> loadEnvironment() {
    const environments = {
      'stage': 'environments/.env.stage',
      'prod': 'environments/.env.prod',
    };
    const environment = String.fromEnvironment('ENV', defaultValue: 'stage');
    final filePath = environments[environment] ?? environments['stage'];
    logger.d(message: '======== Loaded environment:$environment ==========');
    return dotenv.load(fileName: filePath!);
  }
}
