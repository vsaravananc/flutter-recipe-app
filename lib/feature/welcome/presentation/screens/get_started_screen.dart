import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/core/services/beral_container.dart';
import 'package:recipe/core/util/app_color.dart';
import 'package:recipe/feature/welcome/presentation/widgets/welcome_greetinganimation_widget.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dp = MediaQuery.of(context).devicePixelRatio;
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      body: SafeArea(
        top: false,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const SizedBox(height: double.infinity, width: double.infinity),
            SizedBox(
              width: double.infinity,
              height: size.height * 0.75,
              child: Container(
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.scaffoldBackground.withValues(alpha: 0.4),
                      Colors.transparent,
                      AppColor.scaffoldBackground,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Image.asset(
                  AppImages.welcome,
                  fit: BoxFit.cover,
                  cacheHeight: (size.height * 0.75 * dp).toInt(),
                  cacheWidth: (size.width * dp).toInt(),
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                        debugPrint('frame=$frame sync=$wasSynchronouslyLoaded');
                        return child;
                      },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: DraggableScrollableSheet(
                initialChildSize: 0.45,
                minChildSize: 0.45,
                maxChildSize: 0.45,
                expand: false,
                builder: (context, _) {
                  return const WelcomeGreetingAnimationWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
