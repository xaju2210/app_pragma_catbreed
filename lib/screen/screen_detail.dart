import 'package:app_pragma_prueba/entity/entity_cat.dart';
import 'package:app_pragma_prueba/widgets/image/custom_image_network.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenDetail extends StatelessWidget {
  final EntityCat? objCat;
  const ScreenDetail({
    super.key,
    required this.objCat,
  });

  @override
  Widget build(BuildContext context) {
    int maxIntelegence = 5;
    int maxAdaptability = 5;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(objCat?.name ?? ""),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: CustomImageNetwork(
                        url: objCat?.urlPhoto,
                      )),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                                text: "País de origen :",
                                style: Theme.of(context).textTheme.titleMedium,
                                children: [
                                  TextSpan(
                                    text: "\n${objCat!.origin}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ]),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "Inteligencia :",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              Row(
                                children: List.generate(
                                  maxIntelegence,
                                  (i) => Icon(
                                    i < objCat!.intelligence
                                        ? Icons.star
                                        : Icons.star_border_outlined,
                                    color: i < objCat!.intelligence
                                        ? Colors.yellow[700]
                                        : Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "Adaptabilidad: ",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "(${objCat!.adaptability}/$maxAdaptability)",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    adaptability(objCat!.adaptability, maxAdaptability),
                    const SizedBox(height: 15),
                    Text(
                      "Descripción",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      objCat!.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Tiempo de Vida",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      objCat!.lifeSpan,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Mas información:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: onPressedWikipedia,
                      child: Text(
                        objCat!.wikipediaUrl,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ));
  }

  Widget adaptability(int intLevel, int maxLevel) {
    return GridView.count(
      childAspectRatio: (10 / 3),
      crossAxisCount: maxLevel,
      crossAxisSpacing: 10,
      shrinkWrap: true,
      children: List.generate(
        maxLevel,
        (i) => Container(
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: i < intLevel
                    ? intLevel < 3
                        ? Colors.yellow[700]!
                        : Colors.green
                    : Colors.grey),
            color: i < intLevel
                ? intLevel < 3
                    ? Colors.yellow[700]!
                    : Colors.green
                : Colors.white,
          ),
        ),
      ),
    );
  }

  void onPressedWikipedia() async {
    if (!await launchUrl(Uri.parse(objCat!.wikipediaUrl))) {
      return;
    }
  }
}
