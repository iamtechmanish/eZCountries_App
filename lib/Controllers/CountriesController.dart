
import 'dart:io';

import 'package:ezcountries_app/Utils/Config.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';

import '../Models/CountryModel.dart';

class CountriesController extends GetxController{

  var  countries = <Country>[].obs;
  var  allcountries = <Country>[].obs;
  var  country = Country().obs;
  var isLoading = true.obs;
  var isCountryLoading = true.obs;
  var hasError = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllCountries();
    getCountryDetail("IN");
  }


  getCountryDetail(String code) async {
    isCountryLoading= true.obs;
    var result =  await getCountry(code);
    if(result!=null){
      country.value = result;
    }
    isCountryLoading.value = false;

  }

  getCountry(String code) async {
    var result = await client.query(
      QueryOptions(
        document: gql(getCountryByCode),
        variables: {
          "code": code,
        },
      ),
    );


    var json = result.data!["country"];
    if(json!=null){
      hasError.value = false ;
     country.value = Country.fromJson(json);
    }
    else {
      hasError.value = true ;
    }

  }



  fetchAllCountries() async {
    isLoading= true.obs;
    var result =  await getAllCountries();
    if(result!=null){
      allcountries.value = result;
      countries.value = result;
    }
    isLoading.value = false;

  }

  onSearchTextChanged(String keyword){
    if (keyword.isEmpty || keyword=='') {
      countries.value = allcountries;
    }
    else {
      countries.value = allcountries
          .where((element) =>
          element.name.toString().toLowerCase().contains(keyword.toLowerCase()) ||
          element.code.toString().toLowerCase().contains(keyword.toLowerCase()) ||
          element.native.toString().toLowerCase().contains(keyword.toLowerCase()) ||
          element.capital.toString().toLowerCase().contains(keyword.toLowerCase())

      )
          .toList();
    }

  }




}