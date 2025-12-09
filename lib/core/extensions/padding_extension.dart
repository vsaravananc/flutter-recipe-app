import 'package:flutter/widgets.dart';

extension PaddingExtension on Widget {
  Widget paddingOnlyBottom({required double bottom}) => Padding(
    padding: EdgeInsets.only(bottom: bottom),
    child: this,
  );
  Widget paddingOnlyTop({required double top}) => Padding(
    padding: EdgeInsets.only(top: top),
    child: this,
  );

  Widget paddingVertical({required double vertical}) => Padding(
    padding: EdgeInsets.symmetric(vertical: vertical),
    child: this,
  );
}
