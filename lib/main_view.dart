import 'dart:convert';

import 'package:dunya_ulkeleri/countries_list_view.dart';
import 'package:dunya_ulkeleri/country.dart';
import 'package:dunya_ulkeleri/favorites_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final String _apiUrl = 'https://restcountries.com/v3.1/all?fields=name,cca2,capital,region,languages,population,flags';

  final List<Country> _countries = [];

  final List<String> _favoriteCountriesCca2 = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchLocalData().then((value) {
        _fetchApiData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _countries.isEmpty ? const Center(child: CircularProgressIndicator()) : CountriesListView(_countries, _favoriteCountriesCca2),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Dünya Ülkeleri'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            _navigationOnPressed(context, FavoritesView(_countries, _favoriteCountriesCca2));
          },
          icon: const Icon(Icons.favorite, color: Colors.red),
        ),
      ],
    );
  }

  void _navigationOnPressed(BuildContext context, Widget view) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) {
      return view;
    });
    Navigator.push(context, route);
  }

  Future<void> _fetchApiData() async {
    Uri uri = Uri.parse(_apiUrl);
    http.Response response = await http.get(uri);

    List<dynamic> listResponse = jsonDecode(response.body);

    for (int i = 0; i < listResponse.length; i++) {
      Country country = Country.fromMap(listResponse[i]);
      _countries.add(country);
    }

    setState(() {});
  }

  Future<void> _fetchLocalData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    List<String>? data = preferences.getStringList('favoriteCountries');

    if (data != null) {
      for (String value in data) {
        _favoriteCountriesCca2.add(value);
      }
    }
  }
}
