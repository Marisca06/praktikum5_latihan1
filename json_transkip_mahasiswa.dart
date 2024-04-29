import 'dart:convert'; // Mengimpor pustaka dart:convert untuk mengonversi JSON menjadi objek Dart.

void main() {
  String transkripJson = '''
    {
      "nama": "Marisca Amanda",
      "NPM": "22082010065",
      "program_studi": {
        "nama": "Sistem informasi",
        "fakultas": "Ilmu Komputer"
      },
      "mata_kuliah": [
        {
          "kode": "SI765",
          "nama": "Pemrograman Desktop",
          "sks": 3,
          "nilai": "A"
        },
        {
          "kode": "SI766",
          "nama": "IMK",
          "sks": 3,
          "nilai": "A-"
        },
        {
          "kode": "SI767",
          "nama": "Basis Data",
          "sks": 3,
          "nilai": "B+"
        }
      ]
    }
    ''';

  Map<String, dynamic> transkrip = jsonDecode(
      transkripJson); // Mengonversi string JSON menjadi objek Dart menggunakan jsonDecode.

  double ipk = hitungIPK(transkrip); // Menghitung IPK dari transkrip mahasiswa.
  print('Nama: ${transkrip['nama']}'); // Mencetak nama mahasiswa.
  print('NPM: ${transkrip['NPM']}'); // Mencetak NPM mahasiswa.
  print('Program Studi: ${transkrip['program_studi']['nama']}'); // Mencetak nama program studi mahasiswa.
  print('Fakultas: ${transkrip['program_studi']['fakultas']}'); // Mencetak fakultas mahasiswa.
  print('Mata Kuliah:'); // Mencetak header untuk daftar mata kuliah.
  for (var mataKuliah in transkrip['mata_kuliah']) { // Melakukan iterasi melalui setiap mata kuliah dalam transkrip.
    print( '- ${mataKuliah['kode']} - ${mataKuliah['nama']} (${mataKuliah['sks']} SKS) - Nilai: ${mataKuliah['nilai']}'); // Mencetak informasi setiap mata kuliah, termasuk kode, nama, SKS, dan nilai.
  }
  print('IPK: $ipk'); // Mencetak IPK mahasiswa.
}

double hitungIPK(Map<String, dynamic> transkrip) { // Fungsi untuk menghitung IPK.
  int totalSks = 0; // Variabel untuk menyimpan total SKS.
  double totalBobot = 0.0; // Variabel untuk menyimpan total bobot.

  for (var mataKuliah in transkrip['mata_kuliah']) {  // Melakukan iterasi melalui setiap mata kuliah dalam transkrip.
    int sks = mataKuliah['sks']; // Mendapatkan jumlah SKS mata kuliah.
    totalSks += sks; // Menambahkan jumlah SKS ke total SKS.
    String nilai = mataKuliah['nilai']; // Mendapatkan nilai mata kuliah.
    double bobot = 0.0; // Variabel untuk menyimpan bobot nilai.

    // Menghitung bobot berdasarkan nilai.
    if (nilai == 'A') {
      bobot = 4.0;
    } else if (nilai == 'A-') {
      bobot = 3.75;
    } else if (nilai == 'B+') {
      bobot = 3.5;
    } else if (nilai == 'B') {
      bobot = 3.25;
    }

    totalBobot +=
        (bobot * sks); // Menambahkan bobot nilai kali SKS ke total bobot.
  }

  if (totalSks == 0) {// Memeriksa apakah total SKS adalah nol untuk menghindari pembagian dengan nol.
    return 0.0;
  } else {
    return totalBobot /
        totalSks; // Mengembalikan IPK, yaitu total bobot dibagi dengan total SKS.
  }
}
