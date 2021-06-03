import 'package:diapason/util/place_service.dart';
import 'package:diapason/views/my_material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressSearch extends SearchDelegate<Suggestion> {

  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  final sessionToken;
  PlaceApiProvider apiClient;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      primaryColor: kBarBackgroundColor,
      primaryIconTheme:
          Theme.of(context).primaryIconTheme.copyWith(color: kWhiteColor),
      textTheme: Theme.of(context).textTheme.copyWith(
          headline6: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: kWhiteColor,
            ),
          ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: GoogleFonts.roboto(
          textStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: kWhiteColor,
          ),
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Retour',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Entrez votre adresse ci-dessus',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
          color: kWhiteColor,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(
              query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Entrez votre adresse ci-dessus', style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: kWhiteColor,
              ),),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title:
                        Text((snapshot.data[index] as Suggestion).description, style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: kWhiteColor,
                        ),),
                    onTap: () {
                      close(context, snapshot.data[index] as Suggestion);
                    },
                  ),
                  itemCount: snapshot.data.length,
                )
              : Container(child: Text('Chargement...', style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: kWhiteColor,
      ),)),
    );
  }
}
