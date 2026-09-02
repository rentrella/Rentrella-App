import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AppIcon {
  /// main
  appIcon('app_icon.svg'),
  appLogo('logo.svg'),

  /// else
  alert('alert.svg'),
  alertOutline('alert_outline.svg'),
  arrowBack('arrow_back.svg'),
  arrowDown('arrow_down.svg'),
  arrowForward('arrow_forward.svg'),
  arrowUp('arrow_up.svg'),
  bell('bell.svg'),
  bellNew('bell_new.svg'),
  bubbleChat('bubble_chat.svg'),
  bubbleChatNew('bubble_chat_new.svg'),
  checkboxChecked('checkbox_checked.svg'),
  checkboxUncheck('checkbox_uncheck.svg'),
  close('close.svg'),
  cloudy('cloudy.svg'),
  dropArrowBack('drop_arrow_back.svg'),
  dropArrowDown('drop_arrow_down.svg'),
  dropArrowForward('drop_arrow_forward.svg'),
  dropArrowUp('drop_arrow_up.svg'),
  email('email.svg'),
  exit('exit.svg'),
  key('key.svg'),
  lock('lock.svg'),
  person('person.svg'),
  personOutline('person_outline.svg'),
  rain('rain.svg'),
  snow('snow.svg'),
  sunny('sunny.svg'),
  temperatureHigh('temperature_high.svg'),
  temperatureLow('temperature_low.svg'),
  umbrellaFlipped('umbrella_flipped.svg'),
  umbrellaFold('umbrella_fold.svg'),
  umbrellaOpen('umbrella_open.svg'),
  umbrellaRolled('umbrella_rolled.svg'),
  unlock('unlock.svg'),
  visibility('visibility.svg'),
  visibilityOff('visibility_off.svg');

  final String path;

  const AppIcon(this.path);

  SvgPicture icon({
    Color? color,
    double? size,
    double? width,
    double? height,
  }) => SvgPicture.asset(
    'assets/icons/$path',
    width: width ?? size,
    height: height ?? size,
    color: color,
  );
}
