import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/core/route/app_router_config.dart';
import 'package:recipe/core/services/beral_container.dart';
import 'package:recipe/core/services/dependency_injection.dart';
import 'package:recipe/core/util/app_color.dart';
import 'package:recipe/feature/splash/presentation/widget/splash_logo_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    context.read<HomecategoryBloc>().add(FetchHomeCategories());
    context.read<HomeRecipeBloc>().add(
      const GetRecipeEvent(categoryName: "beef"),
    );
    hideKeyBoard();
    changeStatusColor();
    Future.delayed(const Duration(seconds: 2), initalizeMove);
  }

  Future<void> hideKeyBoard() async =>
      await SystemChannels.textInput.invokeMethod('TextInput.hide');

  void changeStatusColor() => SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );

  void initalizeMove() async {
    if (sl<SharedPreferences>().getBool("IsLogedIn") ?? false) {
      context.pushReplacement(AppRouterConfig.dashBoardRoute);
    } else {
      await _preCacheImage();
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
          context.go(AppRouterConfig.getStarted);
      }
    }
  }

  Future<void> _preCacheImage() async {
    final dp = MediaQuery.of(context).devicePixelRatio;
    final size = MediaQuery.sizeOf(context);
    await precacheImage(
      ResizeImage(
        const AssetImage(AppImages.welcome),
        height: (size.height * 0.75 * dp).toInt(),
        width: (size.width * dp).toInt(),
      ),
      context,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: SplashLogoWidget(key: ValueKey('splash_logo_holder')),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            mainAxisSize: .min,
            spacing: 2,
            children: [
              const Text(
                'Version: 1.0.0',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: AppColor.textDisable),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'Crated with ❤️ by ',
                  style: TextStyle(color: Colors.black, fontSize: 13),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Saravanan V',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
