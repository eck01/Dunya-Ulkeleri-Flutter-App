import 'package:dunya_ulkeleri/country.dart';
import 'package:dunya_ulkeleri/detail_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountriesListView extends StatefulWidget {
  const CountriesListView(this._countries, this._favoriteCountriesCca2, {super.key});

  final List<Country> _countries;

  final List<String> _favoriteCountriesCca2;

  @override
  State<CountriesListView> createState() => _CountriesListViewState();
}

class _CountriesListViewState extends State<CountriesListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget._countries.length,
      itemBuilder: _buildListItem,
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Country country = widget._countries[index];
    return Card(
      child: ListTile(
        onTap: () {
          _navigationOnPressed(context, DetailView(country));
        },
        leading: CircleAvatar(backgroundImage: NetworkImage(country.flag)),
        title: Text(country.name),
        subtitle: Text('Başkent: ${country.capital}'),
        trailing: IconButton(
          onPressed: () {
            _favoriteButtonOnPressed(country.cca2);
          },
          icon: Icon(widget._favoriteCountriesCca2.contains(country.cca2) ? Icons.favorite : Icons.favorite_border, color: Colors.red),
        ),
      ),
    );
  }

  void _navigationOnPressed(BuildContext context, Widget view) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) {
      return view;
    });
    Navigator.push(context, route);
  }

  Future<void> _favoriteButtonOnPressed(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (widget._favoriteCountriesCca2.contains(value)) {
      widget._favoriteCountriesCca2.remove(value);
    } else {
      widget._favoriteCountriesCca2.add(value);
    }

    await preferences.setStringList('favoriteCountries', widget._favoriteCountriesCca2);
    setState(() {});
  }
}
