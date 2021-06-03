import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/controllers/upload_claim_controller.dart';
import 'package:diapason/controllers/upload_item_lending_parameters_controller.dart';
import 'package:diapason/controllers/upload_item_controller.dart';
import 'package:diapason/models/claim.dart';
import 'package:diapason/notifier/claim_notifier.dart';
import 'package:diapason/notifier/item_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/util/alert_helper.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ItemPage extends StatefulWidget {
  static String route = 'item_page';

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {

  // PROPERTIES
  int _current = 0;

  // METHODS
  void _updateItem() {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UploadItemController())); // Modify activity
  }

  void _deleteItem(ItemNotifier itemNotifier, MemberNotifier memberNotifier) {
    Navigator.pop(context);
    DiapasonApi().deleteItem(itemNotifier, memberNotifier); // Delete activity
    Navigator.pop(context);
  }

  void _flagItem(ItemNotifier itemNotifier) {
    Navigator.pop(context);
    ClaimNotifier claimNotifier =
        Provider.of<ClaimNotifier>(context, listen: false);
    Claim _currentClaim = Claim();
    _currentClaim.content = itemNotifier.currentItem.name;
    _currentClaim.type = _currentClaim.claimTypeList[4];
    claimNotifier.currentClaim = _currentClaim;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UploadClaimController()));
  }

  void _blackListItemAuthor(MemberNotifier memberNotifier, ItemNotifier itemNotifier) {
    Navigator.pop(context);
    Navigator.pop(context);
    DiapasonApi().blackListMember(memberNotifier, itemNotifier.currentItem.owner);
  }

  List<Widget> _imageSliders(List<String> imgList, String description) {
    return imgList
        .map((item) => CachedNetworkImage(
              imageUrl: item,
              imageBuilder: (context, imageProvider) => Container(
                child: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: <Widget>[
                          Image(
                            image: imageProvider,
                            width: 1000.0,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    kBlackColor,
                                    // Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(
                                        0, 0, 0, 0) // Transparent color
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: ItemDescriptionWidget(text: description),
                            ),
                          ),
                          /*
                          Container(
                            // color: Colors.blue,
                            padding: EdgeInsets.only(bottom: 10.0, left: 10.0),
                            child: ItemDescriptionWidget(
                                text: description),
                          ),
                           */
                        ],
                      )),
                ),
              ),
              placeholder: (context, url) => BackgroundImagePlaceholderWidget(),
              errorWidget: (context, url, error) =>
                  ItemBackgroundDefaultImage(),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBarBackgroundColor,
          elevation: 10.0,
          centerTitle: true, // android override
          title: Consumer<ItemNotifier>(
            builder: (context, itemNotifier, child) {
              if(itemNotifier.currentItem != null) {
                return AppBarTextWidget(text: itemNotifier.currentItem.name);
              } else {
                return AppBarTextWidget(text: 'Matériel partagé');
              }
            },
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 25.0,
                color: kOrangeMainColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                ItemNotifier itemNotifier = Provider.of<ItemNotifier>(context, listen: false);
                MemberNotifier memberNotifier = Provider.of<MemberNotifier>(context, listen: false);
                AlertHelper().showItemOptions(
                  context,
                  memberNotifier.currentMember,
                  itemNotifier.currentItem,
                  () => _updateItem(),
                  () => _deleteItem(itemNotifier, memberNotifier),
                  () => _flagItem(itemNotifier),
                  () => _blackListItemAuthor(memberNotifier, itemNotifier),
                );
              },
              icon: Icon(
                kPendingIcon,
                size: 33.0,
                color: kOrangeMainColor,
              ),
            ),
          ],
        ),
        floatingActionButton: Consumer<ItemNotifier>(
          builder: (context, itemNotifier, child) {
            if (itemNotifier.currentOwner != null) {
              return Consumer<MemberNotifier>(
                  builder: (context, memberNotifier, child) {
                    if (memberNotifier.membersShipList != null && memberNotifier.currentMember != null) {
                      if (itemNotifier.currentOwner.uid == memberNotifier.currentMember.uid && memberNotifier.membersShipList.isNotEmpty) {
                        return FloatingActionButton(
                          elevation: 10.0,
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder:
                                        (BuildContext
                                    context) {
                                      return UploadItemLendingParametersController();
                                    }));
                          },
                          child: Icon(Icons.settings, size: 30.0,),
                          foregroundColor: kDarkGreyColor,
                          backgroundColor: kOrangeMainColor,
                        );
                      } else {
                        return EmptyContainer();
                      }
                    } else {
                      return EmptyContainer();
                    }
                  });
            } else {
              return EmptyContainer();
            }
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Consumer<ItemNotifier>(
                      builder: (context, itemNotifier, child) {
                    if (itemNotifier.currentItem != null) {
                      List<String> _imagesUrlList = [];
                      _imagesUrlList = itemNotifier.currentItem.itemImageList();
                      if (_imagesUrlList.isNotEmpty) {
                        return Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 10.0),
                              margin: EdgeInsets.only(bottom: 5.0),
                              child: CarouselSlider(
                                items: _imageSliders(
                                    itemNotifier.currentItem.itemImageList(),
                                    itemNotifier.currentItem.description),
                                options: CarouselOptions(
                                    autoPlay: false,
                                    enlargeCenterPage: true,
                                    aspectRatio: 2.0,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index;
                                      });
                                    }),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: itemNotifier.currentItem
                                  .itemImageList()
                                  .map((url) {
                                int index = itemNotifier.currentItem
                                    .itemImageList()
                                    .indexOf(url);
                                return Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _current == index
                                        ? kOrangeMainColor
                                        : kDrawerDividerColor,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: <Widget>[
                              ItemBackgroundDefaultImage(),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        kBlackColor,
                                        // Color.fromARGB(200, 0, 0, 0),
                                        Color.fromARGB(
                                            0, 0, 0, 0) // Transparent color
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  child: ItemDescriptionWidget(
                                      text:
                                      itemNotifier.currentItem.description),
                                ),
                              ),
                              /*
                              Container(
                                // color: Colors.blue,
                                padding: EdgeInsets.only(bottom: 10.0, left: 15.0),
                                child: ItemDescriptionWidget(
                                    text:
                                    itemNotifier.currentItem.description),
                              ),

                               */
                            ],
                          ),
                        );
                      }
                    } else {
                      return Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: ItemBackgroundDefaultImage());
                    }
                  }),
                  // TERMS, STATUE & ACTION BUTTON
                  Container(
                    height: 120.0,
                    margin: EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 10.0, top: 5.0),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                bottom: 10.0,
                                top: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                  color: kDrawerDividerColor, width: 2.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Consumer<ItemNotifier>(
                                    builder: (context, itemNotifier, child) {
                                      if (itemNotifier.currentItem != null) {
                                        return ItemLoanTermWidget(
                                            text:
                                                itemNotifier.currentItem.state);
                                      } else {
                                        return EmptyContainer();
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  child: Consumer<ItemNotifier>(
                                    builder: (context, itemNotifier, child) {
                                      if (itemNotifier.currentItem != null) {
                                        return ItemLoanTermWidget(
                                            text: itemNotifier.currentItem.loanTerm);
                                      } else {
                                        return EmptyContainer();
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  child: Consumer<ItemNotifier>(
                                    builder: (context, itemNotifier, child) {
                                      if (itemNotifier.currentItem != null && itemNotifier.currentBorrower != null &&
                                          itemNotifier.currentItem.borrower !=
                                              itemNotifier.currentItem.owner) {
                                        return ItemLoanTermWidget(
                                            text: itemNotifier
                                                .currentItem.loanStatues[1]);
                                      } else {
                                        return ItemLoanTermWidget(
                                            text: itemNotifier
                                                .currentItem.loanStatues[0]);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.0),
                          // COLUMN 2
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        child: ItemFeeTextWidget(
                                          text: 'Frais d\'utilisation',
                                        ),
                                      ),
                                      Container(
                                        // color: Colors.blue,
                                        child: Consumer<ItemNotifier>(
                                          builder:
                                              (context, itemNotifier, child) {
                                            if (itemNotifier.currentItem != null) {
                                              if (itemNotifier.currentItem.price != 0) {
                                                return ItemPriceWidget(
                                                  text:
                                                      '${itemNotifier.currentItem.price.toString()} €',
                                                  size: 22.0,
                                                );
                                              } else {
                                                return ItemPriceWidget(
                                                    text: 'Gratuit',
                                                    size: 18.0);
                                              }
                                            } else {
                                              return EmptyContainer();
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Consumer<ItemNotifier>(
                      builder: (context, itemNotifier, child) {
                        if(itemNotifier.currentItem != null) {
                          if (itemNotifier.currentOwner != null && itemNotifier.currentItem.owner != null) {
                            return Consumer<MemberNotifier>(
                                builder: (context, memberNotifier, child) {
                                  if(memberNotifier.currentMember != null) {
                                    if (memberNotifier.currentMember.membership == true) {
                                      return ItemPeopleTile(
                                        member: itemNotifier.currentOwner,
                                        subtitle: 'Propriétaire',
                                        faIcon: FaIcon(
                                          FontAwesomeIcons.handHoldingHeart,
                                          size: menuIconSize,
                                          color: kOrangeMainColor,
                                        ),
                                      );
                                    } else {
                                      return EmptyContainer();
                                    }
                                  } else {
                                    return EmptyContainer();
                                  }
                                });
                          } else {
                            return EmptyContainer();
                          }
                        } else {
                          return EmptyContainer();
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15.0),
                    child: Consumer<ItemNotifier>(
                      builder: (context, itemNotifier, child) {
                        if(itemNotifier.currentItem != null) {
                          if (itemNotifier.currentBorrower != null && itemNotifier.currentItem.borrower != null && itemNotifier.currentItem.borrower != itemNotifier.currentItem.owner) {
                            return Consumer<MemberNotifier>(
                                builder: (context, memberNotifier, child) {
                                  if(memberNotifier.currentMember != null) {
                                    if (memberNotifier.currentMember.membership == true) {
                                      return ItemPeopleTile(
                                        member: itemNotifier.currentBorrower,
                                        subtitle: 'utilise actuellement l\'objet',
                                        faIcon: FaIcon(
                                          FontAwesomeIcons.tools,
                                          size: menuIconSize,
                                          color: kOrangeMainColor,
                                        ),
                                      );
                                    } else {
                                      return EmptyContainer();
                                    }
                                  } else {
                                    return EmptyContainer();
                                  }
                                });
                          } else {
                            return EmptyContainer();
                          }
                        } else {
                          return EmptyContainer();
                        }
                      },
                    ),
                  ),
                ]),
          ),
        ));
  }
}
