import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../extensions/extensions.dart';
import '../utils/colors.dart';

void setOrientation(bool or) {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(or ? [DeviceOrientation.portraitUp] : [DeviceOrientation.landscapeLeft]).then((_) {});
}

void startScreenF(BuildContext context, StatefulWidget stl) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => stl));
}

void startScreenS(BuildContext context, StatelessWidget stl) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => stl));
}

void finishScreen(BuildContext context) {
  Navigator.pop(context);
}

String formatHHMMSS(int seconds) {
  // int hours = (seconds / 3600).truncate();
  seconds = (seconds % 3600).truncate();
  int minutes = (seconds / 60).truncate();

  // String hoursStr = (hours).toString().padLeft(2, '0');
  String minutesStr = (minutes).toString().padLeft(2, '0');
  String secondsStr = (seconds % 60).toString().padLeft(2, '0');

  // if (hours == 0) {
  //   return "$minutesStr:$secondsStr";
  // }
//$hoursStr:
  return "$minutesStr:$secondsStr";
}

void clearFocus(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode()); //remove focus
}

// String foizToPrice(double narxYet, double foiz) {
//   return (narxYet * (foiz + 100) / 100).formattedAmount();
// }
//
// String priceToFoiz(double narxYet, double price) {
//   return ((price - narxYet) * 100 / narxYet).formattedAmount();
// }

String getChars(String words, int limitTo) {
  List<String> names = words.split(" ");
  String initials = '';
  for (var i = 0; i < names.length; i++) {
    initials += names[i][0];
    if (i >= limitTo - 1) return initials;
  }
  return initials;
}

String dateFormatter(DateTime selectTime) {
  var formatter = DateFormat('dd.MM.yyyy');
  String formattedDate = formatter.format(selectTime);
  return formattedDate;
}

double getScreenHeight(context) {
  return MediaQuery.of(context).size.height;
}

double getScreenWidth(context) {
  return MediaQuery.of(context).size.width;
}

void vibrateMedium() {
  HapticFeedback.mediumImpact();
}

void vibrateLight() {
  HapticFeedback.lightImpact();
}

void vibrateHeavy() {
  HapticFeedback.heavyImpact();
}

void showSnackeBar(BuildContext context, String message) {
  ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(content: Text(message)));
}

showMyBottomSheet(
  BuildContext context,
  Widget child, {
  EdgeInsets? margin,
  double? topRadiuses,
  Color? backgroundColor,
  Color? borderColor,
  bool? isDismissible,
  double? borderWidth,
  double? minHeight,
}) async {
  topRadiuses ??= 16;
  backgroundColor ??= Colors.white;
  margin ??= EdgeInsets.all(8);
  borderColor ??= COLOR_PRIMARY;
  borderWidth ??= 1.0;
  minHeight ??= 10;
  isDismissible ??= true;

  return showModalBottomSheet(
    context: context,
    isDismissible: isDismissible,
    barrierColor: Colors.transparent,
    isScrollControlled: true,
    // only work on showModalBottomSheet function
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(topRadiuses), topRight: Radius.circular(topRadiuses)),
        side: BorderSide(
          width: borderWidth,
          color: borderColor,
        )),
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: LIGHT_GRAY_COLOR,
              blurRadius: 8,
              offset: Offset(1, 1), // Shadow position
            ),
          ],
          borderRadius: BorderRadius.only(topRight: Radius.circular(topRadiuses!), topLeft: Radius.circular(topRadiuses)),
          shape: BoxShape.rectangle,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: margin,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 60,
                        height: 10,
                        decoration: BoxDecoration(color: LIGHT_GRAY_COLOR, borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.clear_rounded)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, right: 4, left: 4),
                      child: child,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget showMyProgress() {
  return Container(
      alignment: Alignment.center,
      color: Colors.black.withAlpha(90),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: COLOR_PRIMARY, blurRadius: 150, spreadRadius: 1, blurStyle: BlurStyle.normal)],
          color: COLOR_PRIMARY.withAlpha(100),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CircularProgressIndicator(
          color: Colors.white,
          backgroundColor: LIGHT_GRAY_COLOR,
        ),
      ));
}

