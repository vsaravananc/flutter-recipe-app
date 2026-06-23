import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:recipe/core/extensions/image_extension.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/core/services/beral_container.dart';

class CustomBarCode extends StatelessWidget {
  const CustomBarCode({super.key});

  static final _barcodeScanner = BarcodeScanner(formats: [BarcodeFormat.all]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CameraAwesomeBuilder.previewOnly(
          imageAnalysisConfig: AnalysisConfig(
            androidOptions: const AndroidAnalysisOptions.nv21(width: 1024),
            maxFramesPerSecond: 3,
            autoStart: true,
          ),
          onImageForAnalysis: _processImageBarcode,
          progressIndicator: const PlaceHolderWidget(
            key: ValueKey("place_holder_widget"),
          ),
          builder: (cameraState, preview) {
            return cameraState.when(onPreviewMode: (state) => const SizedBox());
          },
        ),
      ),
    );
  }

  Future _processImageBarcode(AnalysisImage img) async {
    final inputImage = img.inPutImage;
    try {
      var recognizedBarCodes = await _barcodeScanner.processImage(inputImage);
      if (recognizedBarCodes.isNotEmpty) {
        debugPrint("Barcode found! ${recognizedBarCodes.first.rawValue}");
      }
    } catch (_) {}
  }
}

class PlaceHolderWidget extends StatelessWidget {
  const PlaceHolderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withValues(alpha: 0.8),
      child: Column(
        crossAxisAlignment: .center,
        mainAxisAlignment: .center,
        children: [
          const HugeIcon(
            icon: HugeIcons.strokeRoundedQrCode,
            size: 200,
            strokeWidth: 1,
            color: Colors.white,
          ),
          Text(
            "Scann your barcode",
            style: context.headlineMedium?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
