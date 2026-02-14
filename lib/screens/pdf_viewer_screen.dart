import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../models/pdf_document.dart';
import '../theme/app_theme.dart';

class PdfViewerScreen extends StatefulWidget {
  final PdfDocument document;

  const PdfViewerScreen({super.key, required this.document});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final PdfViewerController _controller = PdfViewerController();
  final TextEditingController _searchController = TextEditingController();
  PdfTextSearchResult? _searchResult;
  bool _isSearchOpen = false;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _searchController.dispose();
    _searchResult?.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearchOpen = !_isSearchOpen;
      if (!_isSearchOpen) {
        _searchResult?.clear();
        _searchController.clear();
      }
    });
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _performSearch(query);
    });
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      _searchResult?.clear();
      setState(() => _searchResult = null);
      return;
    }
    _searchResult = _controller.searchText(query);
    _searchResult!.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearchOpen
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: 'Search in PDF...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: _onSearchChanged,
              )
            : Text(widget.document.title),
        actions: [
          if (_isSearchOpen && _searchResult != null && _searchResult!.totalInstanceCount > 0) ...[
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  '${_searchResult!.currentInstanceIndex + 1}/${_searchResult!.totalInstanceCount}',
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_up),
              onPressed: () => _searchResult?.previousInstance(),
            ),
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_down),
              onPressed: () => _searchResult?.nextInstance(),
            ),
          ],
          IconButton(
            icon: Icon(_isSearchOpen ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: SfPdfViewer.asset(
        widget.document.assetPath,
        controller: _controller,
      ),
    );
  }
}
