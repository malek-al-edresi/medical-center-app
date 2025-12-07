import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import '../../core/theme/app_dimensions.dart';
import '../shared/widgets/custom_button.dart';
import '../shared/widgets/custom_textfield.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    final invoiceId = _controller.text.trim();
    if (invoiceId.isNotEmpty) {
      Navigator.pushNamed(context, '/home', arguments: invoiceId);
    } else {
      GFToast.showToast(
        'الرجاء إدخال رقم الفاتورة',
        context,
        toastPosition: GFToastPosition.BOTTOM,
        textStyle: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    }
  }

  void _navigateToRegistorPatient() {
    Navigator.pushNamed(context, '/preregistration');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(paddingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // شعار المستشفى بالأزرق الأساسي
                Icon(
                  Icons.local_hospital,
                  size: 90,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 24),
                // العنوان الرئيسي
                Text(
                  'مرحبًا بك في النظام الطبي',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'أدخل رقم الفاتورة لعرض بيانات المريض',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    color: theme.hintColor,
                  ),
                ),
                const SizedBox(height: 32),
                TextFieldCustom(
                  controller: _controller,
                  labelText: 'رقم الفاتورة',
                  hintText: 'أدخل رقم الفاتورة',
                  prefixIcon: Icons.receipt,
                  actionIcon: Icons.search,
                  onSearchPressed: _navigateToHome,
                  onSubmitted: (_) => _navigateToHome(),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'عرض البيانات',
                    icon: Icons.visibility,
                    onPressed: _navigateToHome,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'تسجيل بياناتك الطبية',
                    icon: Icons.app_registration_outlined,
                    onPressed: _navigateToRegistorPatient,
                    color: GFColors.FOCUS,
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'v1.0',
                        style: theme.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.primary,
                          fontSize: 15
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        '❤️ By Dev : ENG.Malek Mohammed',
                        style: theme.textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.primary,
                            fontSize: 12
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
