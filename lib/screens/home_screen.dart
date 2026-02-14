import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/pdf_document.dart';
import '../theme/app_theme.dart';
import 'chat_screen.dart';
import 'pdf_viewer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/img/logo.png',
              height: 32,
              width: 32,
            ),
            const SizedBox(width: 10),
            const Text('HakFuJow'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: PdfDocument.samples.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final doc = PdfDocument.samples[index];
                  return _PdfCard(document: doc);
                },
              ),
            ),
          ),
          const _Footer(),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: FloatingActionButton(
          backgroundColor: AppTheme.primary,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChatScreen()),
            );
          },
          child: const Icon(Icons.chat),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class _PdfCard extends StatelessWidget {
  final PdfDocument document;

  const _PdfCard({required this.document});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: const Icon(Icons.picture_as_pdf, color: AppTheme.primary, size: 36),
        title: Text(
          document.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          document.description,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PdfViewerScreen(document: document),
            ),
          );
        },
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Codice Fiscale 95124770652',
            style: TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          const Text(
            'HUNG GAR - WING CHUN - NAAM HAK FU JOW KYUN - HEI KUNG - DANZA DEL LEONE',
            style: TextStyle(color: Colors.white70, fontSize: 10),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          const Text(
            'Kung Fu Tradizionale',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => launchUrl(Uri.parse('https://www.evolva.it/ws/hakfujow/')),
            child: const Text(
              'www.evolva.it/ws/hakfujow',
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 12,
                decoration: TextDecoration.underline,
                decorationColor: Colors.lightBlueAccent,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
