import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class AboutPage extends StatefulWidget {

  static String route = 'about_page';

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  // PROPERTIES
  int _current = 0;

  List<Widget> _imageSliders(List<String> imgList) {
    if(imgList != null && imgList.isNotEmpty) {
      return imgList
          .map((item) => Container(
        margin: EdgeInsets.all(5.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(item),
            fit: BoxFit.cover,
          ),
        ),
      )).toList();
    } else {
      List<Widget> _emptyWidgetList = [];
      return _emptyWidgetList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBarBackgroundColor,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25.0,
              color: kOrangeMainColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 10.0,
        centerTitle: true, // android override
        title: AppBarTextWidget(text: 'À propos de Diapason'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 15.0, bottom: 10.0, top: 10.0),
            child: Image.asset(
              kAboutLogoPicture,
              color: kDrawerDividerColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                child: CarouselSlider(
                  items: _imageSliders(kBrochureImages),
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      aspectRatio: 1.0,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: kBrochureImages.map((url) {
                  int index = kBrochureImages.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
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
          ),
        ),
      ),
    );
  }
}
