/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/services.dart';
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class $AssetsAudioGen {
  const $AssetsAudioGen();

  /// File path: assets/audio/feelcalm.mp3
  String get feelcalm => 'assets/audio/feelcalm.mp3';

  /// File path: assets/audio/meditate.mp3
  String get meditate => 'assets/audio/meditate.mp3';

  /// File path: assets/audio/sleepspace.mp3
  String get sleepspace => 'assets/audio/sleepspace.mp3';

  /// List of all assets
  List<String> get values => [feelcalm, meditate, sleepspace];
}

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Inter-Bold.ttf
  String get interBold => 'assets/fonts/Inter-Bold.ttf';

  /// File path: assets/fonts/Inter-ExtraBold.ttf
  String get interExtraBold => 'assets/fonts/Inter-ExtraBold.ttf';

  /// File path: assets/fonts/Inter-ExtraLight.ttf
  String get interExtraLight => 'assets/fonts/Inter-ExtraLight.ttf';

  /// File path: assets/fonts/Inter-Light.ttf
  String get interLight => 'assets/fonts/Inter-Light.ttf';

  /// File path: assets/fonts/Inter-Medium.ttf
  String get interMedium => 'assets/fonts/Inter-Medium.ttf';

  /// File path: assets/fonts/Inter-Regular.ttf
  String get interRegular => 'assets/fonts/Inter-Regular.ttf';

  /// File path: assets/fonts/Inter-SemiBold.ttf
  String get interSemiBold => 'assets/fonts/Inter-SemiBold.ttf';

  /// List of all assets
  List<String> get values => [
        interBold,
        interExtraBold,
        interExtraLight,
        interLight,
        interMedium,
        interRegular,
        interSemiBold
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_icon.png
  AssetGenImage get appIcon =>
      const AssetGenImage('assets/images/app_icon.png');

  /// File path: assets/images/check.svg
  SvgGenImage get check => const SvgGenImage('assets/images/check.svg');

  /// File path: assets/images/fire.svg
  SvgGenImage get fire => const SvgGenImage('assets/images/fire.svg');

  /// File path: assets/images/fullscreen.svg
  SvgGenImage get fullscreen =>
      const SvgGenImage('assets/images/fullscreen.svg');

  /// File path: assets/images/heartDamaged.svg
  SvgGenImage get heartDamaged =>
      const SvgGenImage('assets/images/heartDamaged.svg');

  /// File path: assets/images/mail.svg
  SvgGenImage get mail => const SvgGenImage('assets/images/mail.svg');

  /// File path: assets/images/meditationimg.png
  AssetGenImage get meditationimg =>
      const AssetGenImage('assets/images/meditationimg.png');

  /// File path: assets/images/mute.svg
  SvgGenImage get mute => const SvgGenImage('assets/images/mute.svg');

  /// File path: assets/images/next.svg
  SvgGenImage get next => const SvgGenImage('assets/images/next.svg');

  /// File path: assets/images/onb1img.png
  AssetGenImage get onb1img => const AssetGenImage('assets/images/onb1img.png');

  /// File path: assets/images/onb2img.png
  AssetGenImage get onb2img => const AssetGenImage('assets/images/onb2img.png');

  /// File path: assets/images/onb3img.png
  AssetGenImage get onb3img => const AssetGenImage('assets/images/onb3img.png');

  /// File path: assets/images/onb4img.png
  AssetGenImage get onb4img => const AssetGenImage('assets/images/onb4img.png');

  /// File path: assets/images/onb5img.png
  AssetGenImage get onb5img => const AssetGenImage('assets/images/onb5img.png');

  /// File path: assets/images/paywall.svg
  SvgGenImage get paywall => const SvgGenImage('assets/images/paywall.svg');

  /// File path: assets/images/person.svg
  SvgGenImage get person => const SvgGenImage('assets/images/person.svg');

  /// File path: assets/images/personCircle.svg
  SvgGenImage get personCircle =>
      const SvgGenImage('assets/images/personCircle.svg');

  /// File path: assets/images/phone.svg
  SvgGenImage get phone => const SvgGenImage('assets/images/phone.svg');

  /// File path: assets/images/play.svg
  SvgGenImage get play => const SvgGenImage('assets/images/play.svg');

  /// File path: assets/images/prev.svg
  SvgGenImage get prev => const SvgGenImage('assets/images/prev.svg');

  /// File path: assets/images/share.svg
  SvgGenImage get share => const SvgGenImage('assets/images/share.svg');

  /// File path: assets/images/volumeon.svg
  SvgGenImage get volumeon => const SvgGenImage('assets/images/volumeon.svg');

  /// List of all assets
  List<dynamic> get values => [
        appIcon,
        check,
        fire,
        fullscreen,
        heartDamaged,
        mail,
        meditationimg,
        mute,
        next,
        onb1img,
        onb2img,
        onb3img,
        onb4img,
        onb5img,
        paywall,
        person,
        personCircle,
        phone,
        play,
        prev,
        share,
        volumeon
      ];
}

class Assets {
  Assets._();

  static const $AssetsAudioGen audio = $AssetsAudioGen();
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated Clip? clipBehavior,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      color: color,
      colorBlendMode: colorBlendMode,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
