import 'dart:async';
import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/controllers/upload_item_controller.dart';
import 'package:diapason/models/item.dart';
import 'package:diapason/notifier/item_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:provider/provider.dart';

class ItemsPage extends StatefulWidget {

  static String route = 'items_page';

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    ItemNotifier itemNotifier = Provider.of<ItemNotifier>(context, listen: false);
    DiapasonApi().getItems(itemNotifier);
    super.initState();
  }

  Future<void> _getItems() async {
    ItemNotifier itemNotifier = Provider.of<ItemNotifier>(context, listen: false);
    setState(() {
      DiapasonApi().getItems(itemNotifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBarBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            size: 35.0,
            color: kOrangeMainColor,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        elevation: 10.0,
        centerTitle: true, // android override
        title: AppBarTextWidget(text: 'Matériel partagé'),
        actions: <Widget>[
          Consumer<MemberNotifier>(
            builder: (context, memberNotifier, child) {
              if(memberNotifier.currentMember.admin == true) {
                return IconButton(
                  onPressed: () {
                    ItemNotifier itemNotifier = Provider.of<ItemNotifier>(context, listen: false);
                    itemNotifier.currentItem = null;
                    itemNotifier.currentOwner = null;
                    itemNotifier.currentBorrower = null;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UploadItemController()));
                  },
                  icon: Icon(
                    Icons.library_add_sharp,
                    size: 33.0,
                    color: kOrangeMainColor,
                  ),
                );
              } else {
                return EmptyContainer();
              }
            },
          )
        ],
      ),
      drawer: DrawerGeneral(),
      body: SafeArea(
        child: RefreshIndicator(
            onRefresh: _getItems,
            color: kOrangeMainColor,
            backgroundColor: kDrawerBackgroundColor,
            child: Consumer<ItemNotifier>(
              builder: (context, itemNotifier, child) {
                if(itemNotifier.itemsList != null && itemNotifier.itemsList.isNotEmpty) {
                  return Consumer<MemberNotifier>(
                      builder: (context, memberNotifier, child) {
                        List<Item> _itemsList = [];
                        for(Item item in itemNotifier.itemsList) {
                          if(!memberNotifier.currentMember.blackList.contains(item.owner)){
                            _itemsList.add(item);
                          }
                        }
                        return ItemsList(itemsList: _itemsList, itemNotifier: itemNotifier);
                      }
                  );
                } else {
                  return GestureDetector(
                    onTap: () async {
                      _getItems();
                    },
                      child: EmptyItemsListContainer()
                  );
                }
              },
            )
        ),
      ),
    );
  }
}

