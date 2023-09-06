import 'package:flutter/material.dart';

class MyScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    // When modifying this function, consider modifying the implementation in
    // the Material and Cupertino subclasses as well.
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        break;
      case TargetPlatform.linux:
        break;
      case TargetPlatform.macOS:
        break;
      case TargetPlatform.windows:
        return child;
      case TargetPlatform.android:
        switch (androidOverscrollIndicator) {
          case AndroidOverscrollIndicator.stretch:
            return StretchingOverscrollIndicator(
              axisDirection: details.direction,
              child: child,
            );
          case AndroidOverscrollIndicator.glow:
            break;
        }
        break;
      case TargetPlatform.fuchsia:
        break;
    }
    return GlowingOverscrollIndicator(
      axisDirection: details.direction,
      color: Colors.blue,
      child: child,
    );
  }
}
// class MyScrollBehavior extends ScrollBehavior {
//   @override
//   Widget buildOverscrollIndicator(
//       BuildContext context, Widget child, AxisDirection axisDirection) {
//     return child;
//   }
// }
