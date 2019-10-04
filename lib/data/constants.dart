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

const List<String> userType = [
  "Organizadores del evento con labores logísticas",
  "Auspiciadores que deseen ofrecer materiales a los participantes",
  "Grupos de estudio del GDG",
  "Participantes de ferias de proyectos"
];

const Map<String, String> keyNameUser = {
  "Organizadores": "Organizadores",
  "Auspiciadores": "empresa de auspicio",
  "Grupos de estudio": "grupo de estudio",
  "Participantes feria de proyectos": "proyecto"
};

const List<IconData> userTypeIcon = [
  Icons.account_box,
  Icons.store,
  Icons.book,
  Icons.location_city
];
