import 'package:flutter/material.dart';
import 'package:quiz_learning_app/core/const/app_constants.dart';

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
bool isSmalllDevice(BuildContext context) =>
    screenWidth(context) < AppConstants.webAppWidth;
