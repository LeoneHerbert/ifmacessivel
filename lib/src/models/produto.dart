class Produto {
  int id;
  String nome;
  String codigoDeBarra;
  String descricao;
  String categoria;
  String valor;
  String image;

  Produto({
    this.id,
    this.nome,
    this.codigoDeBarra,
    this.descricao,
    this.categoria,
    this.valor,
    this.image,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json["id"],
      nome: json["nome"],
      codigoDeBarra: json["codigo_de_barra"],
      descricao: json["descricao"],
      categoria: json["categoria"],
      valor: json["valor"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'codigo_de_barra': codigoDeBarra,
        'descricao': descricao,
        'categoria': categoria,
        'valor': valor,
        'image': image,
      };
}
