import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        scaffoldBackgroundColor: Colors.white,
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 2,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      home: const StudentGrid(),
    );
  }
}

class StudentGrid extends StatelessWidget {
  const StudentGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final students = [
      {
        'nama': 'Yoga Dwi Anggoro',
        'nim': '2203012345',
        'prodi': 'Teknik Informatika',
        'foto': 'https://i.pravatar.cc/150?img=3',
      },
      {
        'nama': 'Rani Putri',
        'nim': '2203012346',
        'prodi': 'Sistem Informasi',
        'foto': 'https://i.pravatar.cc/150?img=5',
      },
      {
        'nama': 'Fikri Ramadhan',
        'nim': '2203012347',
        'prodi': 'Teknik Komputer',
        'foto': 'https://i.pravatar.cc/150?img=8',
      },
      {
        'nama': 'Nadia Salsabila',
        'nim': '2203012348',
        'prodi': 'Manajemen Informatika',
        'foto': 'https://i.pravatar.cc/150?img=9',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade400,
        title: const Text(
          "Kartu Mahasiswa",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: students.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3 / 4,
          ),
          itemBuilder: (context, index) {
            final s = students[index];
            return StudentCard(
              nama: s['nama']!,
              nim: s['nim']!,
              prodi: s['prodi']!,
              foto: s['foto']!,
            );
          },
        ),
      ),
    );
  }
}

// ===================== CARD MAHASISWA DENGAN AVATAR DINAMIS =====================
class StudentCard extends StatefulWidget {
  final String nama;
  final String nim;
  final String prodi;
  final String foto;

  const StudentCard({
    super.key,
    required this.nama,
    required this.nim,
    required this.prodi,
    required this.foto,
  });

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        splashColor: Colors.teal.shade50,
        highlightColor: Colors.teal.shade100.withOpacity(0.2),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailPage(
                nama: widget.nama,
                nim: widget.nim,
                prodi: widget.prodi,
                foto: widget.foto,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundImage: _pickedImage != null
                        ? FileImage(_pickedImage!)
                        : NetworkImage(widget.foto) as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.teal.shade400,
                        child: const Icon(
                          Icons.camera_alt,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.nama,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.nim,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                widget.prodi,
                style: TextStyle(
                  color: Colors.teal.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(
                        nama: widget.nama,
                        nim: widget.nim,
                        prodi: widget.prodi,
                        foto: widget.foto,
                      ),
                    ),
                  );
                },
                child: const Text("Lihat Detail"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===================== DETAIL PAGE =====================
class DetailPage extends StatelessWidget {
  final String nama;
  final String nim;
  final String prodi;
  final String foto;

  const DetailPage({
    super.key,
    required this.nama,
    required this.nim,
    required this.prodi,
    required this.foto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade400,
        title: const Text(
          "Detail Mahasiswa",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          elevation: 3,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(radius: 50, backgroundImage: NetworkImage(foto)),
                const SizedBox(height: 16),
                Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text("NIM: $nim", style: const TextStyle(fontSize: 16)),
                Text(
                  "Program Studi: $prodi",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Kembali"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
