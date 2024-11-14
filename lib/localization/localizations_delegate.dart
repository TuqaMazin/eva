import 'package:get/get.dart';

import 'languages/language_ar.dart';
import 'languages/language_az.dart';
import 'languages/language_bn.dart';
import 'languages/language_cs.dart';
import 'languages/language_de.dart';
import 'languages/language_el.dart';
import 'languages/language_en.dart';
import 'languages/language_es.dart';
import 'languages/language_fa.dart';
import 'languages/language_fr.dart';
import 'languages/language_gu.dart';
import 'languages/language_hi.dart';
import 'languages/language_hr.dart';
import 'languages/language_hu.dart';
import 'languages/language_id.dart';
import 'languages/language_it.dart';
import 'languages/language_ja.dart';
import 'languages/language_kn.dart';
import 'languages/language_ko.dart';
import 'languages/language_ml.dart';
import 'languages/language_mr.dart';
import 'languages/language_my.dart';
import 'languages/language_nb.dart';
import 'languages/language_nl.dart';
import 'languages/language_or.dart';
import 'languages/language_pa.dart';
import 'languages/language_pl.dart';
import 'languages/language_pt.dart';
import 'languages/language_ro.dart';
import 'languages/language_ru.dart';
import 'languages/language_sq.dart';
import 'languages/language_sv.dart';
import 'languages/language_ta.dart';
import 'languages/language_te.dart';
import 'languages/language_th.dart';
import 'languages/language_tr.dart';
import 'languages/language_uk.dart';
import 'languages/language_ur.dart';
import 'languages/language_vi.dart';
import 'languages/language_zh.dart';
import 'languages/language_zh_tw.dart';

class AppLanguages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": enUS,
        "zh_CN": zhCN,
        "ar_SA": arSA,
        "fr_FR": frFR,
        "de_DE": deDE,
        "hi_IN": hiIN,
        "ja_JP": jaJP,
        "pt_PT": ptPT,
        "ru_RU": ruRU,
        "es_ES": esES,
        "ur_PK": urPK,
        "vi_VN": viVN,
        "id_ID": idID,
        "bn_IN": bnIN,
        "ta_IN": taIN,
        "te_IN": teIN,
        "tr_TR": trTR,
        "ko_KR": koKR,
        "pa_IN": paIN,
        "it_IT": itIT,
        "zh_TW": zhTW,
        "uk_UA": ukUA,
        "th_TH": thTH,
        "sq_AL": sqAL,
        "sv_SE": svSE,
        "ro_RO": roRO,
        "pl_PL": plPL,
        "or_IN": orIN,
        "nl_NL": nlNL,
        "nb_NO": nbNO,
        "my_MM": myMM,
        "mr_IN": mrIN,
        "ml_IN": mlIN,
        "kn_IN": knIN,
        "hu_HU": huHU,
        "hr_HR": hrHR,
        "gu_IN": guIN,
        "fa_IR": faIR,
        "el_GR": elGR,
        "cs_CZ": csCZ,
        "az_AZ": azAZ,
      };
}

final List<LanguageModel> languages = [
  LanguageModel("🇦🇱", "Albanian (shqiptare)", 'sq', 'AL'),
  LanguageModel("🇸🇦", "(عربى) Arabic", 'ar', 'SA'),
  LanguageModel("🇦🇿", "Azerbaijani (Azərbaycan)", 'az', 'AF'),
  LanguageModel("🇮🇳", "Bengali (বাংলা)", 'bn', 'IN'),
  LanguageModel("🇲🇲", "Burmese (မြန်မာ)", 'my', 'MM'),
  LanguageModel("🇨🇳", "Chinese Simplified (中国人)", 'zh', 'CN'),
  LanguageModel("🇹🇼", "Chinese Traditional (中國人)", 'zh', 'TW'),
  LanguageModel("🇭🇷", "Croatian (Hrvatski)", 'hr', 'HR'),
  LanguageModel("🇨🇿", "Czech (čeština)", 'cs', 'CZ'),
  LanguageModel("🇳🇱", "Dutch (Nederlands)", 'nl', 'NL'),
  LanguageModel("🇺🇸", "English (English)", 'en', 'US'),
  LanguageModel("🇫🇷", "French (français)", 'fr', 'FR'),
  LanguageModel("🇩🇪", "German (Deutsche)", 'de', 'DE'),
  LanguageModel("🇬🇷", "Greek (Ελληνικά)", 'el', 'GR'),
  LanguageModel("🇮🇳", "Gujarati (ગુજરાતી)", 'gu', 'IN'),
  LanguageModel("🇮🇳", "Hindi (हिंदी)", 'hi', 'IN'),
  LanguageModel("🇭🇺", "Hungarian (Magyar)", 'hu', 'HU'),
  LanguageModel("🇮🇩", "Indonesian (bahasa indo)", 'id', 'ID'),
  LanguageModel("🇮🇹", "Italian (italiana)", 'it', 'IT'),
  LanguageModel("🇯🇵", "Japanese (日本)", 'ja', 'JP'),
  LanguageModel("🇮🇳", "Kannada (ಕನ್ನಡ)", 'kn', 'IN'),
  LanguageModel("🇰🇵", "Korean (한국인)", 'ko', 'KR'),
  LanguageModel("🇮🇳", "Malayalam (മലയാളം)", 'ml', 'IN'),
  LanguageModel("🇮🇳", "Marathi (मराठी)", 'mr', 'IN'),
  LanguageModel("🇳🇴", "Norwegian (norsk)", 'nb', 'NO'),
  LanguageModel("🇮🇳", "Odia (ଓଡିଆ)", 'or', 'IN'),
  LanguageModel("🇮🇷", "Persian (فارسی)", 'fa', 'IR'),
  LanguageModel("🇵🇱", "Polish (Polski)", 'pl', 'PL'),
  LanguageModel("🇵🇹", "Portuguese (português)", 'pt', 'PT'),
  LanguageModel("🇮🇳", "Punjabi (ਪੰਜਾਬੀ)", 'pa', 'IN'),
  LanguageModel("🇷🇴", "Romanian (Română)", 'ro', 'RO'),
  LanguageModel("🇷🇺", "Russian (русский)", 'ru', 'RU'),
  LanguageModel("🇪🇸", "Spanish (Español)", 'es', 'ES'),
  LanguageModel("🇸🇪", "Swedish (svenska)", 'sv', 'SE'),
  LanguageModel("🇮🇳", "Tamil (தமிழ்)", 'ta', 'IN'),
  LanguageModel("🇮🇳", "Telugu (తెలుగు)", 'te', 'IN'),
  LanguageModel("🇹🇭", "Thai (แบบไทย)", 'th', 'TH'),
  LanguageModel("🇹🇷", "Turkish (Türk)", 'tr', 'TR'),
  LanguageModel("🇺🇦", "Ukrainian (українська)", 'uk', 'UA'),
  LanguageModel("🇵🇰", "(اردو) Urdu", 'ur', 'PK'),
  LanguageModel("🇻🇳", "Vietnamese (Tiếng Việt)", 'vi', 'VN'),
];

class LanguageModel {
  LanguageModel(
    this.symbol,
    this.language,
    this.languageCode,
    this.countryCode,
  );

  String language;
  String symbol;
  String countryCode;
  String languageCode;
}
