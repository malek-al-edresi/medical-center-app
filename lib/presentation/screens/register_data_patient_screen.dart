import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/preregistration_result.dart';
import '../../logic/providers/preregistration_provider.dart';
import '../shared/widgets/custom_button.dart';
import '../shared/widgets/custom_textfield.dart';

class RegisterDataPatientScreen extends StatefulWidget {
  const RegisterDataPatientScreen({super.key});

  @override
  State<RegisterDataPatientScreen> createState() =>
      _RegisterDataPatientScreenState();
}

class _RegisterDataPatientScreenState extends State<RegisterDataPatientScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final _firstNameController = TextEditingController();
  final _midNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _personalIdController = TextEditingController();
  final _emergencyNameController = TextEditingController();
  final _emergencyPhoneController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _diseasesController = TextEditingController();
  final _medicationsController = TextEditingController();
  final _surgeriesController = TextEditingController();
  final _historyController = TextEditingController();

  // Dropdown values
  String _selectedGender = 'M';
  String _selectedMaritalStatus = 'Single';
  int _selectedBloodId = 1;
  int _selectedHobbyId = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _midNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _personalIdController.dispose();
    _emergencyNameController.dispose();
    _emergencyPhoneController.dispose();
    _allergiesController.dispose();
    _diseasesController.dispose();
    _medicationsController.dispose();
    _surgeriesController.dispose();
    _historyController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        String formattedDate =
            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
        _dobController.text = formattedDate;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final patient = PatientRegisterEntity(
        firstName: _firstNameController.text.trim(),
        midName: _midNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        gender: _selectedGender,
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        email: _emailController.text.trim(),
        dob: _dobController.text.trim(),
        maritalStatus: _selectedMaritalStatus,
        bloodId: _selectedBloodId,
        hobbyId: _selectedHobbyId,
        personalId: _personalIdController.text.trim(),
        emergencyName: _emergencyNameController.text.trim(),
        emergencyPhone: _emergencyPhoneController.text.trim(),
        allergies: _allergiesController.text.trim(),
        diseases: _diseasesController.text.trim(),
        medications: _medicationsController.text.trim(),
        surgeries: _surgeriesController.text.trim(),
        history: _historyController.text.trim(),
      );

      final provider = Provider.of<PatientRegisterProvider>(
        context,
        listen: false,
      );


      provider.registerPatient(patient).then((_) {
        if (provider.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم تسجيل المريض بنجاح!'),
              backgroundColor: Colors.green,
            ),
          );
          _resetForm();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                provider.errorMessage.isEmpty
                    ? 'فشل في تسجيل المريض'
                    : provider.errorMessage,
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _firstNameController.clear();
    _midNameController.clear();
    _lastNameController.clear();
    _phoneController.clear();
    _addressController.clear();
    _emailController.clear();
    _dobController.clear();
    _personalIdController.clear();
    _emergencyNameController.clear();
    _emergencyPhoneController.clear();
    _allergiesController.clear();
    _diseasesController.clear();
    _medicationsController.clear();
    _surgeriesController.clear();
    _historyController.clear();

    setState(() {
      _selectedGender = 'M';
      _selectedMaritalStatus = 'Single';
      _selectedBloodId = 1;
      _selectedHobbyId = 1;
    });

    Provider.of<PatientRegisterProvider>(context, listen: false).reset();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Consumer<PatientRegisterProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // H1 Title
                    _buildH1Title('تسجيل بيانات المريض الجديد'),

                    // Personal Information Section
                    _buildSectionTitle('المعلومات الشخصية'),

                    TextFieldCustom(
                      controller: _firstNameController,
                      labelText: 'الاسم الأول',
                      hintText: 'أدخل الاسم الأول',
                      prefixIcon: Icons.person,
                    ),

                    TextFieldCustom(
                      controller: _midNameController,
                      labelText: 'اسم الأب',
                      hintText: 'أدخل اسم الأب',
                      prefixIcon: Icons.person_outline,
                    ),

                    TextFieldCustom(
                      controller: _lastNameController,
                      labelText: 'اسم العائلة',
                      hintText: 'أدخل اسم العائلة',
                      prefixIcon: Icons.family_restroom,
                    ),

                    SizedBox(height: 15,),

                    _buildGenderDropdown(),

                    TextFieldCustom(
                      controller: _phoneController,
                      labelText: 'رقم الهاتف',
                      hintText: 'أدخل رقم الهاتف',
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.phone,
                    ),

                    TextFieldCustom(
                      controller: _addressController,
                      labelText: 'العنوان',
                      hintText: 'أدخل العنوان',
                      prefixIcon: Icons.location_on,
                    ),

                    TextFieldCustom(
                      controller: _emailController,
                      labelText: 'البريد الإلكتروني',
                      hintText: 'أدخل البريد الإلكتروني',
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 10,),

                    _buildDateField(),
                    SizedBox(height: 10,),

                    _buildMaritalStatusDropdown(),

                    // Medical Information Section
                    _buildSectionTitle('المعلومات الطبية'),

                    _buildBloodTypeDropdown(),
                    _buildHobbyDropdown(),

                    TextFieldCustom(
                      controller: _personalIdController,
                      labelText: 'الرقم الشخصي',
                      hintText: 'أدخل الرقم الشخصي',
                      prefixIcon: Icons.badge,
                    ),

                    TextFieldCustom(
                      controller: _allergiesController,
                      labelText: 'الحساسية',
                      hintText: 'أدخل معلومات الحساسية',
                      prefixIcon: Icons.health_and_safety,
                    ),

                    TextFieldCustom(
                      controller: _diseasesController,
                      labelText: 'الأمراض المزمنة',
                      hintText: 'أدخل الأمراض المزمنة',
                      prefixIcon: Icons.local_hospital,
                    ),

                    TextFieldCustom(
                      controller: _medicationsController,
                      labelText: 'الأدوية الحالية',
                      hintText: 'أدخل الأدوية الحالية',
                      prefixIcon: Icons.medication,
                    ),

                    TextFieldCustom(
                      controller: _surgeriesController,
                      labelText: 'العمليات الجراحية السابقة',
                      hintText: 'أدخل العمليات الجراحية السابقة',
                      //           prefixIcon: Icons.surgical,
                    ),

                    TextFieldCustom(
                      controller: _historyController,
                      labelText: 'التاريخ الطبي',
                      hintText: 'أدخل التاريخ الطبي',
                      prefixIcon: Icons.history,
                    ),

                    // Emergency Contact Section
                    _buildSectionTitle('معلومات الطوارئ'),

                    TextFieldCustom(
                      controller: _emergencyNameController,
                      labelText: 'اسم جهة الطوارئ',
                      hintText: 'أدخل اسم جهة الطوارئ',
                      prefixIcon: Icons.contact_emergency,
                    ),

                    TextFieldCustom(
                      controller: _emergencyPhoneController,
                      labelText: 'رقم هاتف الطوارئ',
                      hintText: 'أدخل رقم هاتف الطوارئ',
                      prefixIcon: Icons.emergency,
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: 30),

                    // Submit Button
                    if (provider.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      CustomButton(
                        text: 'تسجيل المريض',
                        onPressed: _submitForm,
                        color: Colors.blueAccent,
                        icon: Icons.person_add,
                      ),

                    const SizedBox(height: 16),

                    // Reset Button
                    CustomButton(
                      text: 'إعادة تعيين',
                      onPressed: _resetForm,
                      color: Colors.grey,
                      icon: Icons.refresh,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildH1Title(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24, top: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonFormField<String>(
          value: _selectedGender,
          decoration: InputDecoration(
            labelText: 'الجنس',
            prefixIcon: const Icon(Icons.transgender, color: Colors.blueAccent),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          items: const [
            DropdownMenuItem(value: 'M', child: Text('ذكر')),
            DropdownMenuItem(value: 'F', child: Text('أنثى')),
          ],
          onChanged: (value) => setState(() => _selectedGender = value!),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: _dobController,
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'تاريخ الميلاد',
            prefixIcon: const Icon(
              Icons.calendar_today,
              color: Colors.blueAccent,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(20),
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.date_range, color: Colors.blueAccent),
              onPressed: () => _selectDate(context),
            ),
          ),
          onTap: () => _selectDate(context),
        ),
      ),
    );
  }

  Widget _buildMaritalStatusDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonFormField<String>(
          value: _selectedMaritalStatus,
          decoration: InputDecoration(
            labelText: 'الحالة الاجتماعية',
            prefixIcon: const Icon(Icons.group, color: Colors.blueAccent),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          items: const [
            DropdownMenuItem(value: 'Single', child: Text('أعزب')),
            DropdownMenuItem(value: 'Married', child: Text('متزوج')),
            DropdownMenuItem(value: 'Divorced', child: Text('مطلق')),
            DropdownMenuItem(value: 'Widowed', child: Text('أرمل')),
          ],
          onChanged: (value) => setState(() => _selectedMaritalStatus = value!),
        ),
      ),
    );
  }

  Widget _buildBloodTypeDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonFormField<int>(
          value: _selectedBloodId,
          decoration: InputDecoration(
            labelText: 'فئة الدم',
            prefixIcon: const Icon(Icons.bloodtype, color: Colors.red),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          items: const [
            DropdownMenuItem(value: 1, child: Text('A+')),
            DropdownMenuItem(value: 2, child: Text('A-')),
            DropdownMenuItem(value: 3, child: Text('B+')),
            DropdownMenuItem(value: 4, child: Text('B-')),
            DropdownMenuItem(value: 5, child: Text('AB+')),
            DropdownMenuItem(value: 6, child: Text('AB-')),
            DropdownMenuItem(value: 7, child: Text('O+')),
            DropdownMenuItem(value: 8, child: Text('O-')),
          ],
          onChanged: (value) => setState(() => _selectedBloodId = value!),
        ),
      ),
    );
  }

  Widget _buildHobbyDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonFormField<int>(
          value: _selectedHobbyId,
          decoration: InputDecoration(
            labelText: 'الهواية',
            prefixIcon: const Icon(
              Icons.sports_esports,
              color: Colors.blueAccent,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          items: const [
            DropdownMenuItem(value: 1, child: Text('بطاقة شخصية')),
            DropdownMenuItem(value: 2, child: Text('جواز سفر')),
          ],
          onChanged: (value) => setState(() => _selectedHobbyId = value!),
        ),
      ),
    );
  }
}


class preregistratioin {

}
