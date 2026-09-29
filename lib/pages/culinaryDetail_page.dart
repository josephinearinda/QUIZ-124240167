import 'package:flutter/material.dart';

import '../culinaryModels.dart';
import '../services/favorite_manager.dart';

class CulinaryDetailPage extends StatefulWidget {
  final Culinary culinary;

  const CulinaryDetailPage({super.key, required this.culinary});

  @override
  State<CulinaryDetailPage> createState() => _CulinaryDetailPageState();
}

class _CulinaryDetailPageState extends State<CulinaryDetailPage> {
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF899080)),
          const SizedBox(width: 10),
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Color(0xFF526457),
              ),
            ),
          ),
          const Text(' :  ', style: TextStyle(color: Color(0xFF92968E))),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1D3428),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final culinary = widget.culinary;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F0),
      appBar: AppBar(
        title: Text(
          culinary.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            color: Color(0xFF1D3428),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF7F5F0),
        elevation: 0,
        leading: IconButton(
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF526457)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          ValueListenableBuilder<Set<int>>(
            valueListenable: FavoriteManager.instance.favoritesNotifier,
            builder: (context, favorites, _) {
              final isFavorite = favorites.contains(culinary.id);
              return IconButton(
                tooltip: isFavorite
                    ? 'Hapus dari favorit'
                    : 'Tambah ke favorit',
                onPressed: () =>
                    FavoriteManager.instance.toggleFavorite(culinary.id),
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite
                      ? const Color(0xFFD95D39)
                      : const Color(0xFF899080),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x24000000),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    culinary.imageUrl,
                    height: 270,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 270,
                        width: 180,
                        color: const Color(0xFFE8E6DC),
                        child: const Center(
                          child: Icon(
                            Icons.broken_image_rounded,
                            size: 50,
                            color: Color(0xFF92968E),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              culinary.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.3,
                color: Color(0xFF1D3428),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Asal: ${culinary.origin}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF73786F),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE8E6DC)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x05000000),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Informasi Kuliner',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D3428),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1, color: Color(0xFFE8E6DC)),
                  const SizedBox(height: 6),
                  _buildDetailRow(
                    Icons.category_rounded,
                    'Kategori',
                    culinary.category,
                  ),
                  _buildDetailRow(
                    Icons.location_on_rounded,
                    'Asal',
                    culinary.origin,
                  ),
                  _buildDetailRow(
                    Icons.kitchen_rounded,
                    'Bahan utama',
                    culinary.mainIngredient,
                  ),
                  _buildDetailRow(
                    Icons.restaurant_rounded,
                    'Rasa',
                    culinary.flavor,
                  ),
                  _buildDetailRow(
                    Icons.whatshot_rounded,
                    'Level pedas',
                    culinary.spicyLevel,
                  ),
                  _buildDetailRow(
                    Icons.access_time_rounded,
                    'Waktu sajian',
                    culinary.servingTime,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE8E6DC)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x05000000),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D3428),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1, color: Color(0xFFE8E6DC)),
                  const SizedBox(height: 12),
                  Text(
                    culinary.description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Color(0xFF526457),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
