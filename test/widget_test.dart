import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tripmate/main.dart'; // Sesuaikan dengan nama package kamu
import 'package:tripmate/screens/planning.dart'; // Import screen yang akan diuji

void main() {
  testWidgets('Planning screen UI test', (WidgetTester tester) async {
    // Build PlanningScreen secara langsung
    await tester.pumpWidget(const MaterialApp(home: PlanningScreen()));

    // Periksa apakah teks utama dan tombol ada di layar
    expect(find.text('Perencanaan'), findsNothing); // AppBar tidak muncul tanpa MaterialApp dengan appBar
    expect(find.text('Buat rencana perjalananmu!'), findsOneWidget);
    expect(find.text('Tambah Rencana'), findsOneWidget);

    // Tap tombol "Tambah Rencana"
    await tester.tap(find.text('Tambah Rencana'));
    await tester.pump(); // Tidak ada navigasi, jadi hanya trigger frame ulang

    // Tidak ada assert tambahan karena tombol belum ada fungsinya
  });

  testWidgets('TripMateApp navigates to login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const TripMateApp());

    // Harus berada di halaman onboarding (awal)
    expect(find.text('Temukan perjalanan impianmu!'), findsOneWidget);

    // Tap tombol "Masuk"
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    // Sekarang kita seharusnya di halaman login
    expect(find.text('Masuk'), findsWidgets);
    expect(find.text('Alamat email'), findsOneWidget);
    expect(find.text('Kata sandi'), findsOneWidget);
  });
}
