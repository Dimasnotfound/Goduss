class Tracking {
  int? id;
  int? idUser;
  int? idAlamatPenjual;
  int? idAlamatPembeli;
  int? idRekap;

  Tracking({
    this.id,
    this.idUser,
    this.idAlamatPenjual,
    this.idAlamatPembeli,
    this.idRekap,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_tracking': id,
      'FK_idUser': idUser,
      'FK_idalamat_penjual': idAlamatPenjual,
      'FK_idalamat_pembeli': idAlamatPembeli,
      'FK_idRekap': idRekap,
    };
  }
}
