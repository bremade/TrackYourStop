import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvv_tracker/modules/favorites/provider/transportation_type_provider.dart';
import 'package:mvv_tracker/modules/favorites/ui/favorite_app_bar.dart';
import 'package:mvv_tracker/utils/logger.dart';

final logger = getLogger("FavoritePage");

class FavoritePage extends HookConsumerWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController nameController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    Widget buildChips() {
      List<Widget> chips = [];
      final List<String> selectedTransportationTypes =
          ref.watch(transportationTypeProvider);
      for (var transportType in selectedTransportationTypes) {
        InputChip actionChip = InputChip(
          label: Text(transportType.toUpperCase()),
          onDeleted: () {
            ref
                .read(transportationTypeProvider.notifier)
                .removeTransportationType(transportType);
          },
        );
        chips.add(actionChip);
      }
      return ListView.builder(
          // This next line does the trick.
          scrollDirection: Axis.horizontal,
          itemCount: chips.length,
          itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 5.0), child: chips[index]));
    }

    Widget buildBody() {
      final List<String> selectedTransportationTypes =
          ref.watch(transportationTypeProvider);
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 32.0,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                  controller: nameController,
                  onChanged: (v) => nameController.text = v,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name of the origin station',
                  )),
            ),
            Container(
                height: 50.0,
                padding: const EdgeInsets.only(bottom: 8.0),
                child: buildChips()),
            Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  return TransportationTypeEnum.values
                      .map((e) => e.name.toLowerCase())
                      .where((option) =>
                          option.contains(textEditingValue.text.toLowerCase()));
                }, onSelected: (selection) {
                  ref
                      .read(transportationTypeProvider.notifier)
                      .addTransportationType(selection);
                }, fieldViewBuilder:
                        (context, controller, focusNode, onEditingComplete) {
                  return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onEditingComplete: onEditingComplete,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Type of transportation',
                      ));
                })),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                  controller: locationController,
                  onChanged: (v) => locationController.text = v,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Names of the destination stations",
                  )),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: FavoriteAppBar(),
      body: buildBody(),
    );
  }
}
