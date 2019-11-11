import 'package:control_eventos_qr/models/company.dart';
import "package:flutter/material.dart";

Color _convertColor(String x) {
  return Color(int.parse(x.substring(1, 7), radix: 16) + 0xFF000000);
}

const collectionDefault = "tickets";

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

const List<String> codeUser = [
  "organizadores",
  "auspiciadores",
  "grupo_estudio",
  "feria_proyectos",
];

const List<Map<String, String>> urlImage = [
  {
    "intervenciones_urbanas": "assets/images/piu.png",
    "comtect": "assets/images/comtec.png",
    "jalasoft": "assets/images/jala.png",
    "ucb": "assets/images/ucb.png"
  },
  {
    "mobile": "assets/images/mobile.png",
    "ia": "assets/images/tensorflow.png",
    "cloud": "assets/images/cloud.png",
    "firebase": "assets/images/firebase.png",
    "marketing": "assets/images/marketing.png",
    "asistant": "assets/images/asistant.png",
    "web": "assets/images/web.png"
  },
  {null: null}
];

const Map<String, IconData> iconsUser = {
  "organizer": IconData(0xe906, fontFamily: 'Custom Icons'),
  "auspiciadores": IconData(0xe903, fontFamily: 'Custom Icons'),
  "grupos de estudio": IconData(0xe904, fontFamily: 'Custom Icons'),
  "feria de proyectos": IconData(0xe902, fontFamily: 'Custom Icons'),
};

const Map<String, IconData> iconsSouvenir = {
  //Organizers
  "desayuno": IconData(0xe901, fontFamily: 'Custom Icons'),
  "almuerzo": IconData(0xe905, fontFamily: 'Custom Icons'),
  "souvenir": IconData(0xe907, fontFamily: 'Custom Icons'),
  "sticker": IconData(0xe900, fontFamily: 'Custom Icons'),
  "adicionar": IconData(0xe908, fontFamily: 'Custom Icons'),
  "refrigerio": IconData(0xe909, fontFamily: 'Custom Icons'),
  "conferencia": IconData(0xe909, fontFamily: 'Custom Icons'),
  "feria proyectos": IconData(0xe909, fontFamily: 'Custom Icons'),
  "workshop 1": IconData(0xe909, fontFamily: 'Custom Icons'),
  "workshop 2": IconData(0xe909, fontFamily: 'Custom Icons'),
};

List<Color> colorsDefault = [
  Colors.red[200],
  Colors.blue[200],
  Colors.green[200],
  Colors.amber[200],
  Colors.purple[200],
  Colors.teal[200],
];

const String errorLoginText =
    "Error de autenticación, revise: \n\t*\tNo tener el campo vacio\n\t*\tColocar la contraseña correcta";

Company companyOrganizer = Company(
  name: 'Organizador/a',
  linkLogo: null,
  pass: "1234",
  type: 'Organizer',
);

const List<String> FridayAccess = [
  'Workshop 1',
  'Workshop 2',
  'Refrigerio',
  'Sticker',
];
const List<String> SaturdayAccess = [
  'Conferencia',
  'Feria Proyectos',
  'Almuerzo',
  'Sticker',
];
const List<String> FullAccess = [
  'Workshop 1',
  'Workshop 2',
  'Conferencia',
  'Feria Proyectos',
  'Desayuno',
  'Almuerzo',
  'Souvenir',
  'Sticker',
];
