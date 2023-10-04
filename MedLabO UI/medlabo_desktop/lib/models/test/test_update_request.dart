class TestUpdateRequest {
  String? naziv;
  String? opis;
  double? cijena;
  String? slika;
  String? napomenaZaPripremu;
  String? tipUzorka;
  String? testParametarID;

  TestUpdateRequest(
      {this.naziv,
      this.opis,
      this.cijena,
      this.slika,
      this.napomenaZaPripremu,
      this.tipUzorka,
      this.testParametarID});

  Map<String, dynamic> toJson() => {
        'naziv': naziv,
        'opis': opis,
        'cijena': cijena,
        'slika': slika,
        'napomenaZaPripremu': napomenaZaPripremu,
        'tipUzorka': tipUzorka,
        'testParametarID': testParametarID,
      };
}
