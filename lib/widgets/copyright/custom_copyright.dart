import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCopyright extends StatelessWidget {
  final Color? backgroundColor;
  const CustomCopyright({
    super.key,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "© 2024 Xavier Junior Zuñiga Cruz",
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(fontWeight: FontWeight.w300, color: backgroundColor),
        ),
        const SizedBox(width: 15),
        InkWell(
          onTap: () async {
            if (!await launchUrl(Uri.parse(
                "https://www.linkedin.com/in/xavier-junior-zuniga-cruz-314113215/"))) {
              return;
            }
          },
          child: Icon(
            FontAwesomeIcons.linkedin,
            color: backgroundColor,
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () async {
            if (!await launchUrl(Uri.parse("https://github.com/xaju2210"))) {
              return;
            }
          },
          child: Icon(
            FontAwesomeIcons.github,
            color: backgroundColor,
          ),
        ),
      ],
    );
  }
}
