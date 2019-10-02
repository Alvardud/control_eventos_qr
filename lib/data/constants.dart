import "package:flutter/material.dart";

Color _convertColor(String x) {
  return Color(int.parse(x.substring(1, 7), radix: 16) + 0xFF000000);
}

//Theme Color

Color primaryColor = _convertColor("#012326");
Color secundaryColor = _convertColor("#D9A84E");
Color accentColor = _convertColor("#F2884B");
Color tertiaryColor = _convertColor("#A66038");
Color neutralColor = _convertColor("#0D0D0D");