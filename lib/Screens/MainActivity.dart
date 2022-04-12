import 'package:ezcountries_app/Controllers/CountriesController.dart';
import 'package:ezcountries_app/Screens/SearchCountry.dart';
import 'package:ezcountries_app/Utils/Config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Models/CountryModel.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({Key? key}) : super(key: key);

  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {

  final CountriesController _countriesController = Get.put(CountriesController());


  Future<bool> onWillPop() async {
    await showExitDialog();
    return true;
  }

  showExitDialog() {
    showDialog(
      // backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Exit App"),
            content: Text("Are you sure, you want to exit this app?"),
            actions: [
              ButtonTheme(
                hoverColor: Colors.blue[200],
                child: TextButton(
                    onPressed: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                      // Navigator.pop(context);
                    },
                    child: Text("Yes")),
              ),
              ButtonTheme(
                focusColor: Colors.blue[200],
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No")),
              )
            ],
          );
        });
  }





  @override
  Widget build(BuildContext context) {

    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    TextEditingController controller = new TextEditingController();


    return WillPopScope(

      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: (){
                _scaffoldKey.currentState!.openDrawer();
              },
              child: Icon(Icons.menu)),
          title: Text(
            Common.APP_NAME,
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
                padding: EdgeInsets.all(0),
                child: Container(
              color: Colors.blue,
            )),
            ListTile(
              leading: Icon(Icons.language),
              title: Text("Find Country by Code"),
              onTap: (){
                Get.to(SearchCountry());
              },
            )
            ,
            Divider()
          ],
        ),
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
                          controller: controller,
                          decoration: new InputDecoration(
                              hintText: 'Search', border: InputBorder.none),
                          onChanged: _countriesController.onSearchTextChanged,
                        ),
                        trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                          controller.clear();
                          _countriesController.onSearchTextChanged('');
                        },),
                      ),
                    ),
                  ),
                ),
                Obx((){
                  if(_countriesController.isLoading.value){
                    return
                      Center(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: CircularProgressIndicator(),
                          ));
                  }
                  else {
                  return allCountryWidget(context, _countriesController.countries);
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget allCountryWidget(
      BuildContext context, List<Country> countries) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: countries.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: ListTile(
                  leading: Column(
                    children: [
                      Text(countries[index].emoji.toString(), style: TextStyle(fontSize: 25),),
                      SizedBox(
                        height: 5,
                      ),
                      Text("(" + countries[index].code.toString() + ")"),
                    ],
                  ),
                  title: Text(
                      countries[index].name.toString()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Capital: " + countries[index].capital.toString()),
                      Text("Native: " + countries[index].native.toString()),
                      Text("Currency: " + countries[index].currency.toString()),
                      Wrap(
                        children: [
                          Text("languages :"),
                            Wrap(
                              children: countries[index]
                                  .languages!
                                  .map((e) => Text(e.name.toString()+" ,", overflow: TextOverflow.ellipsis))
                                  .toList(),
                            ),
                        ],
                      ),

                    ],
                  ),
                ),
              );
            },
          ));
  }

}
