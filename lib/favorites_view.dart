import 'package:dunya_ulkeleri/countries_list_view.dart';
import 'package:dunya_ulkeleri/country.dart';
import 'package:flutter/material.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView(this._countries, this._favoriteCountriesCca2, {super.key});

  final List<Country> _countries;

  final List<String> _favoriteCountriesCca2;

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final List<Country> _favoriteCountries = [];

  @override
  void initState() {
    super.initState();

    for (Country country in widget._countries) {
      if (widget._favoriteCountriesCca2.contains(country.cca2)) {
        _favoriteCountries.add(country);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: CountriesListView(_favoriteCountries, widget._favoriteCountriesCca2),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Favoriler'),
      centerTitle: true,
    );
  }
}
