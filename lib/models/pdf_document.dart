class PdfDocument {
  final String title;
  final String description;
  final String assetPath;

  const PdfDocument({
    required this.title,
    required this.description,
    required this.assetPath,
  });

  static const List<PdfDocument> samples = [
    PdfDocument(
      title: 'Regolamento',
      description: 'Regole e linee guida per l\'accademia',
      assetPath: 'assets/pdfs/regolamento.pdf',
    ),
    PdfDocument(
      title: 'Guida dell\'allievo',
      description: 'Informazioni essenziali per gli studenti',
      assetPath: 'assets/pdfs/guida_allievo.pdf',
    ),
  ];
}
