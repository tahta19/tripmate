import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanningScreen extends StatelessWidget {
  const PlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlanningHomePage();
  }
}

class PlanningHomePage extends StatefulWidget {
  const PlanningHomePage({super.key});

  @override
  State<PlanningHomePage> createState() => _PlanningHomePageState();
}

class _PlanningHomePageState extends State<PlanningHomePage> {
  int _selectedIndex = 1;
  bool _isNewPlanning = false;

  void _onNavBarTapped(int index) {
    // Disable navigasi ke tab lain
    if (index == 1) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 1
              ? (_isNewPlanning ? 'Tambah Rencana Baru' : 'Rencana Perjalanan Kamu'
              )
              : '', 
        ),
        leading: _isNewPlanning
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                      _isNewPlanning = false;
                  });
                },
              )
            : null,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation:  1,
      
          
      ),
      body: _buildCurrentBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavBarTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
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
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentBody() {
       return _isNewPlanning
        ? const NewPlanningPageBody()
        : PlanningMainContent(onAddPressed: () {
            setState(() {
              _isNewPlanning = true;
            });
          }); 
  }
}

class PlanningMainContent extends StatelessWidget {
  final VoidCallback onAddPressed;

  const PlanningMainContent({super.key, required this.onAddPressed});

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
          'Kumpulkan semua rencana di satu tempat',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 14),
        Center(
          child: ElevatedButton.icon(
            onPressed: onAddPressed,
            icon: const Icon(Icons.add, color: Colors.white,),
            label: const Text('Tambah Rencana Baru', 
            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight : FontWeight.bold), 
            ), 
            
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffdc2626),
          
              padding: const EdgeInsets.symmetric(vertical: 14),
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
          assetImagePath: 'assets/bali.jpeg',
          title: 'Liburan ke Bali (12 Hari 1 Malam)',
          subtitle: '12 Hari 1 Malam - 12 Apr 2023 - 23 Apr 2023',
        ),
        _buildPlanItem(
          assetImagePath: 'assets/lombok.jpeg',
          title: 'Trip ke Lombok (5 Hari 4 Malam)',
          subtitle: '5 Hari 4 Malam - 10 Mei 2023 - 14 Mei 2023',
),
      ],
    );
  }

  Widget _buildPlanItem({
  required String assetImagePath,
  required String title,
  required String subtitle,
  }) {
    return Card(
    color: Colors.white,
    elevation: 4,
    shadowColor: Colors.black54,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      ),
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: ListTile(
      contentPadding: const EdgeInsets.all(8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          assetImagePath,
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
      ),
    );
  }
}



class NewPlanningPageBody extends StatefulWidget {
  const NewPlanningPageBody({super.key});
  

  @override
  State<NewPlanningPageBody> createState() => _NewPlanningPageBodyState();
}

class _NewPlanningPageBodyState extends State<NewPlanningPageBody> {
  final _tripNameController = TextEditingController();
  final _originCityController = TextEditingController();
  final _destinationCityController = TextEditingController();
  final _tripDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _totalDaysController = TextEditingController();
  final _numberOfPeopleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  final List<String> _cityOptions = ['Surabaya', 'Bali', 'Jogja'];
  String? _selectedOrigin;
  String? _selectedDestination;

  

  List<Map<String, String>> _plans = [];
  int? _editingIndex;

  @override
  void dispose() {
    _tripNameController.dispose();
    _originCityController.dispose();
    _destinationCityController.dispose();
    _tripDateController.dispose();
    _endDateController.dispose();
    _totalDaysController.dispose();
    _numberOfPeopleController.dispose();
    super.dispose();
  }

  void _clearFields() {
    _tripNameController.clear();
    _originCityController.clear();
    _destinationCityController.clear();
    _tripDateController.clear();
    _endDateController.clear();
    _totalDaysController.clear();
    _numberOfPeopleController.clear();
  }

bool _validateInputs() {
  List<String> errors = [];

  if (_tripNameController.text.isEmpty) errors.add("Nama Perjalanan");
  if (_originCityController.text.isEmpty) errors.add("Asal Kota");
  if (_destinationCityController.text.isEmpty) errors.add("Kota Tujuan");
  if (_tripDateController.text.isEmpty) errors.add("Tanggal Perjalanan");
  if (_endDateController.text.isEmpty) errors.add("Tanggal Akhir");
  if (_totalDaysController.text.isEmpty) errors.add("Jumlah Hari");
  if (_numberOfPeopleController.text.isEmpty) errors.add("Jumlah Orang");

  if (errors.isNotEmpty) {
    final message = "Harap isi: ${errors.join(', ')}";
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
    return false;
  }

  return true;
}


