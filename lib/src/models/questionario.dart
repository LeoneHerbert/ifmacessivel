class Questionario {
  const Questionario(
      this.id,
      this.texto,
      this.q,
      this.situacao,
      this.setor,
      );

  final String id;
  final String texto;
  final double q;
  final String situacao;
  final String setor;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return id;
      case 1:
        return texto;
      case 2:
        return _formatCurrency(q);
      case 3:
        return situacao;
    }
    return '';
  }

  String _formatCurrency(double amount) {
    return '${amount.toStringAsFixed(2)}'+'%';
  }
}