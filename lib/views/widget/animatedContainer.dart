import 'package:flutter/material.dart';

class AnimatedCompanyCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final int index;
  final VoidCallback? onTap;
  final VoidCallback? onAvatarTap;

  const AnimatedCompanyCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.index,
    this.onTap,
    this.onAvatarTap,
  });

  @override
  State<AnimatedCompanyCard> createState() => _AnimatedCompanyCardState();
}

class _AnimatedCompanyCardState extends State<AnimatedCompanyCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    Future.delayed(Duration(milliseconds: widget.index * 150), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width *1;
    // final height = MediaQuery.of(context).size.height *0.3;
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Column(
        children: [
          InkWell(
            onTap: widget.onTap,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.imageUrl.isNotEmpty
                      ? widget.imageUrl
                      : "https://picsum.photos/400/300",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: widget.onAvatarTap,
                child: CircleAvatar(
                  radius: 14,
                  backgroundImage: NetworkImage(
                    widget.imageUrl.isNotEmpty
                        ? widget.imageUrl
                        : "https://picsum.photos/50/50",
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
