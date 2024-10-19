import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthdayProvider extends ChangeNotifier{
  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;

  void setSelectedDate(DateTime date){
    _selectedDate = date;
    notifyListeners();
  }

  String getFormattedDate(){
    if(_selectedDate == null){
      return "yyyy-mm-dd";
    }
    return DateFormat('yyyy-MM-dd').format(_selectedDate!);
  }
}