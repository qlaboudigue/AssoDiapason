import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/models/item.dart';
import 'package:diapason/notifier/item_notifier.dart';
import 'package:diapason/views/pages/item_page.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class ItemsList extends StatelessWidget {

  final List<Item> itemsList;
  final ItemNotifier itemNotifier;

  ItemsList({@required this.itemsList, @required this.itemNotifier});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: kDrawerDividerColor,
          thickness: 1.0,
        ),
        itemCount: itemsList.length,
        itemBuilder: (BuildContext context, int index) {
          EdgeInsets padding;
          if(index == 0) {
            padding = EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 5.0);
          } else if (index == itemsList.length - 1) {
            padding = EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0);
          } else {
            padding = EdgeInsets.only(left: 15.0, right: 15.0,);
          }
          return ListTile(
            dense: true,
            contentPadding: padding,
            title: ItemTileTitleText(text: '${itemsList[index].name}'),
            subtitle: ItemTileSubtitleText(text: '${itemsList[index].description}'),
            trailing: ItemImage(item: itemsList[index]),
            onTap: () {
              // itemNotifier.currentOwner = null;
              // itemNotifier.currentBorrower = null;
              itemNotifier.currentItem = itemsList[index];
              DiapasonApi().getItemOwner(itemNotifier);
              DiapasonApi().getItemBorrower(itemNotifier);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return ItemPage();
                  }));
            },
          );
        });
  }
}