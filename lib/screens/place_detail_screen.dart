import 'package:flutter/material.dart';

import '../models/place.dart';
import '../styles/app_styles.dart';

// Pantalla de detall per veure tota la info d'una població quan la toques (Ampliació)
class PlaceDetailScreen extends StatelessWidget {
  final Place place;

  const PlaceDetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name, style: const TextStyle(color: Colors.white)),
        backgroundColor: AppStyles.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: AppStyles.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(AppStyles.paddingM),
        child: ListView(
          children: [
            // Targeta amb la ubicació i província
            Card(
              color: AppStyles.cardColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppStyles.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ubicació', style: AppStyles.titleStyle),
                    const Divider(),
                    Text(
                      'Comunitat: ${place.admin1}',
                      style: AppStyles.bodyStyle,
                    ),
                    const SizedBox(height: AppStyles.paddingS),
                    Text(
                      'Província: ${place.admin2 ?? "No disponible"}',
                      style: AppStyles.bodyStyle,
                    ),
                    const SizedBox(height: AppStyles.paddingS),
                    Text('País: ${place.country}', style: AppStyles.bodyStyle),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppStyles.paddingM),
            // Targeta amb habitants i coordenades
            Card(
              color: AppStyles.cardColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppStyles.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dades demogràfiques i geogràfiques',
                      style: AppStyles.titleStyle,
                    ),
                    const Divider(),
                    Text(
                      'Habitants: ${place.population ?? "Desconeguts"}',
                      style: AppStyles.bodyStyle,
                    ),
                    const SizedBox(height: AppStyles.paddingS),
                    Text(
                      'Latitud: ${place.latitude}',
                      style: AppStyles.bodyStyle,
                    ),
                    const SizedBox(height: AppStyles.paddingS),
                    Text(
                      'Longitud: ${place.longitude}',
                      style: AppStyles.bodyStyle,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppStyles.paddingM),
            // Targeta amb els codis postals en format Chip dins d'un Wrap
            Card(
              color: AppStyles.cardColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppStyles.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Codis Postals', style: AppStyles.titleStyle),
                    const Divider(),
                    const SizedBox(height: AppStyles.paddingS),
                    Wrap(
                      spacing: 6.0,
                      runSpacing: 6.0,
                      children: (place.postcodes ?? []).isNotEmpty
                          ? (place.postcodes!)
                                .map(
                                  (code) => Chip(
                                    label: Text(code),
                                    backgroundColor: AppStyles.primaryColor
                                        .withValues(alpha: 0.1),
                                  ),
                                )
                                .toList()
                          : [
                              const Text(
                                'No hi ha codis postals registrats',
                                style: AppStyles.bodyStyle,
                              ),
                            ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
