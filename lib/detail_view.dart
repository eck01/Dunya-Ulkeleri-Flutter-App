import 'package:dunya_ulkeleri/country.dart';
import 'package:flutter/material.dart';

class DetailView extends StatelessWidget {
  const DetailView(this.country, {super.key});

  final Country country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(country.name),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(width: double.infinity, height: 32.0),
        _buildFlag(context),
        const SizedBox(height: 24.0),
        _buildNameText(),
        const SizedBox(height: 24.0),
        _buildDetailColumn(context),
      ],
    );
  }

  Widget _buildFlag(BuildContext context) {
    return Image.network(
      country.flag,
      width: MediaQuery.sizeOf(context).width / 2,
      fit: BoxFit.fitWidth,
    );
  }

  Widget _buildNameText() {
    return Text(
      country.name,
      style: const TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDetailColumn(BuildContext context) {
    return Column(children: [
      _buildDetailText(context: context, title: 'Alfa-2 Ülke Kodu:', detail: country.cca2),
      _buildDetailText(context: context, title: 'Başkent:', detail: country.capital),
      _buildDetailText(context: context, title: 'Bölge:', detail: country.region),
      _buildDetailText(context: context, title: 'Dil:', detail: country.language),
      _buildDetailText(context: context, title: 'Nüfus:', detail: country.population.toString()),
    ]);
  }

  Widget _buildDetailText({required BuildContext context, required String title, required String detail}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              detail,
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
