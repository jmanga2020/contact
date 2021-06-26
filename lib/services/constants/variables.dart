/*contains all global variables to be used over all the app widgets*/

///check if the user has tapped getstarted (condition -> TRUE == ✔️)
bool firstTime = true;

///check if a user has selected the residing region
bool regionsNotSelected = true;
String region = '';
//TODO: REMOVE ALL EXCEPT city
List<Map<String, dynamic>> tanzanianRegions = [
  {
    "city": "Dar es Salaam",
    "lat": "-6.8000",
    "lng": "39.2833",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Dar es Salaam",
    "capital": "primary",
    "population": "6698000",
    "population_proper": "4364541"
  },
  {
    "city": "Arusha",
    "lat": "-3.3667",
    "lng": "36.6833",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Arusha",
    "capital": "admin",
    "population": "416442",
    "population_proper": "416442"
  },
  {
    "city": "Dodoma",
    "lat": "-6.2500",
    "lng": "35.7500",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Dodoma",
    "capital": "primary",
    "population": "410956",
    "population_proper": "410956"
  },
  {
    "city": "Mwanza",
    "lat": "-2.5167",
    "lng": "32.9000",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Mwanza",
    "capital": "admin",
    "population": "385810",
    "population_proper": "385810"
  },
  {
    "city": "Mbeya",
    "lat": "-8.9000",
    "lng": "33.4500",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Mbeya",
    "capital": "admin",
    "population": "291649",
    "population_proper": "232062"
  },
  {
    "city": "Tanga",
    "lat": "-5.0667",
    "lng": "39.1000",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Tanga",
    "capital": "admin",
    "population": "243580",
    "population_proper": "243580"
  },
  {
    "city": "Morogoro",
    "lat": "-6.8242",
    "lng": "37.6633",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Morogoro",
    "capital": "admin",
    "population": "207000",
    "population_proper": "207000"
  },
  {
    "city": "Zanzibar",
    "lat": "-6.1667",
    "lng": "39.2000",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Zanzibar Urban/West",
    "capital": "admin",
    "population": "205870",
    "population_proper": "205870"
  },
  {
    "city": "Sumbawanga",
    "lat": "-7.9667",
    "lng": "31.6167",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Rukwa",
    "capital": "admin",
    "population": "147483",
    "population_proper": "147483"
  },
  {
    "city": "Moshi",
    "lat": "-3.3349",
    "lng": "37.3404",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Kilimanjaro",
    "capital": "admin",
    "population": "144739",
    "population_proper": "144739"
  },
  {
    "city": "Kigoma",
    "lat": "-4.8833",
    "lng": "29.6333",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Kigoma",
    "capital": "admin",
    "population": "130142",
    "population_proper": "130142"
  },
  {
    "city": "Tabora",
    "lat": "-5.0167",
    "lng": "32.8000",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Tabora",
    "capital": "admin",
    "population": "127880",
    "population_proper": "127880"
  },
  {
    "city": "Tukuyu",
    "lat": "-9.2583",
    "lng": "33.6417",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Mbeya",
    "capital": "",
    "population": "127570",
    "population_proper": "28398"
  },
  {
    "city": "Iringa",
    "lat": "-7.7700",
    "lng": "35.6900",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Iringa",
    "capital": "admin",
    "population": "111820",
    "population_proper": "94760"
  },
  {
    "city": "Shinyanga",
    "lat": "-3.6619",
    "lng": "33.4231",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Shinyanga",
    "capital": "admin",
    "population": "107362",
    "population_proper": "80226"
  },
  {
    "city": "Musoma",
    "lat": "-1.5069",
    "lng": "33.8042",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Mara",
    "capital": "admin",
    "population": "103497",
    "population_proper": "103497"
  },
  {
    "city": "Bukoba",
    "lat": "-1.3333",
    "lng": "31.8167",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Kagera",
    "capital": "admin",
    "population": "100504",
    "population_proper": "70628"
  },
  {
    "city": "Songea",
    "lat": "-10.6833",
    "lng": "35.6500",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Ruvuma",
    "capital": "admin",
    "population": "99961",
    "population_proper": "99961"
  },
  {
    "city": "Mtwara",
    "lat": "-10.2736",
    "lng": "40.1828",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Mtwara",
    "capital": "admin",
    "population": "92602",
    "population_proper": "92602"
  },
  {
    "city": "Kilosa",
    "lat": "-6.8396",
    "lng": "36.9900",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Morogoro",
    "capital": "",
    "population": "91889",
    "population_proper": "13227"
  },
  {
    "city": "Uvinza",
    "lat": "-5.1036",
    "lng": "30.3911",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Kigoma",
    "capital": "",
    "population": "80350",
    "population_proper": "24650"
  },
  {
    "city": "Mpanda",
    "lat": "-6.3436",
    "lng": "31.0694",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Katavi",
    "capital": "admin",
    "population": "73338",
    "population_proper": "73338"
  },
  {
    "city": "Singida",
    "lat": "-4.8186",
    "lng": "34.7506",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Singida",
    "capital": "admin",
    "population": "62432",
    "population_proper": "33067"
  },
  {
    "city": "Chake Chake",
    "lat": "-5.2395",
    "lng": "39.7700",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Pemba South",
    "capital": "admin",
    "population": "49959",
    "population_proper": "21686"
  },
  {
    "city": "Ifakara",
    "lat": "-8.1296",
    "lng": "36.6800",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Morogoro",
    "capital": "",
    "population": "49528",
    "population_proper": "6331"
  },
  {
    "city": "Njombe",
    "lat": "-9.3296",
    "lng": "34.7700",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Njombe",
    "capital": "admin",
    "population": "46724",
    "population_proper": "37311"
  },
  {
    "city": "Korogwe",
    "lat": "-5.1558",
    "lng": "38.4503",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Tanga",
    "capital": "",
    "population": "44000",
    "population_proper": "44000"
  },
  {
    "city": "Lindi",
    "lat": "-9.9969",
    "lng": "39.7144",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Lindi",
    "capital": "admin",
    "population": "41549",
    "population_proper": "41549"
  },
  {
    "city": "Tunduma",
    "lat": "-9.3000",
    "lng": "32.7667",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Mbeya",
    "capital": "",
    "population": "36556",
    "population_proper": "18530"
  },
  {
    "city": "Masasi",
    "lat": "-10.7296",
    "lng": "38.7999",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Mtwara",
    "capital": "",
    "population": "36032",
    "population_proper": "27067"
  },
  {
    "city": "Kahama",
    "lat": "-3.8400",
    "lng": "32.6000",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Shinyanga",
    "capital": "",
    "population": "36014",
    "population_proper": "34544"
  },
  {
    "city": "Bagamoyo",
    "lat": "-6.4333",
    "lng": "38.9000",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Coast",
    "capital": "",
    "population": "35000",
    "population_proper": "35000"
  },
  {
    "city": "Biharamulo",
    "lat": "-2.6296",
    "lng": "31.3100",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Kagera",
    "capital": "",
    "population": "34038",
    "population_proper": "9597"
  },
  {
    "city": "Kasulu",
    "lat": "-4.5767",
    "lng": "30.1025",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Kigoma",
    "capital": "",
    "population": "33452",
    "population_proper": "33452"
  },
  {
    "city": "Babati",
    "lat": "-4.2117",
    "lng": "35.7475",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Manyara",
    "capital": "admin",
    "population": "30975",
    "population_proper": "30975"
  },
  {
    "city": "Kibiti",
    "lat": "-7.7296",
    "lng": "38.9500",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Coast",
    "capital": "",
    "population": "30163",
    "population_proper": "943"
  },
  {
    "city": "Sikonge",
    "lat": "-5.6295",
    "lng": "32.7700",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Tabora",
    "capital": "",
    "population": "27113",
    "population_proper": "1986"
  },
  {
    "city": "Nzega",
    "lat": "-4.2096",
    "lng": "33.1800",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Tabora",
    "capital": "",
    "population": "26584",
    "population_proper": "10066"
  },
  {
    "city": "Wete",
    "lat": "-5.0567",
    "lng": "39.7281",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Pemba North",
    "capital": "admin",
    "population": "26450",
    "population_proper": "26450"
  },
  {
    "city": "Kakonko",
    "lat": "-3.2796",
    "lng": "30.9600",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Kigoma",
    "capital": "",
    "population": "24688",
    "population_proper": "7950"
  },
  {
    "city": "Kibaha",
    "lat": "-6.7586",
    "lng": "38.9289",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Coast",
    "capital": "admin",
    "population": "23050",
    "population_proper": "23050"
  },
  {
    "city": "Mkokotoni",
    "lat": "-5.8800",
    "lng": "39.2731",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Zanzibar North",
    "capital": "minor",
    "population": "2572",
    "population_proper": "2572"
  },
  {
    "city": "Geita",
    "lat": "-2.8714",
    "lng": "32.2294",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Geita",
    "capital": "admin",
    "population": "1536",
    "population_proper": "1536"
  },
  {
    "city": "Bariadi",
    "lat": "-2.8000",
    "lng": "33.9833",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Simiyu",
    "capital": "admin",
    "population": "",
    "population_proper": ""
  },
  {
    "city": "Mahonda",
    "lat": "-5.9897",
    "lng": "39.2519",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Zanzibar North",
    "capital": "admin",
    "population": "",
    "population_proper": ""
  },
  {
    "city": "Vwawa",
    "lat": "-9.1081",
    "lng": "32.9347",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Mbeya",
    "capital": "admin",
    "population": "",
    "population_proper": ""
  },
  {
    "city": "Koani",
    "lat": "-6.1333",
    "lng": "39.2833",
    "country": "Tanzania",
    "iso2": "TZ",
    "admin_name": "Zanzibar Central/South",
    "capital": "admin",
    "population": "",
    "population_proper": ""
  }
];
