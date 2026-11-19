import 'package:pm_tugas_03_4243250045/pm_tugas_03_4243250045.dart'
    as pm_tugas_03_4243250045;

void main(List<String> arguments) {
  final mataKuliah = <pm_tugas_03_4243250045.MataKuliah>[];

  print('Kalkulator IP Semester');
  print('Masukkan data mata kuliah. Nama kosong akan mengakhiri input.\n');

  while (true) {
    try {
      final dataMataKuliah = pm_tugas_03_4243250045.mintaDataMataKuliah();
      if (dataMataKuliah == null) {
        break;
      }

      mataKuliah.add(dataMataKuliah);
      print('Data mata kuliah berhasil ditambahkan.\n');
    } on FormatException catch (error) {
      print('\nInput tidak valid: ${error.message}');
      print('Silakan masukkan data mata kuliah berikutnya.\n');
    }
  }

  pm_tugas_03_4243250045.cetakKHS(mataKuliah: mataKuliah);
}
