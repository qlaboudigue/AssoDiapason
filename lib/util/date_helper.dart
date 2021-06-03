import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateHelper {

  DateTime fromTimeStampToDate(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return dateTime;
  }


  int fromDateTimeToInt(DateTime dateTime) {
    int _date = dateTime.millisecondsSinceEpoch.toInt();
    return _date;
  }


  String eventDateLine(int timestamp) {
    initializeDateFormatting();
    DateTime eventTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateFormat format;
    format = DateFormat.yMMMd('fr_FR');
    return format.format(eventTime).toString();
  }

  bool isEventAFuture(int timestamp) {
    DateTime now = DateTime.now();
    DateTime timeEvent = DateTime.fromMillisecondsSinceEpoch(timestamp);
    if(now.difference(timeEvent).inDays < 0) {
      return true;
    } else {
      return false;
    }
  }


  DateTime mergeDateAndTime (DateTime date, TimeOfDay time) {
    DateTime finalDate;
    if (date != null && time != null) {
      return finalDate =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
    } else {
      return null;
    }
  }

  String dayFromDate(int timestamp) {
    initializeDateFormatting();
    DateTime eventTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateFormat format;
    format = DateFormat.d('fr_FR');
    return format.format(eventTime).toString();
  }

  String monthFromDate(int timestamp) {
    initializeDateFormatting();
    DateTime eventTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateFormat format;
    format = DateFormat.MMM('fr_FR');
    return format.format(eventTime).toString();
  }

  String yearFromDate(int timestamp) {
    initializeDateFormatting();
    DateTime eventTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateFormat format;
    format = DateFormat.y('fr_FR');
    return format.format(eventTime).toString();
  }

  String timeFromDate(int timestamp) {
    initializeDateFormatting();
    DateTime eventTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateFormat format;
    format = DateFormat.Hm('fr_FR');
    return format.format(eventTime).toString();
  }


}