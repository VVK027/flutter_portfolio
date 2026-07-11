import 'package:flutter/material.dart';
import 'package:vvk_ui_kit/vvk_ui_kit.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';

class PortfolioShimmerView extends StatelessWidget {
  const PortfolioShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[900]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[800]! : Colors.grey[100]!;

    return Scaffold(
      backgroundColor: colors.scaffold,
      body: UIShimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderShimmer(),
                const SizedBox(height: 60),
                _buildSectionShimmer('About'),
                const SizedBox(height: 40),
                _buildSectionShimmer('Experience'),
                const SizedBox(height: 40),
                _buildProjectGridShimmer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderShimmer() {
    return Row(
      children: [
        const CircleAvatar(radius: 30, backgroundColor: Colors.white),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 180, height: 24, color: Colors.white),
            const SizedBox(height: 8),
            Container(width: 120, height: 16, color: Colors.white),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionShimmer(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 100, height: 20, color: Colors.white),
        const SizedBox(height: 16),
        Container(width: double.infinity, height: 12, color: Colors.white),
        const SizedBox(height: 8),
        Container(width: double.infinity, height: 12, color: Colors.white),
        const SizedBox(height: 8),
        Container(width: 250, height: 12, color: Colors.white),
      ],
    );
  }

  Widget _buildProjectGridShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 100, height: 20, color: Colors.white),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: _buildProjectCardShimmer()),
            const SizedBox(width: 16),
            Expanded(child: _buildProjectCardShimmer()),
          ],
        ),
      ],
    );
  }

  Widget _buildProjectCardShimmer() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
