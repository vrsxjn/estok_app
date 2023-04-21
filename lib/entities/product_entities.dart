class Product {
  int id;
  String nome;
  String descricao;
  String image;
  double valor_item;
  double valor_unitario;
  int quantidade;
  String site;

  Product({
    this.id,
    this.nome,
    this.descricao,
    this.image,
    this.valor_item,
    this.valor_unitario,
    this.quantidade,
    this.site,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["id"] != null ? (json["id"] as num).toInt() : null,
        nome: (json["nome"] as String),
        descricao: (json["descricao"] as String),
        image: (json["imagem"] as String),
        valor_item: json["valor_item"] != null
            ? (json["valor_item"] as num).toDouble()
            : null,
        valor_unitario: json["valor_unitario"] != null
            ? (json["valor_unitario"] as num).toDouble()
            : null,
        quantidade: json["quantidade"] != null
            ? (json["quantidade"] as num).toInt()
            : null,
        site: (json["site"] as String));
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "nome": this.nome,
      "descricao": this.descricao,
      "imagem": this.image,
      "valor_item": this.valor_item,
      "valor_unitario": this.valor_unitario,
      "quantidade": this.quantidade,
      "site": this.site,
    };
  }

  Map<String, dynamic> toJsonPut() {
    return <String, dynamic>{
      "id": this.id,
      "nome": this.nome,
      "descricao": this.descricao,
      "imagem": this.image,
      "valor_item": this.valor_item,
      "valor_unitario": this.valor_unitario,
      "quantidade": this.quantidade,
      "site": this.site,
    };
  }
}
