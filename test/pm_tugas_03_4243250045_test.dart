import 'package:pm_tugas_03_4243250045/pm_tugas_03_4243250045.dart';
import 'package:test/test.dart';

void main() {
  group('konversi dan validasi nilai', () {
    test('menggunakan skema nilai pada modul', () {
      expect(konversiNilai('A'), 4);
      expect(konversiNilai('B'), 3);
      expect(konversiNilai('C'), 2);
      expect(konversiNilai('D'), 1);
      expect(konversiNilai('E'), 0);
    });

    test('menormalisasi nilai huruf dan membatasi SKS', () {
      expect(validasiNilaiHuruf(' b '), 'B');
      expect(() => validasiSks(0), throwsFormatException);
      expect(() => validasiSks(7), throwsFormatException);
      expect(() => validasiNilaiHuruf('AB'), throwsFormatException);
    });
  });

  group('perhitungan KHS', () {
    test('menghitung IP dengan bobot tertimbang dan total SKS', () {
      final mataKuliah = [
        const MataKuliah(nama: 'Pemrograman', sks: 3, nilaiHuruf: 'A'),
        const MataKuliah(nama: 'Matematika', sks: 2, nilaiHuruf: 'C'),
      ];

      expect(hitungIP(mataKuliah), 3.2);
    });

    test('tidak membagi dengan nol saat belum ada mata kuliah', () {
      expect(hitungIP([]), isNull);
    });

    test('mengurutkan KHS dari bobot tertinggi', () {
      final hasil = urutkanKHS([
        const MataKuliah(nama: 'Bahasa', sks: 2, nilaiHuruf: 'E'),
        const MataKuliah(nama: 'Pemrograman', sks: 3, nilaiHuruf: 'A'),
        const MataKuliah(nama: 'Matematika', sks: 2, nilaiHuruf: 'C'),
      ]);

      expect(hasil.map((mataKuliah) => mataKuliah.nilaiHuruf), ['A', 'C', 'E']);
    });
  });
}
