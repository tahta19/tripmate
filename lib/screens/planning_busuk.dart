import 'package:flutter/material.dart';

void main() {
  runApp(const PlanningApp());
}

class PlanningApp extends StatelessWidget {
  const PlanningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planning UTA',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PlanningHomePage(),
    );
  }
}

class PlanningHomePage extends StatefulWidget {
  const PlanningHomePage({super.key});

  @override
  State<PlanningHomePage> createState() => _PlanningHomePageState();
}

class _PlanningHomePageState extends State<PlanningHomePage> {
  int _selectedIndex = 0;

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      _buildMainPage(),
      _buildSecondPage(),
      const Center(child: Text("Notifikasi")),
      const Center(child: Text("Profil")),
    ]);
  }

  static Widget _buildMainPage() {
    return PlanningMainContent();
  }

  static Widget _buildSecondPage() {
    return PlanningSecondPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? 'Denpasar, Bali' : 'Rencana Perjalanan Kamu',
        ),
        leading:
            _selectedIndex != 0
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    _onNavBarTapped(0);
                  },
                )
                : null,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions:
            _selectedIndex == 0
                ? [
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.red),
                    onPressed: () {},
                  ),
                ]
                : null,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavBarTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Rencana',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Notifikasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class PlanningMainContent extends StatelessWidget {
  const PlanningMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Rencana Perjalanan Kamu!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Kumpulkan semua rencana goa di satu tempat',
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton.icon(
            onPressed: () {
              final state =
                  context.findAncestorStateOfType<_PlanningHomePageState>();
              state?._onNavBarTapped(1);
            },
            icon: const Icon(Icons.add),
            label: const Text('Tambah Rencana Baru'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Rencana Terdahulu',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        _buildPlanItem(
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Pura_Besakih_01.jpg/320px-Pura_Besakih_01.jpg',
          title: 'Liburan ke Bali (12 Hari 1 Malam)',
          subtitle: '12 Hari 1 Malam - 12 Apr 2023 - 23 Apr 2023',
        ),
        _buildPlanItem(
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Ulun_Danu_Bratan_Temple_Bali_2014.jpg/320px-Ulun_Danu_Bratan_Temple_Bali_2014.jpg',
          title: 'Trip ke Lombok (5 Hari 4 Malam)',
          subtitle: '5 Hari 4 Malam - 10 Mei 2023 - 14 Mei 2023',
        ),
        const SizedBox(height: 16),
        const Text(
          'Semua Rencana Kamu',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        _buildPlanItem(
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Pura_Besakih_01.jpg/320px-Pura_Besakih_01.jpg',
          title: 'Liburan ke Bali (12 Hari 1 Malam)',
          subtitle: '12 Apr 2023 - 23 Apr 2023',
        ),
        _buildPlanItem(
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Ulun_Danu_Bratan_Temple_Bali_2014.jpg/320px-Ulun_Danu_Bratan_Temple_Bali_2014.jpg',
          title: 'Trip ke Lombok (5 Hari 4 Malam)',
          subtitle: '10 Mei 2023 - 14 Mei 2023',
        ),
      ],
    );
  }

  Widget _buildPlanItem({
    required String imageUrl,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}

class PlanningSecondPage extends StatelessWidget {
  const PlanningSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSummaryCard('Akomodasi', Icons.hotel),
        const SizedBox(height: 12),
        _buildSummaryCard('Transportasi', Icons.directions_bus),
        const SizedBox(height: 12),
        _buildSummaryCard('Aktivitas', Icons.local_activity),
        const SizedBox(height: 12),
        _buildSummaryCard('Kuliner', Icons.restaurant_menu),
        const SizedBox(height: 24),
        _buildCostEstimateCard(),
      ],
    );
  }

  Widget _buildSummaryCard(String title, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.red),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red, width: 2),
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.add, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCostEstimateCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Estimasi Biaya',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            _buildCostRow('Akomodasi', 'Rp 0'),
            _buildCostRow('Transportasi', 'Rp 0'),
            _buildCostRow('Aktivitas', 'Rp 0'),
            _buildCostRow('Kuliner', 'Rp 0'),
          ],
        ),
      ),
    );
  }

  Widget _buildCostRow(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}