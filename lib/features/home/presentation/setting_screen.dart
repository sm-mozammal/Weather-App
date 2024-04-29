import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/change_unite_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //late WeatherProvider provider;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Consumer<ChangeUnitPorvider>(
          builder: (context, provider, child) => ListView(
            children: [
              SwitchListTile(
                  title: const Text('Show tempareture in farenheit'),
                  subtitle: const Text('Default is celcius'),
                  value: provider.select,
                  onChanged: (value) {
                    provider.changeUnit(value);
                  })
            ],
          ),
        ));
  }
}
