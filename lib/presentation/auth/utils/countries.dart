import 'package:freezed_annotation/freezed_annotation.dart';

part 'countries.freezed.dart';
part 'countries.g.dart';

@freezed
class Country with _$Country {
  const factory Country({
    required String code,
    // ignore: non_constant_identifier_names
    required String dialCode,
    required String flag,
    required String name,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}

List<Map<String, dynamic>> countryListJson = [
  {"name": "Afghanistan", "flag": "🇦🇫", "code": "AF", "dialCode": "+93"},
  {"name": "Åland Islands", "flag": "🇦🇽", "code": "AX", "dialCode": "+358"},
  {"name": "Albania", "flag": "🇦🇱", "code": "AL", "dialCode": "+355"},
  {"name": "Algeria", "flag": "🇩🇿", "code": "DZ", "dialCode": "+213"},
  {"name": "American Samoa", "flag": "🇦🇸", "code": "AS", "dialCode": "+1684"},
  {"name": "Andorra", "flag": "🇦🇩", "code": "AD", "dialCode": "+376"},
  {"name": "Angola", "flag": "🇦🇴", "code": "AO", "dialCode": "+244"},
  {"name": "Anguilla", "flag": "🇦🇮", "code": "AI", "dialCode": "+1264"},
  {"name": "Antarctica", "flag": "🇦🇶", "code": "AQ", "dialCode": "+672"},
  {
    "name": "Antigua and Barbuda",
    "flag": "🇦🇬",
    "code": "AG",
    "dialCode": "+1268"
  },
  {"name": "Argentina", "flag": "🇦🇷", "code": "AR", "dialCode": "+54"},
  {"name": "Armenia", "flag": "🇦🇲", "code": "AM", "dialCode": "+374"},
  {"name": "Aruba", "flag": "🇦🇼", "code": "AW", "dialCode": "+297"},
  {"name": "Australia", "flag": "🇦🇺", "code": "AU", "dialCode": "+61"},
  {"name": "Austria", "flag": "🇦🇹", "code": "AT", "dialCode": "+43"},
  {"name": "Azerbaijan", "flag": "🇦🇿", "code": "AZ", "dialCode": "+994"},
  {"name": "Bahamas", "flag": "🇧🇸", "code": "BS", "dialCode": "+1242"},
  {"name": "Bahrain", "flag": "🇧🇭", "code": "BH", "dialCode": "+973"},
  {"name": "Bangladesh", "flag": "🇧🇩", "code": "BD", "dialCode": "+880"},
  {"name": "Barbados", "flag": "🇧🇧", "code": "BB", "dialCode": "+1246"},
  {"name": "Belarus", "flag": "🇧🇾", "code": "BY", "dialCode": "+375"},
  {"name": "Belgium", "flag": "🇧🇪", "code": "BE", "dialCode": "+32"},
  {"name": "Belize", "flag": "🇧🇿", "code": "BZ", "dialCode": "+501"},
  {"name": "Benin", "flag": "🇧🇯", "code": "BJ", "dialCode": "+229"},
  {"name": "Bermuda", "flag": "🇧🇲", "code": "BM", "dialCode": "+1441"},
  {"name": "Bhutan", "flag": "🇧🇹", "code": "BT", "dialCode": "+975"},
  {
    "name": "Bolivia, Plurinational State of bolivia",
    "flag": "🇧🇴",
    "code": "BO",
    "dialCode": "+591"
  },
  {
    "name": "Bosnia and Herzegovina",
    "flag": "🇧🇦",
    "code": "BA",
    "dialCode": "+387"
  },
  {"name": "Botswana", "flag": "🇧🇼", "code": "BW", "dialCode": "+267"},
  {"name": "Bouvet Island", "flag": "🇧🇻", "code": "BV", "dialCode": "+47"},
  {"name": "Brazil", "flag": "🇧🇷", "code": "BR", "dialCode": "+55"},
  {
    "name": "British Indian Ocean Territory",
    "flag": "🇮🇴",
    "code": "IO",
    "dialCode": "+246"
  },
  {
    "name": "Brunei Darussalam",
    "flag": "🇧🇳",
    "code": "BN",
    "dialCode": "+673"
  },
  {"name": "Bulgaria", "flag": "🇧🇬", "code": "BG", "dialCode": "+359"},
  {"name": "Burkina Faso", "flag": "🇧🇫", "code": "BF", "dialCode": "+226"},
  {"name": "Burundi", "flag": "🇧🇮", "code": "BI", "dialCode": "+257"},
  {"name": "Cambodia", "flag": "🇰🇭", "code": "KH", "dialCode": "+855"},
  {"name": "Cameroon", "flag": "🇨🇲", "code": "CM", "dialCode": "+237"},
  {"name": "Canada", "flag": "🇨🇦", "code": "CA", "dialCode": "+1"},
  {"name": "Cape Verde", "flag": "🇨🇻", "code": "CV", "dialCode": "+238"},
  {"name": "Cayman Islands", "flag": "🇰🇾", "code": "KY", "dialCode": "+345"},
  {
    "name": "Central African Republic",
    "flag": "🇨🇫",
    "code": "CF",
    "dialCode": "+236"
  },
  {"name": "Chad", "flag": "🇹🇩", "code": "TD", "dialCode": "+235"},
  {"name": "Chile", "flag": "🇨🇱", "code": "CL", "dialCode": "+56"},
  {"name": "China", "flag": "🇨🇳", "code": "CN", "dialCode": "+86"},
  {"name": "Christmas Island", "flag": "🇨🇽", "code": "CX", "dialCode": "+61"},
  {
    "name": "Cocos (Keeling) Islands",
    "flag": "🇨🇨",
    "code": "CC",
    "dialCode": "+61"
  },
  {"name": "Colombia", "flag": "🇨🇴", "code": "CO", "dialCode": "+57"},
  {"name": "Comoros", "flag": "🇰🇲", "code": "KM", "dialCode": "+269"},
  {"name": "Congo", "flag": "🇨🇬", "code": "CG", "dialCode": "+242"},
  {
    "name": "Congo, The Democratic Republic of the Congo",
    "flag": "🇨🇩",
    "code": "CD",
    "dialCode": "+243"
  },
  {"name": "Cook Islands", "flag": "🇨🇰", "code": "CK", "dialCode": "+682"},
  {"name": "Costa Rica", "flag": "🇨🇷", "code": "CR", "dialCode": "+506"},
  {"name": "Cote d'Ivoire", "flag": "🇨🇮", "code": "CI", "dialCode": "+225"},
  {"name": "Croatia", "flag": "🇭🇷", "code": "HR", "dialCode": "+385"},
  {"name": "Cuba", "flag": "🇨🇺", "code": "CU", "dialCode": "+53"},
  {"name": "Cyprus", "flag": "🇨🇾", "code": "CY", "dialCode": "+357"},
  {"name": "Czech Republic", "flag": "🇨🇿", "code": "CZ", "dialCode": "+420"},
  {"name": "Denmark", "flag": "🇩🇰", "code": "DK", "dialCode": "+45"},
  {"name": "Djibouti", "flag": "🇩🇯", "code": "DJ", "dialCode": "+253"},
  {"name": "Dominica", "flag": "🇩🇲", "code": "DM", "dialCode": "+1767"},
  {
    "name": "Dominican Republic",
    "flag": "🇩🇴",
    "code": "DO",
    "dialCode": "+1849"
  },
  {"name": "Ecuador", "flag": "🇪🇨", "code": "EC", "dialCode": "+593"},
  {"name": "Egypt", "flag": "🇪🇬", "code": "EG", "dialCode": "+20"},
  {"name": "El Salvador", "flag": "🇸🇻", "code": "SV", "dialCode": "+503"},
  {
    "name": "Equatorial Guinea",
    "flag": "🇬🇶",
    "code": "GQ",
    "dialCode": "+240"
  },
  {"name": "Eritrea", "flag": "🇪🇷", "code": "ER", "dialCode": "+291"},
  {"name": "Estonia", "flag": "🇪🇪", "code": "EE", "dialCode": "+372"},
  {"name": "Ethiopia", "flag": "🇪🇹", "code": "ET", "dialCode": "+251"},
  {
    "name": "Falkland Islands (Malvinas)",
    "flag": "🇫🇰",
    "code": "FK",
    "dialCode": "+500"
  },
  {"name": "Faroe Islands", "flag": "🇫🇴", "code": "FO", "dialCode": "+298"},
  {"name": "Fiji", "flag": "🇫🇯", "code": "FJ", "dialCode": "+679"},
  {"name": "Finland", "flag": "🇫🇮", "code": "FI", "dialCode": "+358"},
  {"name": "France", "flag": "🇫🇷", "code": "FR", "dialCode": "+33"},
  {"name": "French Guiana", "flag": "🇬🇫", "code": "GF", "dialCode": "+594"},
  {
    "name": "French Polynesia",
    "flag": "🇵🇫",
    "code": "PF",
    "dialCode": "+689"
  },
  {
    "name": "French Southern Territories",
    "flag": "🇹🇫",
    "code": "TF",
    "dialCode": "+262"
  },
  {"name": "Gabon", "flag": "🇬🇦", "code": "GA", "dialCode": "+241"},
  {"name": "Gambia", "flag": "🇬🇲", "code": "GM", "dialCode": "+220"},
  {"name": "Georgia", "flag": "🇬🇪", "code": "GE", "dialCode": "+995"},
  {"name": "Germany", "flag": "🇩🇪", "code": "DE", "dialCode": "+49"},
  {"name": "Ghana", "flag": "🇬🇭", "code": "GH", "dialCode": "+233"},
  {"name": "Gibraltar", "flag": "🇬🇮", "code": "GI", "dialCode": "+350"},
  {"name": "Greece", "flag": "🇬🇷", "code": "GR", "dialCode": "+30"},
  {"name": "Greenland", "flag": "🇬🇱", "code": "GL", "dialCode": "+299"},
  {"name": "Grenada", "flag": "🇬🇩", "code": "GD", "dialCode": "+1473"},
  {"name": "Guadeloupe", "flag": "🇬🇵", "code": "GP", "dialCode": "+590"},
  {"name": "Guam", "flag": "🇬🇺", "code": "GU", "dialCode": "+1671"},
  {"name": "Guatemala", "flag": "🇬🇹", "code": "GT", "dialCode": "+502"},
  {"name": "Guernsey", "flag": "🇬🇬", "code": "GG", "dialCode": "+44"},
  {"name": "Guinea", "flag": "🇬🇳", "code": "GN", "dialCode": "+224"},
  {"name": "Guinea-Bissau", "flag": "🇬🇼", "code": "GW", "dialCode": "+245"},
  {"name": "Guyana", "flag": "🇬🇾", "code": "GY", "dialCode": "+592"},
  {"name": "Haiti", "flag": "🇭🇹", "code": "HT", "dialCode": "+509"},
  {
    "name": "Heard Island and Mcdonald Islands",
    "flag": "🇭🇲",
    "code": "HM",
    "dialCode": "+672"
  },
  {
    "name": "Holy See (Vatican City State)",
    "flag": "🇻🇦",
    "code": "VA",
    "dialCode": "+379"
  },
  {"name": "Honduras", "flag": "🇭🇳", "code": "HN", "dialCode": "+504"},
  {"name": "Hong Kong", "flag": "🇭🇰", "code": "HK", "dialCode": "+852"},
  {"name": "Hungary", "flag": "🇭🇺", "code": "HU", "dialCode": "+36"},
  {"name": "Iceland", "flag": "🇮🇸", "code": "IS", "dialCode": "+354"},
  {"name": "India", "flag": "🇮🇳", "code": "IN", "dialCode": "+91"},
  {"name": "Indonesia", "flag": "🇮🇩", "code": "ID", "dialCode": "+62"},
  {
    "name": "Iran, Islamic Republic of Persian Gulf",
    "flag": "🇮🇷",
    "code": "IR",
    "dialCode": "+98"
  },
  {"name": "Iraq", "flag": "🇮🇶", "code": "IQ", "dialCode": "+964"},
  {"name": "Ireland", "flag": "🇮🇪", "code": "IE", "dialCode": "+353"},
  {"name": "Isle of Man", "flag": "🇮🇲", "code": "IM", "dialCode": "+44"},
  {"name": "Israel", "flag": "🇮🇱", "code": "IL", "dialCode": "+972"},
  {"name": "Italy", "flag": "🇮🇹", "code": "IT", "dialCode": "+39"},
  {"name": "Jamaica", "flag": "🇯🇲", "code": "JM", "dialCode": "+1876"},
  {"name": "Japan", "flag": "🇯🇵", "code": "JP", "dialCode": "+81"},
  {"name": "Jersey", "flag": "🇯🇪", "code": "JE", "dialCode": "+44"},
  {"name": "Jordan", "flag": "🇯🇴", "code": "JO", "dialCode": "+962"},
  {"name": "Kazakhstan", "flag": "🇰🇿", "code": "KZ", "dialCode": "+7"},
  {"name": "Kenya", "flag": "🇰🇪", "code": "KE", "dialCode": "+254"},
  {"name": "Kiribati", "flag": "🇰🇮", "code": "KI", "dialCode": "+686"},
  {
    "name": "Korea, Democratic People's Republic of Korea",
    "flag": "🇰🇵",
    "code": "KP",
    "dialCode": "+850"
  },
  {
    "name": "Korea, Republic of South Korea",
    "flag": "🇰🇷",
    "code": "KR",
    "dialCode": "+82"
  },
  {"name": "Kosovo", "flag": "🇽🇰", "code": "XK", "dialCode": "+383"},
  {"name": "Kuwait", "flag": "🇰🇼", "code": "KW", "dialCode": "+965"},
  {"name": "Kyrgyzstan", "flag": "🇰🇬", "code": "KG", "dialCode": "+996"},
  {"name": "Laos", "flag": "🇱🇦", "code": "LA", "dialCode": "+856"},
  {"name": "Latvia", "flag": "🇱🇻", "code": "LV", "dialCode": "+371"},
  {"name": "Lebanon", "flag": "🇱🇧", "code": "LB", "dialCode": "+961"},
  {"name": "Lesotho", "flag": "🇱🇸", "code": "LS", "dialCode": "+266"},
  {"name": "Liberia", "flag": "🇱🇷", "code": "LR", "dialCode": "+231"},
  {
    "name": "Libyan Arab Jamahiriya",
    "flag": "🇱🇾",
    "code": "LY",
    "dialCode": "+218"
  },
  {"name": "Liechtenstein", "flag": "🇱🇮", "code": "LI", "dialCode": "+423"},
  {"name": "Lithuania", "flag": "🇱🇹", "code": "LT", "dialCode": "+370"},
  {"name": "Luxembourg", "flag": "🇱🇺", "code": "LU", "dialCode": "+352"},
  {"name": "Macao", "flag": "🇲🇴", "code": "MO", "dialCode": "+853"},
  {"name": "Macedonia", "flag": "🇲🇰", "code": "MK", "dialCode": "+389"},
  {"name": "Madagascar", "flag": "🇲🇬", "code": "MG", "dialCode": "+261"},
  {"name": "Malawi", "flag": "🇲🇼", "code": "MW", "dialCode": "+265"},
  {"name": "Malaysia", "flag": "🇲🇾", "code": "MY", "dialCode": "+60"},
  {"name": "Maldives", "flag": "🇲🇻", "code": "MV", "dialCode": "+960"},
  {"name": "Mali", "flag": "🇲🇱", "code": "ML", "dialCode": "+223"},
  {"name": "Malta", "flag": "🇲🇹", "code": "MT", "dialCode": "+356"},
  {
    "name": "Marshall Islands",
    "flag": "🇲🇭",
    "code": "MH",
    "dialCode": "+692"
  },
  {"name": "Martinique", "flag": "🇲🇶", "code": "MQ", "dialCode": "+596"},
  {"name": "Mauritania", "flag": "🇲🇷", "code": "MR", "dialCode": "+222"},
  {"name": "Mauritius", "flag": "🇲🇺", "code": "MU", "dialCode": "+230"},
  {"name": "Mayotte", "flag": "🇾🇹", "code": "YT", "dialCode": "+262"},
  {"name": "Mexico", "flag": "🇲🇽", "code": "MX", "dialCode": "+52"},
  {
    "name": "Micronesia, Federated States of Micronesia",
    "flag": "🇫🇲",
    "code": "FM",
    "dialCode": "+691"
  },
  {"name": "Moldova", "flag": "🇲🇩", "code": "MD", "dialCode": "+373"},
  {"name": "Monaco", "flag": "🇲🇨", "code": "MC", "dialCode": "+377"},
  {"name": "Mongolia", "flag": "🇲🇳", "code": "MN", "dialCode": "+976"},
  {"name": "Montenegro", "flag": "🇲🇪", "code": "ME", "dialCode": "+382"},
  {"name": "Montserrat", "flag": "🇲🇸", "code": "MS", "dialCode": "+1664"},
  {"name": "Morocco", "flag": "🇲🇦", "code": "MA", "dialCode": "+212"},
  {"name": "Mozambique", "flag": "🇲🇿", "code": "MZ", "dialCode": "+258"},
  {"name": "Myanmar", "flag": "🇲🇲", "code": "MM", "dialCode": "+95"},
  {"name": "Namibia", "flag": "🇳🇦", "code": "NA", "dialCode": "+264"},
  {"name": "Nauru", "flag": "🇳🇷", "code": "NR", "dialCode": "+674"},
  {"name": "Nepal", "flag": "🇳🇵", "code": "NP", "dialCode": "+977"},
  {"name": "Netherlands", "flag": "🇳🇱", "code": "NL", "dialCode": "+31"},
  {"name": "New Caledonia", "flag": "🇳🇨", "code": "NC", "dialCode": "+687"},
  {"name": "New Zealand", "flag": "🇳🇿", "code": "NZ", "dialCode": "+64"},
  {"name": "Nicaragua", "flag": "🇳🇮", "code": "NI", "dialCode": "+505"},
  {"name": "Niger", "flag": "🇳🇪", "code": "NE", "dialCode": "+227"},
  {"name": "Nigeria", "flag": "🇳🇬", "code": "NG", "dialCode": "+234"},
  {"name": "Niue", "flag": "🇳🇺", "code": "NU", "dialCode": "+683"},
  {"name": "Norfolk Island", "flag": "🇳🇫", "code": "NF", "dialCode": "+672"},
  {
    "name": "Northern Mariana Islands",
    "flag": "🇲🇵",
    "code": "MP",
    "dialCode": "+1670"
  },
  {"name": "Norway", "flag": "🇳🇴", "code": "NO", "dialCode": "+47"},
  {"name": "Oman", "flag": "🇴🇲", "code": "OM", "dialCode": "+968"},
  {"name": "Pakistan", "flag": "🇵🇰", "code": "PK", "dialCode": "+92"},
  {"name": "Palau", "flag": "🇵🇼", "code": "PW", "dialCode": "+680"},
  {
    "name": "Palestinian Territory, Occupied",
    "flag": "🇵🇸",
    "code": "PS",
    "dialCode": "+970"
  },
  {"name": "Panama", "flag": "🇵🇦", "code": "PA", "dialCode": "+507"},
  {
    "name": "Papua New Guinea",
    "flag": "🇵🇬",
    "code": "PG",
    "dialCode": "+675"
  },
  {"name": "Paraguay", "flag": "🇵🇾", "code": "PY", "dialCode": "+595"},
  {"name": "Peru", "flag": "🇵🇪", "code": "PE", "dialCode": "+51"},
  {"name": "Philippines", "flag": "🇵🇭", "code": "PH", "dialCode": "+63"},
  {"name": "Pitcairn", "flag": "🇵🇳", "code": "PN", "dialCode": "+64"},
  {"name": "Poland", "flag": "🇵🇱", "code": "PL", "dialCode": "+48"},
  {"name": "Portugal", "flag": "🇵🇹", "code": "PT", "dialCode": "+351"},
  {"name": "Puerto Rico", "flag": "🇵🇷", "code": "PR", "dialCode": "+1939"},
  {"name": "Qatar", "flag": "🇶🇦", "code": "QA", "dialCode": "+974"},
  {"name": "Romania", "flag": "🇷🇴", "code": "RO", "dialCode": "+40"},
  {"name": "Russia", "flag": "🇷🇺", "code": "RU", "dialCode": "+7"},
  {"name": "Rwanda", "flag": "🇷🇼", "code": "RW", "dialCode": "+250"},
  {"name": "Reunion", "flag": "🇷🇪", "code": "RE", "dialCode": "+262"},
  {
    "name": "Saint Barthelemy",
    "flag": "🇧🇱",
    "code": "BL",
    "dialCode": "+590"
  },
  {
    "name": "Saint Helena, Ascension and Tristan Da Cunha",
    "flag": "🇸🇭",
    "code": "SH",
    "dialCode": "+290"
  },
  {
    "name": "Saint Kitts and Nevis",
    "flag": "🇰🇳",
    "code": "KN",
    "dialCode": "+1869"
  },
  {"name": "Saint Lucia", "flag": "🇱🇨", "code": "LC", "dialCode": "+1758"},
  {"name": "Saint Martin", "flag": "🇲🇫", "code": "MF", "dialCode": "+590"},
  {
    "name": "Saint Pierre and Miquelon",
    "flag": "🇵🇲",
    "code": "PM",
    "dialCode": "+508"
  },
  {
    "name": "Saint Vincent and the Grenadines",
    "flag": "🇻🇨",
    "code": "VC",
    "dialCode": "+1784"
  },
  {"name": "Samoa", "flag": "🇼🇸", "code": "WS", "dialCode": "+685"},
  {"name": "San Marino", "flag": "🇸🇲", "code": "SM", "dialCode": "+378"},
  {
    "name": "Sao Tome and Principe",
    "flag": "🇸🇹",
    "code": "ST",
    "dialCode": "+239"
  },
  {"name": "Saudi Arabia", "flag": "🇸🇦", "code": "SA", "dialCode": "+966"},
  {"name": "Senegal", "flag": "🇸🇳", "code": "SN", "dialCode": "+221"},
  {"name": "Serbia", "flag": "🇷🇸", "code": "RS", "dialCode": "+381"},
  {"name": "Seychelles", "flag": "🇸🇨", "code": "SC", "dialCode": "+248"},
  {"name": "Sierra Leone", "flag": "🇸🇱", "code": "SL", "dialCode": "+232"},
  {"name": "Singapore", "flag": "🇸🇬", "code": "SG", "dialCode": "+65"},
  {"name": "Slovakia", "flag": "🇸🇰", "code": "SK", "dialCode": "+421"},
  {"name": "Slovenia", "flag": "🇸🇮", "code": "SI", "dialCode": "+386"},
  {"name": "Solomon Islands", "flag": "🇸🇧", "code": "SB", "dialCode": "+677"},
  {"name": "Somalia", "flag": "🇸🇴", "code": "SO", "dialCode": "+252"},
  {"name": "South Africa", "flag": "🇿🇦", "code": "ZA", "dialCode": "+27"},
  {"name": "South Sudan", "flag": "🇸🇸", "code": "SS", "dialCode": "+211"},
  {
    "name": "South Georgia and the South Sandwich Islands",
    "flag": "🇬🇸",
    "code": "GS",
    "dialCode": "+500"
  },
  {"name": "Spain", "flag": "🇪🇸", "code": "ES", "dialCode": "+34"},
  {"name": "Sri Lanka", "flag": "🇱🇰", "code": "LK", "dialCode": "+94"},
  {"name": "Sudan", "flag": "🇸🇩", "code": "SD", "dialCode": "+249"},
  {"name": "Suriname", "flag": "🇸🇷", "code": "SR", "dialCode": "+597"},
  {
    "name": "Svalbard and Jan Mayen",
    "flag": "🇸🇯",
    "code": "SJ",
    "dialCode": "+47"
  },
  {"name": "Swaziland", "flag": "🇸🇿", "code": "SZ", "dialCode": "+268"},
  {"name": "Sweden", "flag": "🇸🇪", "code": "SE", "dialCode": "+46"},
  {"name": "Switzerland", "flag": "🇨🇭", "code": "CH", "dialCode": "+41"},
  {
    "name": "Syrian Arab Republic",
    "flag": "🇸🇾",
    "code": "SY",
    "dialCode": "+963"
  },
  {"name": "Taiwan", "flag": "🇹🇼", "code": "TW", "dialCode": "+886"},
  {"name": "Tajikistan", "flag": "🇹🇯", "code": "TJ", "dialCode": "+992"},
  {
    "name": "Tanzania, United Republic of Tanzania",
    "flag": "🇹🇿",
    "code": "TZ",
    "dialCode": "+255"
  },
  {"name": "Thailand", "flag": "🇹🇭", "code": "TH", "dialCode": "+66"},
  {"name": "Timor-Leste", "flag": "🇹🇱", "code": "TL", "dialCode": "+670"},
  {"name": "Togo", "flag": "🇹🇬", "code": "TG", "dialCode": "+228"},
  {"name": "Tokelau", "flag": "🇹🇰", "code": "TK", "dialCode": "+690"},
  {"name": "Tonga", "flag": "🇹🇴", "code": "TO", "dialCode": "+676"},
  {
    "name": "Trinidad and Tobago",
    "flag": "🇹🇹",
    "code": "TT",
    "dialCode": "+1868"
  },
  {"name": "Tunisia", "flag": "🇹🇳", "code": "TN", "dialCode": "+216"},
  {"name": "Turkey", "flag": "🇹🇷", "code": "TR", "dialCode": "+90"},
  {"name": "Turkmenistan", "flag": "🇹🇲", "code": "TM", "dialCode": "+993"},
  {
    "name": "Turks and Caicos Islands",
    "flag": "🇹🇨",
    "code": "TC",
    "dialCode": "+1649"
  },
  {"name": "Tuvalu", "flag": "🇹🇻", "code": "TV", "dialCode": "+688"},
  {"name": "Uganda", "flag": "🇺🇬", "code": "UG", "dialCode": "+256"},
  {"name": "Ukraine", "flag": "🇺🇦", "code": "UA", "dialCode": "+380"},
  {
    "name": "United Arab Emirates",
    "flag": "🇦🇪",
    "code": "AE",
    "dialCode": "+971"
  },
  {"name": "United Kingdom", "flag": "🇬🇧", "code": "GB", "dialCode": "+44"},
  {"name": "United States", "flag": "🇺🇸", "code": "US", "dialCode": "+1"},
  {"name": "Uruguay", "flag": "🇺🇾", "code": "UY", "dialCode": "+598"},
  {"name": "Uzbekistan", "flag": "🇺🇿", "code": "UZ", "dialCode": "+998"},
  {"name": "Vanuatu", "flag": "🇻🇺", "code": "VU", "dialCode": "+678"},
  {
    "name": "Venezuela, Bolivarian Republic of Venezuela",
    "flag": "🇻🇪",
    "code": "VE",
    "dialCode": "+58"
  },
  {"name": "Vietnam", "flag": "🇻🇳", "code": "VN", "dialCode": "+84"},
  {
    "name": "Virgin Islands, British",
    "flag": "🇻🇬",
    "code": "VG",
    "dialCode": "+1284"
  },
  {
    "name": "Virgin Islands, U.S.",
    "flag": "🇻🇮",
    "code": "VI",
    "dialCode": "+1340"
  },
  {
    "name": "Wallis and Futuna",
    "flag": "🇼🇫",
    "code": "WF",
    "dialCode": "+681"
  },
  {"name": "Yemen", "flag": "🇾🇪", "code": "YE", "dialCode": "+967"},
  {"name": "Zambia", "flag": "🇿🇲", "code": "ZM", "dialCode": "+260"},
  {"name": "Zimbabwe", "flag": "🇿🇼", "code": "ZW", "dialCode": "+263"}
];

final countries = countryListJson
    .map((countryJson) => Country.fromJson(countryJson))
    .toList();
