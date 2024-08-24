import 'package:app_pragma_prueba/widgets/loading/custom_pet_loading_indicator.dart';
import 'package:flutter/material.dart';

class CustomImageNetwork extends StatelessWidget {
  final String? url;
  const CustomImageNetwork({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url ?? "",
      loadingBuilder: (context, child, progress) {
        if (progress == null) {
          return child;
        } else {
          return const CustomPetLoadingIndicator();
        }
      },
      errorBuilder: (context, child, trace) => url == null
          ? const CustomPetLoadingIndicator()
          : url!.isEmpty
              ? const Icon(Icons.not_interested_sharp)
              : const CustomPetLoadingIndicator(),
      fit: BoxFit.fill,
    );
  }
}
