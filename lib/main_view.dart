import 'dart:convert';

import 'package:dunya_ulkeleri/country.dart';
import 'package:dunya_ulkeleri/detail_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final String _apiUrl = 'https://restcountries.com/v3.1/all?fields=name,cca2,capital,region,languages,population,flags';

  final List<dynamic> _countries = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Dünya Ülkeleri'),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: _countries.length,
      itemBuilder: _buildListItem,
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Country country = _countries[index];
    return Card(
      child: ListTile(
        onTap: () {
          _listTileClick(context, DetailView(country));
        },
        leading: CircleAvatar(backgroundImage: NetworkImage(country.flag)),
        title: Text(country.name),
        subtitle: Text('Başkent: ${country.capital}'),
        trailing: const Icon(Icons.favorite_border, color: Colors.red),
      ),
    );
  }

  void _listTileClick(BuildContext context, Widget view) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) {
      return view;
    });
    Navigator.push(context, route);
  }

  Future<void> _fetchData() async {
    Uri uri = Uri.parse(_apiUrl);
    http.Response response = await http.get(uri);

    List<dynamic> listResponse = jsonDecode(response.body);

    for (int i = 0; i < listResponse.length; i++) {
      Country country = Country.fromMap(listResponse[i]);
      _countries.add(country);
    }

    setState(() {});
  }
}
