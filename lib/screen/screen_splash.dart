import 'package:app_pragma_prueba/config/constants/const_name_router.dart';
import 'package:app_pragma_prueba/config/theme/app_theme.dart';
import 'package:app_pragma_prueba/service/service_navigation.dart';
import 'package:app_pragma_prueba/widgets/copyright/custom_copyright.dart';
import 'package:flutter/material.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  double opacity = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        opacity = 1.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: appTheme.colorSeed,
        child: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(seconds: 2),
                    onEnd: () {
                      ServiceNavigation.replaceRemoveUntil(
                          ConstNameRouter.list);
                    },
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(
                        "Catbreeds",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: appTheme.colorWhite),
                      ),
                      const SizedBox(height: 20),
                      Image.asset(
                        "assets/img/logo.jpeg",
                        scale: 5,
                      ),
                    ]),
                  )
                ],
              ),
            ),
            CustomCopyright(
              backgroundColor: appTheme.colorWhite,
            ),
            const SizedBox(height: 20)
          ],
        )),
      ),
    );
  }
}
