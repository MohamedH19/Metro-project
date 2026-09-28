class StationCoordinate {
  final double latitude;
  final double longitude;

  const StationCoordinate({
    required this.latitude,
    required this.longitude,
  });
}

const Map<String, StationCoordinate> stationCoordinates = {
  // =========================
  // Line 1
  // =========================

  'Helwan': StationCoordinate(
    latitude: 29.8490,
    longitude: 31.3340,
  ),

  'Ain Helwan': StationCoordinate(
    latitude: 29.8620,
    longitude: 31.3250,
  ),

  'Wadi Hof': StationCoordinate(
    latitude: 29.8790,
    longitude: 31.3130,
  ),

  'Hadayek Helwan': StationCoordinate(
    latitude: 29.8970,
    longitude: 31.3030,
  ),

  'El-Maasara': StationCoordinate(
    latitude: 29.9060,
    longitude: 31.2990,
  ),

  'Tora El-Asmant': StationCoordinate(
    latitude: 29.9250,
    longitude: 31.2870,
  ),

  'Kozzika': StationCoordinate(
    latitude: 29.9370,
    longitude: 31.2810,
  ),

  'Tora El-Balad': StationCoordinate(
    latitude: 29.9460,
    longitude: 31.2780,
  ),

  'Sakanat El-Maadi': StationCoordinate(
    latitude: 29.9600,
    longitude: 31.2630,
  ),

  'Maadi': StationCoordinate(
    latitude: 29.9605,
    longitude: 31.2560,
  ),

  'Hadayek El-Maadi': StationCoordinate(
    latitude: 29.9710,
    longitude: 31.2500,
  ),

  'Dar El-Salam': StationCoordinate(
    latitude: 29.9820,
    longitude: 31.2420,
  ),

  'El-Zahraa': StationCoordinate(
    latitude: 29.9950,
    longitude: 31.2310,
  ),

  'Mar Girgis': StationCoordinate(
    latitude: 30.0060,
    longitude: 31.2290,
  ),

  'El-Malek El-Saleh': StationCoordinate(
    latitude: 30.0170,
    longitude: 31.2310,
  ),

  'Al-Sayeda Zeinab': StationCoordinate(
    latitude: 30.0290,
    longitude: 31.2350,
  ),

  'Saad Zaghloul': StationCoordinate(
    latitude: 30.0367,
    longitude: 31.2380,
  ),

  'Sadat': StationCoordinate(
    latitude: 30.0444,
    longitude: 31.2356,
  ),

  'Nasser': StationCoordinate(
    latitude: 30.0540,
    longitude: 31.2390,
  ),

  'Orabi': StationCoordinate(
    latitude: 30.0620,
    longitude: 31.2420,
  ),

  'Al-Shohadaa': StationCoordinate(
    latitude: 30.0620,
    longitude: 31.2470,
  ),

  'Ghamra': StationCoordinate(
    latitude: 30.0690,
    longitude: 31.2650,
  ),

  'El-Demerdash': StationCoordinate(
    latitude: 30.0770,
    longitude: 31.2780,
  ),

  'Manshiet El-Sadr': StationCoordinate(
    latitude: 30.0820,
    longitude: 31.2870,
  ),

  'Kobri El-Qobba': StationCoordinate(
    latitude: 30.0870,
    longitude: 31.2940,
  ),

  'Hammamat El-Qobba': StationCoordinate(
    latitude: 30.0900,
    longitude: 31.2980,
  ),

  'Saray El-Qobba': StationCoordinate(
    latitude: 30.0980,
    longitude: 31.3040,
  ),

  'Hadayeq El-Zaitoun': StationCoordinate(
    latitude: 30.1050,
    longitude: 31.3100,
  ),

  'Helmeyet El-Zaitoun': StationCoordinate(
    latitude: 30.1140,
    longitude: 31.3140,
  ),

  'El-Matareyya': StationCoordinate(
    latitude: 30.1210,
    longitude: 31.3140,
  ),

  'Ain Shams': StationCoordinate(
    latitude: 30.1310,
    longitude: 31.3190,
  ),

  'Ezbet El-Nakhl': StationCoordinate(
    latitude: 30.1390,
    longitude: 31.3240,
  ),

  'El-Marg': StationCoordinate(
    latitude: 30.1520,
    longitude: 31.3360,
  ),

  'New El-Marg': StationCoordinate(
    latitude: 30.1630,
    longitude: 31.3390,
  ),

  // =========================
  // Line 2
  // =========================

  'Shubra El-Kheima': StationCoordinate(
    latitude: 30.1280,
    longitude: 31.2440,
  ),

  'Koleyet El-Zeraa': StationCoordinate(
    latitude: 30.1130,
    longitude: 31.2460,
  ),

  'Mezallat': StationCoordinate(
    latitude: 30.1030,
    longitude: 31.2460,
  ),

  'Khalafawy': StationCoordinate(
    latitude: 30.0970,
    longitude: 31.2450,
  ),

  'St. Teresa': StationCoordinate(
    latitude: 30.0880,
    longitude: 31.2450,
  ),

  'Rod El-Farag': StationCoordinate(
    latitude: 30.0800,
    longitude: 31.2450,
  ),

  'Massara': StationCoordinate(
    latitude: 30.0710,
    longitude: 31.2460,
  ),

  'Attaba': StationCoordinate(
    latitude: 30.0520,
    longitude: 31.2460,
  ),

  'Mohamed Naguib': StationCoordinate(
    latitude: 30.0450,
    longitude: 31.2440,
  ),

  'Opera': StationCoordinate(
    latitude: 30.0410,
    longitude: 31.2250,
  ),

  'Dokki': StationCoordinate(
    latitude: 30.0380,
    longitude: 31.2120,
  ),

  'Bohooth': StationCoordinate(
    latitude: 30.0360,
    longitude: 31.2010,
  ),

  'Cairo University': StationCoordinate(
    latitude: 30.0230,
    longitude: 31.2070,
  ),

  'Faisal': StationCoordinate(
    latitude: 30.0170,
    longitude: 31.2030,
  ),

  'Giza': StationCoordinate(
    latitude: 30.0060,
    longitude: 31.2080,
  ),

  'Omm El-Masryeen': StationCoordinate(
    latitude: 30.0040,
    longitude: 31.2140,
  ),

  'Sakiat Mekki': StationCoordinate(
    latitude: 29.9950,
    longitude: 31.2130,
  ),

  'El-Mounib': StationCoordinate(
    latitude: 29.9810,
    longitude: 31.2140,
  ),

  // =========================
  // Line 3
  // =========================

  'Adly Mansour': StationCoordinate(
    latitude: 30.1469,
    longitude: 31.4214,
  ),

  'Haykestep': StationCoordinate(
    latitude: 30.1439,
    longitude: 31.4047,
  ),

  'Omar Ibn El-Khattab': StationCoordinate(
    latitude: 30.1406,
    longitude: 31.3942,
  ),

  'Qobaa': StationCoordinate(
    latitude: 30.1347,
    longitude: 31.3839,
  ),

  'Hesham Barakat': StationCoordinate(
    latitude: 30.1311,
    longitude: 31.3728,
  ),

  'El-Nozha': StationCoordinate(
    latitude: 30.1283,
    longitude: 31.3600,
  ),

  'El-Shams Club': StationCoordinate(
    latitude: 30.1222,
    longitude: 31.3439,
  ),

  'Alf Maskan': StationCoordinate(
    latitude: 30.1181,
    longitude: 31.3397,
  ),

  'Heliopolis': StationCoordinate(
    latitude: 30.1081,
    longitude: 31.3375,
  ),

  'Haroun': StationCoordinate(
    latitude: 30.1011,
    longitude: 31.3328,
  ),

  'Al-Ahram': StationCoordinate(
    latitude: 30.0914,
    longitude: 31.3264,
  ),

  'Koleyet El-Banat': StationCoordinate(
    latitude: 30.0836,
    longitude: 31.3289,
  ),

  'Stadium': StationCoordinate(
    latitude: 30.0731,
    longitude: 31.3175,
  ),

  'Fair Zone': StationCoordinate(
    latitude: 30.0733,
    longitude: 31.3011,
  ),

  'Abbassia': StationCoordinate(
    latitude: 30.0697,
    longitude: 31.2808,
  ),

  'Abdou Pasha': StationCoordinate(
    latitude: 30.0647,
    longitude: 31.2747,
  ),

  'Bab El-Shaaria': StationCoordinate(
    latitude: 30.0539,
    longitude: 31.2561,
  ),

  'Kit Kat': StationCoordinate(
    latitude: 30.0610,
    longitude: 31.2130,
  ),

  'Maspero': StationCoordinate(
    latitude: 30.0556,
    longitude: 31.2322,
  ),

  // =========================
  // Rod El-Farag Branch
  // =========================

  'Sudan': StationCoordinate(
    latitude: 30.0730,
    longitude: 31.2030,
  ),

  'Imbaba': StationCoordinate(
    latitude: 30.0750,
    longitude: 31.2080,
  ),

  'El-Bohy': StationCoordinate(
    latitude: 30.0780,
    longitude: 31.2140,
  ),

  'Al-Tawfikia': StationCoordinate(
    latitude: 30.0750,
    longitude: 31.2200,
  ),

  'Wadi El-Nile': StationCoordinate(
    latitude: 30.0710,
    longitude: 31.2180,
  ),

  // =========================
  // Cairo University Branch
  // =========================

  'Gamat El-Dowal': StationCoordinate(
    latitude: 30.0520,
    longitude: 31.2050,
  ),

  'Boulak El-Dakrour': StationCoordinate(
    latitude: 30.0350,
    longitude: 31.1960,
  ),
};