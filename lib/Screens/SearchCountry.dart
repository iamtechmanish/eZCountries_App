import 'package:ezcountries_app/Controllers/CountriesController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Models/CountryModel.dart';
import '../Utils/Config.dart';

class SearchCountry extends StatefulWidget {
  const SearchCountry({Key? key}) : super(key: key);

  @override
  _SearchCountryState createState() => _SearchCountryState();
}

class _SearchCountryState extends State<SearchCountry> {
  String code = "";

  CountriesController _countriesController = Get.put(CountriesController());
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          Common.APP_NAME,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                child: new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Card(
                    child: new ListTile(
                      leading: new Icon(Icons.search),
                      title: new TextField(
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        controller: controller,
                        decoration: new InputDecoration(
                            hintText: 'Search', border: InputBorder.none),
                        onChanged: (value) {
                          code = value.toString();
                        },
                      ),
                      trailing: new IconButton(
                        icon: new Icon(Icons.cancel),
                        onPressed: () {
                          controller.clear();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (code.isNotEmpty && code != "")
                            _countriesController.getCountryDetail(code);
                        },
                        child: Text("Find")),
                  ],
                ),
              ),
              Obx(() {
                if (_countriesController.isCountryLoading.value) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CircularProgressIndicator(),
                  ));
                } else {
                  return countryDetailsWidget(
                      context, _countriesController.country.value);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget countryDetailsWidget(BuildContext context, Country country) {
    if (_countriesController.hasError.value) {
      return const Center(
        child: Text("Code you entered does not exist."),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Country Info",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          color: Colors.grey.shade50,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Name"),
                    Text("Capital"),
                    Text("Country code"),
                    Text("Native"),
                    Text("Currency"),
                    Text("Emoji"),
                    Text("Languages"),
                  ],
                ),
                const Spacer(flex: 3),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(": ${country.name}",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(": ${country.capital}",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(": ${country.code}",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(": ${country.native}",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(": ${country.currency}",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(": ${country.emoji}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    Wrap(
                      children: country.languages!
                          .map((e) => Text(e.name.toString() + " ,",
                              overflow: TextOverflow.ellipsis))
                          .toList(),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
