import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vivekdevfolio/presentation/widgets/carousel/carousel_controls.dart';

export 'package:vivekdevfolio/presentation/widgets/carousel/carousel_layout.dart';

/// Horizontal paging carousel with prev/next controls and pill-dot indicators.
class SectionCarousel extends StatefulWidget {
  final int pageCount;
  final IndexedWidgetBuilder pageBuilder;
  final double pageHeight;
  final EdgeInsetsGeometry? padding;
  final bool autoPlay;
  final Duration autoPlayInterval;

  final CarouselControlsColors? controlsColors;

  const SectionCarousel({
    super.key,
    required this.pageCount,
    required this.pageBuilder,
    required this.pageHeight,
    this.padding,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 1),
    this.controlsColors = const CarouselControlsColors(),
  });

  @override
  State<SectionCarousel> createState() => _SectionCarouselState();
}

class _SectionCarouselState extends State<SectionCarousel> {
  late final PageController _controller;
  int _currentPage = 0;
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _scheduleAutoPlay();
  }

  @override
  void didUpdateWidget(SectionCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pageCount != widget.pageCount ||
        oldWidget.autoPlay != widget.autoPlay ||
        oldWidget.autoPlayInterval != widget.autoPlayInterval) {
      _scheduleAutoPlay();
    }
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _scheduleAutoPlay() {
    _autoPlayTimer?.cancel();
    if (!widget.autoPlay || widget.pageCount <= 1) return;

    _autoPlayTimer = Timer.periodic(widget.autoPlayInterval, (_) {
      if (!mounted || !_controller.hasClients) return;
      final next = (_currentPage + 1) % widget.pageCount;
      _goToPage(next, fromAutoPlay: true);
    });
  }

  void _goToPage(int index, {bool fromAutoPlay = false}) {
    if (index < 0 || index >= widget.pageCount) return;
    if (!fromAutoPlay) _scheduleAutoPlay();

    _controller.animateToPage(
      index,
      duration: Duration(milliseconds: fromAutoPlay ? 450 : 320),
      curve: Curves.easeInOutCubic,
    );
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pageCount == 0) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.pageHeight,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.pageCount,
            onPageChanged: _onPageChanged,
            padEnds: false,
            itemBuilder: widget.pageBuilder,
          ),
        ),
        const SizedBox(height: 20),
        CarouselControls(
          pageCount: widget.pageCount,
          currentPage: _currentPage,
          loop: widget.autoPlay,
          colors: widget.controlsColors,
          onPrevious: () {
            final prev = _currentPage == 0
                ? widget.pageCount - 1
                : _currentPage - 1;
            _goToPage(prev);
          },
          onNext: () {
            final next = (_currentPage + 1) % widget.pageCount;
            _goToPage(next);
          },
          onPageSelected: _goToPage,
        ),
      ],
    );
  }
}