Future<void> showError(BuildContext context, String message, {Function? pressOk}) async {
  var size = MediaQuery.of(context).size;
  if (ModalRoute.of(context)?.isCurrent ?? true) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: COLOR_PRIMARY.withAlpha(400), //this works
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          color: COLOR_PRIMARY.withAlpha(500),
                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                          gradient: const LinearGradient(
                              colors: [COLOR_PRIMARY, COLOR_PRIMARY_DARK], begin: Alignment.bottomLeft, end: Alignment.topRight)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 16),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.error_outlined,
                                size: 36,
                                color: Colors.red,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "Хатолик!!!",
                                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 4),
                                    Text(message,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    if (pressOk != null) {
                                      pressOk();
                                      Navigator.pop(context);
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text(
                                    "Да",
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  return;
}

Future<void> showWarning(BuildContext context, String message, {Function? pressOk, bool? noButton, bool? forSingOut}) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: COLOR_PRIMARY.withAlpha(400), //this works
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.center,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                    padding: const EdgeInsets.all(8),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: COLOR_PRIMARY.withAlpha(500),
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        gradient: const LinearGradient(
                            colors: [COLOR_PRIMARY, COLOR_PRIMARY_DARK], begin: Alignment.bottomLeft, end: Alignment.topRight)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 8),
                            const Icon(
                              Icons.warning_rounded,
                              size: 36,
                              color: Colors.orange,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Диққат!!!",
                                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(message,
                                      style: const TextStyle(color: Colors.white, fontSize: 16),
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Visibility(
                                  visible: noButton != null ? true : false,
                                  child: const Text(
                                    "Нет",
                                    style: const TextStyle(color: LIGHT_GRAY_COLOR),
                                  ),
                                )),
                            TextButton(
                                onPressed: () async {
                                  if (pressOk != null) {
                                    pressOk();
                                    if (forSingOut != true) {
                                      Navigator.pop(context);
                                    }
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(
                                  "Да",
                                  style: const TextStyle(color: Colors.white),
                                ))
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Future<void> showSuccess(BuildContext context, String message, {Function? pressOk}) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: COLOR_PRIMARY.withAlpha(400), //this works
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.center,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Align(
              alignment: Alignment.center,
              child: Container(
                  padding: const EdgeInsets.all(8),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      color: COLOR_PRIMARY.withAlpha(500),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      gradient: const LinearGradient(
                          colors: [COLOR_PRIMARY, COLOR_PRIMARY_DARK], begin: Alignment.bottomLeft, end: Alignment.topRight)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.cloud_done_outlined,
                            size: 36,
                            color: Colors.green,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Муваффақиятли.",
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(message,
                                    style: const TextStyle(color: Colors.white, fontSize: 16),
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis)
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                if (pressOk != null) {
                                  pressOk();
                                }
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Да",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ),
      );
    },
  );
}

Widget rowText(String value, String value2, {double? fontSize, double? sizedBox, Color? color, FontWeight? fontWeight}) {
  sizedBox ??= 4;
  fontSize ??= 16;
  color ??= Colors.black;
  fontWeight ??= FontWeight.w500;
  return Column(
    children: [
      SizedBox(height: sizedBox),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(value, style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color)),
        Flexible(
            child: Text(value2,
                overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color)))
      ])
    ],
  );
}

showMyGeneralDialog(
  BuildContext context,
  String title, {
  Alignment? alignment,
  Color? backgraoundColor,
  Function? pressOk,
  Function? pressNo,
  String? textOk,
  String? textNo,
}) async {
  backgraoundColor ??= Colors.white;
  return showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.7),
    transitionDuration: const Duration(milliseconds: 500),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      alignment ??= Alignment.center;
      return Align(
        alignment: alignment!,
        child: Container(
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: backgraoundColor,
              border: Border.all(width: 1, color: Colors.white),
              borderRadius: BorderRadius.all(const Radius.circular(8))),
          child: Material(
              color: TRANSPARENT,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12, top: 12),
                          child: Icon(
                            Icons.clear,
                            size: 24,
                            color: Colors.grey,
                          ),
                        ),
                      )),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        title,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 26),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                height: 44,
                                decoration: BoxDecoration(color: LIGHT_GRAY_COLOR, borderRadius: BorderRadius.circular(6)),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      textNo ?? "Йўқ",
                                      style: TextStyle(color: COLOR_PRIMARY, fontSize: 16, fontWeight: FontWeight.w700),
                                    )),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                height: 44,
                                decoration: BoxDecoration(color: COLOR_PRIMARY, borderRadius: BorderRadius.circular(6)),
                                child: TextButton(
                                    onPressed: () {
                                      if (pressOk != null) {
                                        pressOk();
                                        Navigator.pop(context);
                                      } else {
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text(
                                      textOk ?? "Ҳа",
                                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}
