import 'package:get/get.dart';

class Messages extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'app_name': 'Game',
          'label_username': 'Username',
          'label_password': 'Password',
          'hint_username': 'Enter your username',
          'hint_password': 'Enter your password',

          'username_3_10': 'Username needs to be 3-10 characters long',
          'username_too_short': 'Username is too short',
          'username_too_long': 'Username is too long',

          'password_3_10': 'Password needs to be 3-10 characters long',
          'password_too_short': 'Password is too short',
          'password_too_long': 'Password is too long',

          //Snackbar
          'login': 'Login',
          'plz_enter_crt': 'Please enter correct credentials',

          //buttons
          'submit_login': 'Submit',

          //------------------Home Screen---------------------//
          'flying_wolf': 'Flyingwolf',
          'choose_your_theme': 'Choose your theme',
          'enable_dark_mode': 'Enable dark mode',
          'logout': 'Logout',
          'elo_rating': 'Elo rating',
          'tournaments': 'Tournaments',
          'played': 'Played',
          'won': 'Won',
          'winning': 'Winning',
          'percentage': 'percentage',
          'recommended_for_you': 'Recommended for you',
        },
        'ja_JA': {
          'app_name': 'ゲーム',
          'label_username': 'ユーザー名',
          'label_password': 'パスワード',
          'hint_username': 'ユーザー名を入力して下さい',
          'hint_password': 'パスワードを入力してください',

          'username_3_10': 'ユーザー名は3〜10文字の長さである必要があります',
          'username_too_short': 'ユーザー名が短すぎます',
          'username_too_long': 'ユーザー名が長すぎます',

          'password_3_10': 'パスワードは3〜10文字の長さである必要があります',
          'password_too_short': 'パスワードが短すぎます',
          'password_too_long': 'パスワードが長すぎます',

          //Snackbar
          'login': 'ログイン',
          'plz_enter_crt': '正しい資格情報を入力してください',

          //buttons
          'submit_login': '参加する',

          //------------------Home Screen---------------------//

          'flying_wolf': 'フライングウルフ',
          'choose_your_theme': 'テーマを選択してください',
          'enable_dark_mode': 'ダークモードを有効にする',
          'logout': 'ログアウト',
          'elo_rating': 'イロレーティング',
          'tournaments': 'トーナメント',
          'played': 'プレイした',
          'won': '勝った',
          'winning': '勝つ',
          'percentage': 'パーセンテージ',
          'recommended_for_you': 'あなたにおすすめ',
        }
      };
}
