import 'package:biomark/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/birthday_provider.dart';
import '../theme/app_theme.dart';

class RecoveryScreen1 extends StatelessWidget {
  const RecoveryScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(color: AppTheme.colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Account Recovery",
                    style: TextStyle(
                        color: AppTheme.colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.08,
                    right: screenWidth * 0.08,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text("Please provide below details to recover your account."),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.1,
                        right: screenWidth * 0.1,
                        top: 5),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            textAlign: TextAlign.start,
                            'Full Name',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.colors.primary,
                            ),
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(
                              color: AppTheme.colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            hintText: 'Full name',
                            hintStyle: TextStyle(
                              color: AppTheme.colors.primary.withOpacity(0.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: AppTheme.colors.light,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: AppTheme.colors.black,
                                width: 1,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: AppTheme.colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            textAlign: TextAlign.start,
                            'Date of birth',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.colors.primary,
                            ),
                          ),
                        ),
                        Consumer<BirthdayProvider>(
                            builder: (context, birthdayProvider, child) {
                          return TextFormField(
                            readOnly: true,
                            onTap: () {
                              _selectedDate(context, birthdayProvider);
                            },
                            style: TextStyle(
                                color: AppTheme.colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w100),
                            decoration: InputDecoration(
                              suffixIcon:
                                  const Icon(Icons.calendar_month_sharp),
                              hintText: birthdayProvider.getFormattedDate(),
                              hintStyle: TextStyle(
                                color: AppTheme.colors.black.withOpacity(0.5),
                                fontSize: 16,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: AppTheme.colors.light,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: AppTheme.colors.black,
                                  width: 1,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: AppTheme.colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            textAlign: TextAlign.start,
                            "Mother's maiden name",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.colors.primary,
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Ex: Julia',
                            hintStyle: TextStyle(
                              color: AppTheme.colors.primary.withOpacity(0.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: AppTheme.colors.light,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: AppTheme.colors.black,
                                width: 1,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: AppTheme.colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            textAlign: TextAlign.start,
                            'City you grew up',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.colors.primary,
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Ex: Los Angeles',
                            hintStyle: TextStyle(
                              color: AppTheme.colors.primary.withOpacity(0.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: AppTheme.colors.light,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: AppTheme.colors.black,
                                width: 1,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: AppTheme.colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SubmitButton(routePath: '/recoveryscreen2', buttonColor: AppTheme.colors.primary, textColor: AppTheme.colors.secondary)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}

Future<void> _selectedDate(
    BuildContext context, BirthdayProvider provider) async {
  DateTime? birthDay = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now());

  if (birthDay != null) {
    provider.setSelectedDate(birthDay);
  }
}
