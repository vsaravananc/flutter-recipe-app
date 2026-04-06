import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/core/route/app_router_config.dart';
import 'package:recipe/feature/home/presentation/bloc/home_category_bloc/homecategory_bloc.dart';
import 'package:recipe/feature/home/presentation/bloc/home_recipe_bloc/recipe_bloc.dart';

class SplashLogoWidget extends StatefulWidget {
  const SplashLogoWidget({super.key});

  @override
  State<SplashLogoWidget> createState() => _SplashLogoWidgetState();
}

class _SplashLogoWidgetState extends State<SplashLogoWidget> {
  ValueNotifier<String> logo = ValueNotifier(AppImages.logoLight);

  @override
  void didChangeDependencies() {
    Brightness brightness = Theme.of(context).brightness;
    if (brightness == Brightness.dark) {
      logo.value = AppImages.logoDark;
    } else {
      logo.value = AppImages.logoLight;
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
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

  void initalizeMove() {
    context.go(AppRouterConfig.welcomeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: logo,
      builder: (c, v, _) => Container(
        key: const ValueKey('logo_holder'),
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(v), fit: BoxFit.fill),
        ),
      ),
    );
  }
}
