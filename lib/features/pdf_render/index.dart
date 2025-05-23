import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PDFRenderScreen extends StatefulWidget {
  String urlBuku;
  PDFRenderScreen({super.key, required this.urlBuku});

  @override
  State<PDFRenderScreen> createState() => _PDFRenderScreenState();
}

class _PDFRenderScreenState extends State<PDFRenderScreen> {
  final PdfViewerController _pdfController = PdfViewerController();
  int _currentPage = 1;
  int _totalPages = 1;
  late PdfBookmarkBase _bookmarks;
  bool _hasBookmarks = false;

  @override
  void initState() {
    super.initState();
    _loadLastPage();
  }

  Future<void> _loadLastPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedPage = prefs.getInt('last_read_page');
    if (savedPage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pdfController.jumpToPage(savedPage);
      });
    }
  }

  Future<void> _saveLastPage(int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_read_page', page);
  }

  void _handleDocumentLoaded(PdfDocumentLoadedDetails details) {
    final toc = details.document.bookmarks;
    if (toc.count > 0) {
      setState(() {
        _bookmarks = toc;
        _hasBookmarks = true;
      });
    }
    setState(() {
      _totalPages = details.document.pages.count;
    });
  }

  void _showBookmarksDialog(PdfBookmarkBase bookmark) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Daftar Isi'),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: ListView(children: _buildBookmarkList(bookmark)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildBookmarkList(PdfBookmarkBase bookmark) {
    List<Widget> items = [];
    for (int i = 0; i < bookmark.count; i++) {
      final item = bookmark[i];
      items.add(
        ListTile(
          title: Text(item.title),
          onTap: () {
            if (item.destination != null) {
              _pdfController.jumpToPage(
                item.destination!.page.defaultLayerIndex,
              );
              Navigator.pop(context);
            }
          },
        ),
      );
      if (item.count > 0) {
        items.addAll(_buildBookmarkList(item));
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              if (_hasBookmarks) {
                _showBookmarksDialog(_bookmarks);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("PDF ini tidak memiliki daftar isi"),
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              _saveLastPage(_currentPage);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Halaman disimpan!')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SfPdfViewer.network(
              widget.urlBuku,
              controller: _pdfController,
              onDocumentLoaded: _handleDocumentLoaded,
              onPageChanged: (details) {
                setState(() {
                  _currentPage = details.newPageNumber;
                });
                _saveLastPage(details.newPageNumber);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Slider(
                  min: 1,
                  max: _totalPages.toDouble(),
                  divisions: _totalPages > 1 ? _totalPages - 1 : null,
                  value: _currentPage.toDouble().clamp(
                    1,
                    _totalPages.toDouble(),
                  ),
                  onChanged: (value) {
                    _pdfController.jumpToPage(value.toInt());
                  },
                ),
                Text('Halaman $_currentPage / $_totalPages'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
