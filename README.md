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



TUGAS 8
--------------------------------------------------------------------------
1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
Navigator push dan pushReplacement mendorong halaman baru ke posisi paling atas stack sebagai tampilan yang saat ini dilihat user. (Ambil kasus ada 3 page di stack dan dilakukan push/pushReplacement) perbedaannya, saat push page 4, ketika ada pop yang dijalankan, dia akan kembali ke page sebelumnya, dalam hal ini page 3. Saat pushReplacement page 4, ketika ada pop, dia akan kembali ke page 2 karena pushReplacement menggantikan current page (page 3) di stack. 

Di kode saya, push digunakan saat user mengakses card Create Product yang mengarahkan user ke page create. pushReplacement saya gunakan saat user klik tombol Home pada left drawer yang akan direct ke home page


2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
- Scaffold berfungsi sebagai kerangka utama setiap halaman di Flutter. Berfungsi agar semua tampilan seperti AppBar, Drawer, maupun behavior aplikasi konsisten
- AppBar digunakan di bagian atas untuk menampilkan judul seperti “Naiki Football Shop” agar identitas halaman selalu jelas
- Drawer digunakan untuk navigasi antarhalaman (misal: Home dan Add Product) sehingga user bisa berpindah halaman dengan mudah tanpa tombol kembali

3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
- Padding: memberi jarak antar-elemen agar tampilan tidak bertabrakan satu sama lain sehingga lebih enak dilihat
Contoh: saat membuat label di halaman Form agar konsisten jarak antarlabel nya
- SingleChildScrollView: memungkinkan tampilan tetap adaptif dan responsif di berbagai ukuran layar
Contoh: seluruh form dibungkus SingleChildScrollView supaya tetap bisa diisi meskipun layar sempit
- ListView: digunakan kalau elemen-elemen banyak dan dinamis (misalnya daftar produk). ListView otomatis membuat tampilan bisa digulir tanpa manual pakai ScrollView
Contoh: penggunaan ListView di LeftDrawer agar tetap bisa digulir saat isi drawer semakin banyak

4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
Meletakkan warna global di file main.dart dalam MaterialApp di bagian ThemeData agar bisa langsung inherit dari sana ketika ingin menggunakan tema global aplikasi. 
Contoh: 
colorScheme: ColorScheme.dark( memakai dark mode
    primary: const Color.fromARGB(255, 60, 65, 74), 
    secondary: const Color.fromARGB(255, 88, 95, 108))



TUGAS 9
--------------------------------------------------------------------------
1. Mengapa perlu membuat model Dart saat mengambil/mengirim data JSON?
Model Dart dipakai supaya data dari Django punya struktur yang jelas. Kalau cuma memakai Map<String, dynamic>, tidak ada validasi tipe, rawan null-safety, dan sulit dipelihara. Model memberi data yang strongly typed sehingga lebih aman dan rapi dalam jangka panjang.
2. Fungsi package http dan CookieRequest dalam tugas ini serta perbedaannya
http digunakan untuk request biasa tanpa autentikasi (misalnya GET endpoint publik).
CookieRequest digunakan untuk request yang butuh session login karena dia menyimpan dan mengirim cookie ke Django.
Bedanya: http bersifat stateless, sedangkan CookieRequest menyimpan state autentikasi.
3. Mengapa instance CookieRequest harus dibagikan ke semua komponen Flutter?
Karena session login tersimpan di dalam satu instance CookieRequest. Jika membuat instance baru di tiap halaman, session akan hilang dan Django menganggap user belum login. Dengan membagikan satu instance melalui provider, status login tetap konsisten di seluruh halaman.
4. Konfigurasi konektivitas agar Flutter bisa berkomunikasi dengan Django
10.0.2.2 harus ada di ALLOWED_HOSTS supaya emulator Android bisa mengakses Django.
CORS harus diaktifkan supaya Flutter diizinkan mengirim request.
Cookie dan SameSite perlu diatur agar session dari Django bisa diterima Flutter.
Android harus diberi izin internet di AndroidManifest, jika tidak request langsung gagal.
Tanpa konfigurasi itu, login gagal, cookie tidak tersimpan, dan request bisa diblokir.
5. Mekanisme pengiriman data dari input hingga tampil di Flutter
User mengisi form, Flutter mengirim data melalui http atau CookieRequest, Django memproses lalu mengirimkan JSON sebagai respons, Flutter mem-parsing JSON ke model Dart, kemudian data ditampilkan melalui widget yang sesuai.
6. Mekanisme autentikasi login, register, logout
Register: Flutter mengirim data registrasi ke Django, Django membuat user baru lalu mengembalikan status sukses.
Login: Flutter mengirim username dan password memakai CookieRequest, Django memverifikasi lalu mengirim cookie session, CookieRequest menyimpannya, halaman Flutter berubah karena status login aktif.
Logout: Flutter memanggil endpoint logout, Django menghapus session, Flutter kembali ke tampilan login.

7. Cara mengimplementasikan checklist secara step-by-step
- Deploy proyek Django.
- Buat model item kustom.
- Buat endpoint JSON untuk daftar dan detail item.
- Implementasi autentikasi Django (login, register, logout).
- Set ALLOWED_HOSTS, CORS, pengaturan cookie, dan izin internet Flutter.
- Buat model Dart untuk item.
- Setup provider untuk CookieRequest agar session konsisten.
- Buat halaman login Flutter.
- Buat halaman register Flutter.
- Buat halaman daftar item, fetch JSON memakai http, lalu convert ke model Dart.
- Filter item berdasarkan user login.
- Buat halaman detail item dengan navigasi dari daftar item.
- Tambahkan tombol kembali.
- Tes alur lengkap: login, lihat item, lihat detail, logout.