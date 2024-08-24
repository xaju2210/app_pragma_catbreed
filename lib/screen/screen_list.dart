import 'package:app_pragma_prueba/config/constants/const_name_router.dart';
import 'package:app_pragma_prueba/config/theme/app_theme.dart';
import 'package:app_pragma_prueba/entity/entity_cat.dart';
import 'package:app_pragma_prueba/repository/repository_list.dart';
import 'package:app_pragma_prueba/service/service_navigation.dart';
import 'package:app_pragma_prueba/widgets/copyright/custom_copyright.dart';
import 'package:app_pragma_prueba/widgets/image/custom_image_network.dart';
import 'package:flutter/material.dart';

class ScreenList extends StatefulWidget {
  const ScreenList({super.key});

  @override
  State<ScreenList> createState() => _ScreenListState();
}

class _ScreenListState extends State<ScreenList> {
  TextEditingController ctrlSearch = TextEditingController();
  List<EntityCat> lstCat = [];
  List<EntityCat> lstCatTemp = [];
  Map<String, String> mapCatIamges = {};

  bool isLoadingData = true;
  int maxIntelegence = 5;

  final RespositoryList _repo = RespositoryList();

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Catbreeds"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: ctrlSearch,
                      onEditingComplete: onPressedSearch,
                      onChanged: (_) {
                        onPressedSearch();
                      },
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: onPressedSearch,
                          child: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              isLoadingData
                  ? const Expanded(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    )
                  : lstCatTemp.isEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No hay datos encontrados",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: appTheme.colorSubtle1),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: lstCatTemp.length,
                            itemBuilder: (context, index) =>
                                _cardCatInfo(index, context),
                          ),
                        ),
              const SizedBox(height: 10),
              const CustomCopyright(),
            ],
          ),
        ),
      ),
    );
  }

  Card _cardCatInfo(int index, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 35),
      color: appTheme.colorWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: LayoutBuilder(builder: (context, constrains) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lstCatTemp[index].name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      onPressedDetail(index);
                    },
                    child: const Text("Ver mas..."),
                  )
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                    width: constrains.maxWidth - 20,
                    height: constrains.maxWidth - 20,
                    child: CustomImageNetwork(
                      url: mapCatIamges[lstCatTemp[index].id],
                    )),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                          text: "País de origen :",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: "\n${lstCatTemp[index].origin}",
                              style: Theme.of(context).textTheme.bodyMedium,
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
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Row(
                            children: List.generate(
                                maxIntelegence,
                                (i) => Icon(
                                      i < lstCatTemp[index].intelligence
                                          ? Icons.star
                                          : Icons.star_border_outlined,
                                      color: i < lstCatTemp[index].intelligence
                                          ? Colors.yellow[700]
                                          : Colors.grey,
                                    )))
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          );
        }),
      ),
    );
  }

  void initData() async {
    setState(() {
      isLoadingData = true;
    });

    await list();

    setState(() {
      isLoadingData = false;
    });

    for (EntityCat objCat in lstCat) {
      getImageCat(objCat.id);
    }
  }

  void onPressedSearch() async {
    setState(() {
      lstCatTemp = lstCat
          .where((e) => e.name.toLowerCase().contains(ctrlSearch.text))
          .map((e) => e.copyWith())
          .toList();
    });
  }

  void onPressedDetail(int index) async {
    await ServiceNavigation.push(
      ConstNameRouter.detail,
      arguments: lstCatTemp[index].copyWith(
        urlPhoto: mapCatIamges[lstCatTemp[index].id],
      ),
    );
  }

  Future list() async {
    final response = await _repo.list();

    if (response.isError()) return;

    lstCat = response.getSucces() ?? [];
    lstCatTemp = lstCat.map((e) => e.copyWith()).toList();
  }

  Future<void> getImageCat(String id) async {
    final response = await _repo.getImage(id);

    if (response.isError()) return;

    setState(() {
      mapCatIamges[id] = response.getSucces() ?? "";
    });
  }
}
