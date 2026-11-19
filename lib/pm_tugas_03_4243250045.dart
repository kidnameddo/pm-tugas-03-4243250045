import 'dart:io';

const Map<String, double> _bobotNilai = {
  'A': 4,
  'B': 3,
  'C': 2,
  'D': 1,
  'E': 0,
};

class MataKuliah {
  const MataKuliah({
    required this.nama,
    required this.sks,
    required this.nilaiHuruf,
  });

  final String nama;
  final int sks;
  final String nilaiHuruf;

  double get bobot => konversiNilai(nilaiHuruf);
}

MataKuliah? mintaDataMataKuliah() {
  stdout.write('Nama mata kuliah (kosong untuk selesai): ');
  final nama = stdin.readLineSync();

  if (nama == null || nama.trim().isEmpty) {
    return null;
  }

  stdout.write('Jumlah SKS (1-6): ');
  final inputSks = stdin.readLineSync();
  final sks = int.tryParse(inputSks?.trim() ?? '');

  if (sks == null) {
    throw const FormatException('SKS harus berupa bilangan bulat.');
  }
  validasiSks(sks);

  stdout.write('Nilai huruf (A/B/C/D/E): ');
  final inputNilai = stdin.readLineSync() ?? '';
  final nilaiHuruf = validasiNilaiHuruf(inputNilai);

  return MataKuliah(nama: nama.trim(), sks: sks, nilaiHuruf: nilaiHuruf);
}

void validasiSks(int sks) {
  if (sks < 1 || sks > 6) {
    throw const FormatException('Jumlah SKS harus bilangan bulat 1-6.');
  }
}

String validasiNilaiHuruf(String nilaiHuruf) {
  final nilaiNormal = nilaiHuruf.trim().toUpperCase();
  if (!_bobotNilai.containsKey(nilaiNormal)) {
    throw const FormatException(
      'Nilai harus salah satu dari A, B, C, D, atau E.',
    );
  }

  return nilaiNormal;
}

double konversiNilai(String nilaiHuruf) {
  final nilaiNormal = nilaiHuruf.trim().toUpperCase();
  final bobot = _bobotNilai[nilaiNormal];

  if (bobot == null) {
    throw FormatException('Nilai huruf tidak dikenal: $nilaiHuruf');
  }

  return bobot;
}

double? hitungIP(List<MataKuliah> mataKuliah) {
  final (totalBobotTertimbang, totalSks) = mataKuliah.fold<(double, int)>(
    (0, 0),
    (total, mataKuliah) => (
      total.$1 + mataKuliah.bobot * mataKuliah.sks,
      total.$2 + mataKuliah.sks,
    ),
  );

  if (totalSks == 0) {
    return null;
  }

  return totalBobotTertimbang / totalSks;
}

List<MataKuliah> urutkanKHS(List<MataKuliah> mataKuliah) {
  final hasil = List<MataKuliah>.of(mataKuliah);
  hasil.sort((a, b) {
    final perbandinganBobot = b.bobot.compareTo(a.bobot);
    if (perbandinganBobot != 0) {
      return perbandinganBobot;
    }

    return a.nama.toLowerCase().compareTo(b.nama.toLowerCase());
  });
  return hasil;
}

void cetakKHS({required List<MataKuliah> mataKuliah}) {
  print('\nKARTU HASIL STUDI');
  print('No  Nama Mata Kuliah                SKS  Nilai  Bobot');
  print('------------------------------------------------------');

  final khsTerurut = urutkanKHS(mataKuliah);
  for (var index = 0; index < khsTerurut.length; index++) {
    final mataKuliah = khsTerurut[index];
    print(
      '${(index + 1).toString().padRight(4)}'
      '${mataKuliah.nama.padRight(32)}'
      '${mataKuliah.sks.toString().padRight(5)}'
      '${mataKuliah.nilaiHuruf.padRight(7)}'
      '${mataKuliah.bobot.toStringAsFixed(1)}',
    );
  }

  final totalSks = mataKuliah.fold<int>(
    0,
    (total, mataKuliah) => total + mataKuliah.sks,
  );
  final ipSemester = hitungIP(mataKuliah);

  print('------------------------------------------------------');
  print('Total SKS: $totalSks');
  if (ipSemester == null) {
    print('IP Semester: belum dapat dihitung (belum ada SKS).');
  } else {
    print('IP Semester: ${ipSemester.toStringAsFixed(2)}');
  }

  final nilaiDiBawahDua = mataKuliah
      .where((mataKuliah) => mataKuliah.bobot < 2)
      .toList();
  print('\nMata kuliah dengan bobot kurang dari 2:');
  if (nilaiDiBawahDua.isEmpty) {
    print('Tidak ada.');
  } else {
    for (final mataKuliah in nilaiDiBawahDua) {
      print(
        '- ${mataKuliah.nama} '
        '(${mataKuliah.nilaiHuruf}, bobot ${mataKuliah.bobot.toStringAsFixed(1)})',
      );
    }
  }
}
