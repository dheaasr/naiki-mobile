TUGAS 7
--------------------------------------------------------------------------
1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget
Widget tree adalah representasi hierarki dari semua komponen UI atau widget yang dimunculkan di layar sebagai tampilan aplikasi. Dalam hubungan parent-child, parent menentukan layout, constraint, dan data yang diturunkan ke child melalui inherited widget. Sedangkan child menerima atau menurunkan sifat dari parent nya, seperti tema, warna, tata letak

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
MaterialApp = pondasi utama aplikasi yang mengatur tema, routing, dan tampilan global
Scaffold = menyediakan struktur dengan area appBar, body, dan elemen bawaan lainnya
AppBar = menampilkan judul aplikasi atau navigasi
Text = menampilkan text
Theme/ThemeData = mengatur tema global (warna, font, gaya visual) untuk seluruh aplikasi
ColorScheme = menentukan kombinasi warna utama (primary, secondary, dst.) di dalam tema
Padding = memberi jarak di dalam atau sekitar widget lain agar tidak menempel ke tepi layar
Column = menyusun widget lain secara vertikal (sumbu y)
Row = menyusun widget lain secara horizontal (sumbu x)
Center = menempatkan widget di tengah
SizedBox = memberikan box dengan tinggi atau lebar tertentu
GridView.count = menampilkan beberapa elemen dalam bentuk grid dengan jumlah kolom yang ditentukan
Card = menampilkan elemen dalam bentuk kartu 
Container = widget serbaguna untuk mengatur ukuran, padding, margin, warna, atau posisi isi di dalamnya
Material = memberikan efek visual seperti bayangan dan efek sentuhan
InkWell = memberi efek gelombang (ripple) dan menangani aksi saat widget ditekan
SnackBar = menampilkan pesan singkat sementara di bagian bawah layar
ScaffoldMessenger = menampilkan atau menghapus SnackBar di dalam konteks Scaffold
Icon = menampilkan ikon bawaan Flutter
MediaQuery = mengambil informasi ukuran layar agar layout bisa menyesuaikan ukuran perangkat

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
MaterialApp menjadi root karena digunakan sebagai pondasi awal sebuah aplikasi. Semua widget di bawahnya bisa mengakses tema, navigasi, dan konfigurasi aplikasi (mengikuti material design dari MaterialApp)

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
Stateless: semua yang di-render sudah fix (immutable), jika ada perubahan harus di-replace bukan update. Dipilih ketika tampilannya ingin statis, tidak ada perubahan data secara dinamis
Stateful: widget nya sama tetapi isi kontennya berbeda (mutable), di-render berdasarkan event misalnya hover dari user. Digunakan ketika UI bergantung kepada saat-saat tertentu, seperti klik tombol atau aksi dari user

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
BuildContext merupakan referensi posisi sebuah widget agar widget bisa "berkomunikasi" dengan widget atasnya. Context digunakan agar Flutter tahu dari halaman mana aksi selanjutnya dimulai. Contohnya, ketika ada widget yang mengarahkan ke halaman lain, perlu menggunakan Navigator.push(context, MaterialPageRoute(builder: (context) => const NextPage())); di dalam metode build

6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
Hot Reload: memuat ulang widget tree tanpa kehilangan state, prosesnya cepat. Digunakan saat melakukan perubahan kecil
Hot Restart: memulai aplikasi dari awal, prosesnya lambat karena perlu memulai ulang penuh sistem. Digunakan saat mengubah variabel global atau membuat perubahan besar lainnya