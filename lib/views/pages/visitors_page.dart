import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/notifier/visitor_notifier.dart';
import 'package:diapason/views/lists/visitors_list.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:provider/provider.dart';

class VisitorsPage extends StatefulWidget {
  // String used for routes Navigation through app
  static String route = 'users_page';

  @override
  _VisitorsPageState createState() => _VisitorsPageState();
}

class _VisitorsPageState extends State<VisitorsPage> {
  
  @override
  void initState() {
    VisitorNotifier visitorNotifier = Provider.of<VisitorNotifier>(context, listen: false);
    DiapasonApi().getVisitors(visitorNotifier);
    super.initState();
  }

  Future<void> _getVisitorsList() async {
    VisitorNotifier visitorNotifier = Provider.of<VisitorNotifier>(context, listen: false);
    setState(() {
      DiapasonApi().getVisitors(visitorNotifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBarBackgroundColor,
        elevation: 10.0,
        centerTitle: true, // android override
        title: AppBarTextWidget(text: 'Liste des visiteurs'),
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
          Container(
              padding: EdgeInsets.only(right: 15.0),
              child: Center(
                child: Icon(
                  Icons.visibility,
                  color: kDrawerDividerColor,
                  size: 28.0,
                ),
              ))
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _getVisitorsList,
          color: kOrangeMainColor,
          backgroundColor: kDrawerBackgroundColor,
          child: Consumer<VisitorNotifier>(
            builder: (context, visitorNotifier, child) {
              if (visitorNotifier.visitorsList != null && visitorNotifier.visitorsList.isNotEmpty) {
                return VisitorsList(visitorNotifier: visitorNotifier);
              } else {
                return EmptyVisitorsContainer(
                  message:
                  'Il n\'y a actuellement aucun utilisateur avec le statut de visiteur',
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

