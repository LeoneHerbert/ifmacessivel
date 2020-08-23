import 'dart:io';

class Questionnaire {
  const Questionnaire(
      this.id,
      this.text,
      this.q,
      this.situation,
      this.sector,
      this.image,
      );

  final String id;
  final String text;
  final double q;
  final String situation;
  final String sector;
  final File image;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return id;
      case 1:
        return text;
      case 2:
        return _formatCurrency(q);
      case 3:
        return situation;
    }
    return '';
  }

  String _formatCurrency(double amount) {
    return '${amount.toStringAsFixed(2)}'+'%';
  }
}