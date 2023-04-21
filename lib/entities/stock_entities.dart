class Stock {
  int id;
  String descricao;
  int quantidade_total;
  String data_entrada;
  String data_validade;
  String tipo;
  String status_estoque;

  Stock({
    this.id,
    this.descricao,
    this.quantidade_total,
    this.data_entrada,
    this.data_validade,
    this.tipo,
    this.status_estoque,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json["id"] != null ? (json["id"] as num).toInt() : null,
      descricao: (json["descricao"] as String),
      quantidade_total: json["quantidade_total"] != null
          ? (json["quantidade_total"] as num).toInt()
          : null,
      data_entrada: (json["data_entrada"] as String),
      data_validade: (json["data_validade"] as String),
      tipo: (json["tipo"] as String),
      status_estoque: (json["status_estoque"] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "descricao": this.descricao,
      "quantidade_total": this.quantidade_total,
      "data_entrada": this.data_entrada,
      "data_validade": this.data_validade,
      "tipo": this.tipo,
    };
  }

  Map<String, dynamic> toJsonPut() {
    return <String, dynamic>{
      "id": this.id,
      "descricao": this.descricao,
      "quantidade_total": this.quantidade_total,
      "data_entrada": this.data_entrada,
      "data_validade": this.data_validade,
      "tipo": this.tipo,
    };
  }
}
