import 'dart:ui';

import 'package:ezcountries_app/Models/CountryModel.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

String BASE_URL = "https://countries.trevorblades.com/graphql";
const Color appColor = Colors.yellow;
const String appIcon = "assets/images/logo.png";

class Common {
  static final APP_NAME = "eZCountries App";
}


final httpLink = HttpLink(BASE_URL);

final GraphQLClient client = GraphQLClient(
  link: httpLink,
  cache: GraphQLCache(),
);

const _getAllCountries = r'''
query Query {
  countries {
    code
    name
    capital
    native
    phone
    currency
    emoji
    languages {
      name
      code
    }
    
  }
}
''';

const getCountryByCode = r'''
query getCountry($code:ID!){
  country(code:$code){
    code
    name
    capital
    native
    phone
    currency
    emoji
    languages {
      name
      code
    }
    
  }
}

''';

Future<List<Country>> getAllCountries() async {
  var result = await client.query(
    QueryOptions(
      document: gql(_getAllCountries),
    ),
  );

  var json = result.data!["countries"];
  List<Country> countries = [];
  for (var res in json) {
    var country = Country.fromJson(res);
    countries.add(country);
  }
  return countries;
}





