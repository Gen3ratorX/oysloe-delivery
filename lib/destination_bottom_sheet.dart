import 'package:flutter/material.dart';

class DestinationBottomSheet extends StatelessWidget {
  final ScrollController scrollController;
  final Function(String)? onLocationSelected;
  final VoidCallback? onLocationPinTap;

  const DestinationBottomSheet({
    super.key,
    required this.scrollController,
    this.onLocationSelected,
    this.onLocationPinTap,
  });

  @override
  Widget build(BuildContext context) {
    final locations = [
      'China Mall, Ashaiman',
      'Lashibi community 23 park',
      'Spintex opposite coastal estate',
      'Mama mo beauty care',
      'China Mall, Ashaiman',
      'Lashibi community 23 park',
      'Spintex opposite coastal estate',
      'Mama mo beauty care',
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: CustomScrollView(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          // ─────────────── Top Section ───────────────
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),

                // Search box
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PhysicalModel(
                    color: Colors.white,
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    child: Row(
                      children: [
                        // Destination input
                        Expanded(
                          child: Container(
                            height: 56,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 22,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Destination',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF333333),
                                        ),
                                      ),
                                      Flexible(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Drop off to?',
                                            hintStyle: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 12.5,
                                            ),
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                            border: InputBorder.none,
                                          ),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF111111),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Pin button
                        GestureDetector(
                          onTap: onLocationPinTap,
                          child: Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/loc_pin.png',
                                width: 27,
                                height: 27,
                                color: const Color(0xFF2F3C48),
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.my_location,
                                    color: const Color(0xFF2F3C48),
                                    size: 27,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Divider(
                  color: Colors.grey.shade300,
                  height: 1,
                  thickness: 1,
                ),
              ],
            ),
          ),

          // ─────────────── List Section ───────────────
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final location = locations[index];
                return InkWell(
                  onTap: () {
                    onLocationSelected?.call(location);
                  },
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 20,
                          color: Colors.grey.shade700,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                location,
                                style: const TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF222222),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Greater Accra, Ashaiman Municipality',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: locations.length,
            ),
          ),
        ],
      ),
    );
  }
}
