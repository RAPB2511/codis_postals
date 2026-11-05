import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/place.dart';
import '../models/search_response.dart';
import '../styles/app_styles.dart';
import 'place_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  // Controlo els diferents estats de la pantalla per saber què mostrar en cada moment
  String _currentState = 'initial'; // initial, loading, success, empty, error
  List<Place> _places = [];
  String _lastQuery = '';
  String _errorMessage = '';

  // Funció per fer la petició a l'API d'Open-Meteo
  Future<void> _searchPlaces(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      _currentState = 'loading'; // Mostro el cercle de càrrega
      _lastQuery = query;
    });

    try {
      final url = Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$query&language=ca&countryCode=ES',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final searchResponse = searchResponseFromJson(response.body);

        setState(() {
          _places = searchResponse.results;
          if (_places.isNotEmpty) {
            _currentState = 'success'; // Hi ha resultats, mostro la llista
          } else {
            _currentState = 'empty'; // No s'ha trobat res
          }
        });
      } else {
        setState(() {
          _currentState = 'error';
          _errorMessage = 'Error del servidor (Codi: ${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        _currentState = 'error'; // Si no hi ha internet o falla la xarxa
        _errorMessage = 'Sense connexió a internet o error de xarxa.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Cercador de Codis Postals',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppStyles.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppStyles.paddingM),
        child: Column(
          children: [
            // El quadre de text per buscar
            TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) => _searchPlaces(value),
              decoration: InputDecoration(
                hintText: 'Escriu un codi postal o població...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppStyles.primaryColor,
                ),
                filled: true,
                fillColor: AppStyles.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: AppStyles.paddingM),
            Expanded(
              child: _buildBodyContent(), // Conmuto segons l'estat actual
            ),
          ],
        ),
      ),
    );
  }

  // Mètode per decidir quina vista mostrar segons l'estat de la cerca
  Widget _buildBodyContent() {
    switch (_currentState) {
      case 'initial':
        return const Center(
          child: Text(
            'Introdueix un codi postal o el nom d\'una població per començar la cerca.',
            textAlign: TextAlign.center,
            style: AppStyles.infoMessageStyle,
          ),
        );

      case 'loading':
        return const Center(
          child: CircularProgressIndicator(color: AppStyles.primaryColor),
        );

      case 'empty':
        return Center(
          child: Text(
            'No hem trobat cap població per a "$_lastQuery".',
            textAlign: TextAlign.center,
            style: AppStyles.infoMessageStyle,
          ),
        );

      case 'error':
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
                color: AppStyles.errorColor,
              ),
              const SizedBox(height: AppStyles.paddingS),
              Text(
                _errorMessage,
                textAlign: TextAlign.center,
                style: AppStyles.bodyStyle,
              ),
              const SizedBox(height: AppStyles.paddingM),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.primaryColor,
                ),
                onPressed: () => _searchPlaces(_lastQuery),
                child: const Text(
                  'Tornar a provar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );

      case 'success':
        return ListView.builder(
          itemCount: _places.length,
          itemBuilder: (context, index) {
            final place = _places[index];
            return Card(
              color: AppStyles.cardColor,
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                title: Text(place.name, style: AppStyles.subtitleStyle),
                subtitle: Text(
                  '${place.admin2 ?? ""}, ${place.admin1}',
                  style: AppStyles.bodyStyle,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // En clicar, salto a la pantalla de detall passant l'objecte place
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaceDetailScreen(place: place),
                    ),
                  );
                },
              ),
            );
          },
        );

      default:
        return Container();
    }
  }
}
