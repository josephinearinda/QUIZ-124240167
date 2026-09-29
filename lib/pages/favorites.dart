import 'package:flutter/material.dart';

import '../culinaryModels.dart';
import '../services/favorite_manager.dart';
import 'culinaryDetail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F0),
      appBar: AppBar(
        title: const Text(
          'Kuliner Favorit',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            color: Color(0xFF1D3428),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF7F5F0),
        elevation: 0,
      ),
      body: ValueListenableBuilder<Set<int>>(
        valueListenable: FavoriteManager.instance.favoritesNotifier,
        builder: (context, favorites, _) {
          final favoriteCulinary = culinaryList
              .where((culinary) => favorites.contains(culinary.id))
              .toList();

          if (favoriteCulinary.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF9E9DF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border_rounded,
                        size: 64,
                        color: Color(0xFFD95D39),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Belum Ada Kuliner Favorit',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D3428),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tekan ikon hati pada kuliner yang kamu suka untuk menampilkannya di sini.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF73786F),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: favoriteCulinary.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final culinary = favoriteCulinary[index];

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x08000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CulinaryDetailPage(culinary: culinary),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              culinary.imageUrl,
                              width: 70,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 70,
                                  height: 100,
                                  color: const Color(0xFFE8E6DC),
                                  child: const Icon(
                                    Icons.broken_image_rounded,
                                    color: Color(0xFF78816F),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF9E9DF),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    culinary.category,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFAD5738),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  culinary.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1D3428),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  culinary.origin,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF73786F),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.local_fire_department_rounded,
                                      color: Color(0xFFD16A43),
                                      size: 15,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      culinary.spicyLevel,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1D3428),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.favorite_rounded,
                              color: Color(0xFFD95D39),
                              size: 26,
                            ),
                            tooltip: 'Hapus dari Favorit',
                            onPressed: () {
                              FavoriteManager.instance.toggleFavorite(
                                culinary.id,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
