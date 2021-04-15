import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'players.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AutoComplete(),
      ),
    );
  }
}

class AutoComplete extends StatefulWidget {
  @override
  _AutoCompleteState createState() => new _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  GlobalKey<AutoCompleteTextFieldState<Cities>> key = new GlobalKey();

  AutoCompleteTextField searchTextField;

  TextEditingController controller = new TextEditingController();

  _AutoCompleteState();

  void _loadData() async {
    await CitiesViewModel.loadCities();
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Auto Complete Pakistan City Name'),
        ),
        body: new Center(
            child: new Column(children: <Widget>[
              new Column(children: <Widget>[
                searchTextField = AutoCompleteTextField<Cities>(
                    style: new TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black,)
                      ),
                       focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10),
                         borderSide: BorderSide(color: Colors.black,width: 1.0),
                       ),
                       prefixIcon: Icon(
                         Icons.add_location,
                         color: Colors.amber,
                       ),
                        hintText: 'Search City Name',
                        hintStyle: TextStyle(
                            color: Colors.black,
                          fontSize: 16,
                        ),
                    ),
                    itemSubmitted: (item) {
                      setState(() => searchTextField.textField.controller.text =
                          item.autocompleteterm);
                    },
                    clearOnSubmit: false,
                    key: key,
                    suggestions: CitiesViewModel.cities,
                    itemBuilder: (context, item) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(item.autocompleteterm,
                            style: TextStyle(
                                fontSize: 16.0
                            ),),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                          ),
                          Text(item.province,
                          )
                        ],
                      );
                    },
                    itemSorter: (a, b) {
                      return a.autocompleteterm.compareTo(b.autocompleteterm);
                    },
                    itemFilter: (item, query) {
                      return item.autocompleteterm
                          .toLowerCase()
                          .startsWith(query.toLowerCase());
                    }),
              ]),
            ])));
  }
}
