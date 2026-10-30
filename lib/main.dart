import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 02',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  DateTime _selectedDate = DateUtils.dateOnly(DateTime.now());
  String _selectedRole = 'Student';

  static const List<String> _roles = [
    'Student',
    'Developer',
    'Designer',
  ];

  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateUtils.dateOnly(DateTime.now()),
    );

    if (!mounted || picked == null) return;

    setState(() {
      _selectedDate = picked;
    });
  }

  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (popupContext) => Container(
        color: CupertinoColors.systemBackground.resolveFrom(popupContext),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 240,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: _selectedDate,
              minimumDate: DateTime(1950),
              maximumDate: DateUtils.dateOnly(DateTime.now()),
              onDateTimeChanged: (DateTime newDate) {
                if (!mounted) return;

                setState(() {
                  _selectedDate = DateUtils.dateOnly(newDate);
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showCupertinoRolePicker(BuildContext context) async {
    final controller = FixedExtentScrollController(
      initialItem: _roles.indexOf(_selectedRole),
    );

    try {
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (popupContext) => Container(
          color: CupertinoColors.systemBackground.resolveFrom(popupContext),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 200,
              child: CupertinoPicker(
                scrollController: controller,
                itemExtent: 32,
                onSelectedItemChanged: (int index) {
                  if (!mounted) return;

                  setState(() {
                    _selectedRole = _roles[index];
                  });
                },
                children: _roles
                    .map((role) => Center(child: Text(role)))
                    .toList(),
              ),
            ),
          ),
        ),
      );
    } finally {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? _buildPortraitView()
                : _buildLandscapeView();
          },
        ),
      ),
    );
  }

  Widget _buildPortraitView() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const StudentDetailsSection(),
        const SizedBox(height: 20),
        const ImageSection(imagePath: 'assets/images/lake.jpg'),
        const TitleSection(
          name: 'Oeschinen Lake',
          location: 'Kandersteg, Switzerland',
          starCount: 41,
        ),
        _buildPickersSection(),
      ],
    );
  }

  Widget _buildLandscapeView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: StudentDetailsSection(),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const ImageSection(imagePath: 'assets/images/lake.jpg'),
              const TitleSection(
                name: 'Oeschinen Lake',
                location: 'Kandersteg, Switzerland',
                starCount: 41,
              ),
              _buildPickersSection(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPickersSection() {
    final String formattedDate =
        '${_selectedDate.day.toString().padLeft(2, '0')}/'
        '${_selectedDate.month.toString().padLeft(2, '0')}/'
        '${_selectedDate.year}';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Pickers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 24),
            Text(
              'Selected Date: $formattedDate',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => _selectMaterialDate(context),
              child: const Text('Material Date Picker'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => _showCupertinoDatePicker(context),
              child: const Text('Cupertino Date Picker'),
            ),
            const Divider(height: 32),
            Text(
              'Selected Role: $_selectedRole',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const Text('Material Dropdown'),
            DropdownButton<String>(
              value: _selectedRole,
              isExpanded: true,
              items: _roles.map((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedRole = newValue;
                  });
                }
              },
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => _showCupertinoRolePicker(context),
              child: const Text('Cupertino Role Picker'),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentDetailsSection extends StatelessWidget {
  const StudentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.indigo,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'LAW CHEE YEW',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Student ID: BCS24020044',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Divider(height: 32, thickness: 1),
            Text(
              'Personal Life Goal / Quote:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '"RETIRE ASAP"',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  final int starCount;

  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.red[500]),
          const SizedBox(width: 4),
          Text('$starCount'),
        ],
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  final String imagePath;

  const ImageSection({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imagePath,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}