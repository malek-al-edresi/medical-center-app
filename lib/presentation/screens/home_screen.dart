import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

import '../../logic/providers/patient_provider.dart';
import '../../logic/providers/radiology_result_provider.dart';
import '../../logic/providers/diagnosis_result_provider.dart';
import '../../logic/providers/treatment_result_provider.dart';

import 'lab_result_screen.dart';
import 'treatment_result_screen.dart';
import 'diagnosis_screen.dart';
import 'patient_screen.dart';
import 'radiology_result_screen.dart';

class HomeScreen extends StatefulWidget {
  final String invoiceId;

  const HomeScreen({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<PatientProvider>(
        context,
        listen: false,
      ).fetchResults(widget.invoiceId);
      Provider.of<RadiologyResultProvider>(
        context,
        listen: false,
      ).fetchResults(widget.invoiceId);
      Provider.of<DiagnosisResultProvider>(
        context,
        listen: false,
      ).fetchResults(widget.invoiceId);
      Provider.of<TreatmentResultProvider>(
        context,
        listen: false,
      ).fetchResults(widget.invoiceId);
    });

    _screens = <Widget>[
      PatientScreen(invoiceId: widget.invoiceId),
      TreatmentResultScreen(invoiceId: widget.invoiceId),
      DiagnosisScreen(invoiceId: widget.invoiceId),
      LabResultScreen(invoiceId: widget.invoiceId),
      RadiologyResultScreen(invoiceId: widget.invoiceId),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor = theme.primaryColor;
    final unselectedColor = theme.primaryColor;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: FlashyTabBar(
          selectedIndex: _selectedIndex,
          onItemSelected: _onItemTapped,
          iconSize: 26,
          animationCurve: Curves.easeInOut,
          showElevation: true,
          items: [
            FlashyTabBarItem(
              icon: Icon(
                Icons.person,
                color: _selectedIndex == 0 ? selectedColor : unselectedColor,
              ),
              title: Text(
                'البيانات',
                style: GoogleFonts.cairo(
                  color: _selectedIndex == 0 ? selectedColor : unselectedColor,
                ),
              ),
            ),
            FlashyTabBarItem(
              icon: Icon(
                Icons.medical_information,
                color: _selectedIndex == 4 ? selectedColor : unselectedColor,
              ),
              title: Text(
                'الوصفة',
                style: GoogleFonts.cairo(
                  color: _selectedIndex == 4 ? selectedColor : unselectedColor,
                ),
              ),
            ),
            FlashyTabBarItem(
              icon: Icon(
                Icons.assignment,
                color: _selectedIndex == 3 ? selectedColor : unselectedColor,
              ),
              title: Text(
                'التشخيص',
                style: GoogleFonts.cairo(
                  color: _selectedIndex == 3 ? selectedColor : unselectedColor,
                ),
              ),
            ),
            FlashyTabBarItem(
              icon: Icon(
                Icons.science,
                color: _selectedIndex == 1 ? selectedColor : unselectedColor,
              ),
              title: Text(
                'المختبر',
                style: GoogleFonts.cairo(
                  color: _selectedIndex == 1 ? selectedColor : unselectedColor,
                ),
              ),
            ),
            FlashyTabBarItem(
              icon: Icon(
                Icons.image,
                color: _selectedIndex == 2 ? selectedColor : unselectedColor,
              ),
              title: Text(
                'الأشعة',
                style: GoogleFonts.cairo(
                  color: _selectedIndex == 2 ? selectedColor : unselectedColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