  void _savePlan()  async {

    if (!_validateInputs()) return;

    final confirmed = await showDialog<bool>( 
    
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Konfirmasi Simpan'),
      content: Text(
        _editingIndex == null
            ? 'Yakin ingin menyimpan rencana baru ini?'
            : 'Yakin ingin menyimpan perubahan rencana ini?',
      ),
         actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Batal'),
          
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Color(0xffdc2626)), 
          child: const Text('Ya, Simpan'),
        ),
      ],
    ),
  );

  if (confirmed != true) return;

    final plan = {
      'name': _tripNameController.text,
      'origin': _originCityController.text,
      'destination': _destinationCityController.text,
      'start date': _tripDateController.text,
      'end date': _endDateController.text,
      'sum date': _totalDaysController.text,
      'people': _numberOfPeopleController.text,
    };

      

    setState(() {
      if (_editingIndex == null) {
        _plans.add(plan);
      } else {
        _plans[_editingIndex!] = plan;
        _editingIndex = null;
      }
      _clearFields();
      
    });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(_editingIndex == null
          ? 'Rencana berhasil ditambahkan.'
          : 'Perubahan rencana berhasil disimpan.'),
    ),
  );
  }

  
  void _editPlan(int index) {
    final plan = _plans[index];
    setState(() {
      _tripNameController.text = plan['name']!;
      _originCityController.text = plan['origin']!;
      _destinationCityController.text = plan['destination']!;
      _tripDateController.text = plan['start date']!;
      _endDateController.text = plan['end date']!;
      _totalDaysController.text = plan['sum date']!;
      _numberOfPeopleController.text = plan['people']!;
      _editingIndex = index;
    });
  }

  void _deletePlan(int index) async {
    final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Konfirmasi'),
      content: const Text('Apakah Anda yakin ingin menghapus rencana ini?'),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(false), style : TextButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Color(0xffdc2626)), child: const Text('Batal')),
        TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Hapus')),
      ],
    ),
  );

     if (confirm == true) {
    setState(() {
      _plans.removeAt(index);
      _clearFields();
      if (_editingIndex == index) {
        _clearFields();
        _editingIndex = null;
      }});
     }

    // setState(() {
    //   _plans.removeAt(index);
    //   if (_editingIndex == index) {
    //     _clearFields();
    //     _editingIndex = null;
    //   }
    // });
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    VoidCallback? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: onTap != null,
              onTap: onTap,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildTextField(hint: 'Nama Perjalanan', icon: Icons.description_outlined, controller: _tripNameController),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.grey),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedOrigin,
                            hint: const Text('Asal Kota'),
                            items: _cityOptions.map((city) {
                              return DropdownMenuItem<String>(
                                value: city,
                                child: Text(city),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedOrigin = value;
                                _originCityController.text = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: Colors.grey),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedDestination,
                          hint: const Text('Kota Tujuan'),
                          items: _cityOptions.map((city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedDestination = value;
                              _destinationCityController.text = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

                _buildTextField(
                  hint: 'Tanggal Perjalanan',
                  icon: Icons.calendar_today_outlined,
                  controller: _tripDateController,
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      _tripDateController.text = DateFormat('yyyy-MM-dd').format(picked);
                    }
                  },
                ),
                const SizedBox(height: 14),
                _buildTextField(
                  hint: 'Tanggal Akhir',
                  icon: Icons.calendar_today_outlined,
                  controller: _endDateController,
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      _endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
                    }
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(hint: 'Jumlah Hari', icon: Icons.calendar_view_day_outlined, controller: _totalDaysController),
                const SizedBox(height: 18),
                _buildTextField(hint: 'Jumlah Orang', icon: Icons.people_outline, controller: _numberOfPeopleController),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _savePlan,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffdc2626),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            _editingIndex == null ? 'Simpan Rencana' : 'Update Rencana',
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Daftar Rencana Tersimpan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ..._plans.asMap().entries.map((entry) {
          final index = entry.key;
          final plan = entry.value;
          return Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(plan['name'] ?? ''),
              subtitle: Text('${plan['origin']} ➝ ${plan['destination']} (${plan['start date']} - ${plan['end date']}, ${plan['people']} orang)'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => _editPlan(index)),
                  IconButton(icon: const Icon(Icons.delete, color: Color(0xffdc2626)), onPressed: () => _deletePlan(index)),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
