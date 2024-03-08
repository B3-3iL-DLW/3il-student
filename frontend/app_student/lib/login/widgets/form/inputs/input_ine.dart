import 'package:flutter/material.dart';

class INETextField extends StatelessWidget {
  const INETextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 25.0,
          top: 10.0,
          right: 25.0), // Ajout d'un padding à gauche, en haut et à droite
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INE',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey[600],
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Numéro INE',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors
                        .grey), // Changement de la couleur de la bordure en gris
                borderRadius:
                    BorderRadius.zero, // Suppression de l'arrondi de la bordure
              ),
            ),
          ),
        ],
      ),
    );
  }
}
