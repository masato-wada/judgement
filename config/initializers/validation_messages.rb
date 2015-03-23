# -*- coding: utf-8 -*-
require 'nkf'
module ValidationMessages

  CHAR_LENGTH = "文字以内で入力してください"
  CHAR_HANKAKU_NG = "半角カナ／記号は使用できません"
  CHAR_ZENKAKU_KATALKANA = "全角カタカナで入力してください"
  CHAR_HANKAKU = "半角英数字で入力してください"
  CHAR_PHONE_NG = "半角数値および-で入力してください"
  CHAR_ZIPCODE_NG = "半角数値および-で入力してください"
  CHAR_EMAIL_NG = "メールアドレスの形式が不適切です"
  CHAR_IMAGE_NG = "画像を登録して下さい"
  CHAR_PASS_LENGTH = "6文字以上12文字以下で入力してください"
  CHAR_PASS_DIFF = "確認用パスワードと異なります"

  ESSENTIAL = "必須入力項目です"
  DUPLICATE_EMAIL = "Eメールアドレスは既に使用されています"

  MANIPULATION = "不正な投稿のため、もう一度投稿ください"

  # 半角のみで構成されているか？
  def check_hankaku?(txt)
    # 半角のみOKなので、全角が混ざっているとfalseが返る
    unless txt.to_s =~ /^[ -~｡-ﾟ]*$/
      return false
    end
    return true
  end

  # 半角カナが含まれているか？
  def check_has_hankaku_katakana?(txt)
    _txt = NKF.nkf("-w -X", txt)
    if (txt == _txt)
      return false
    else
      return true
    end
  end

  # カタカナのみか？
  # カタカナのみ:true
  # 一部記号も許可する
  # 許可する記号は2番目のgsubで指定
  def check_katakana?(txt)
    _txt = txt.gsub(/\p{Katakana}/, '').gsub(/　|。|ー|（|）|・|＆|＜|＞/, '')
    if (_txt.length == 0)
      return true
    else
      return false
    end
  end

  # 電話番号文字列チェック
  def check_phone_char?(txt)
    _txt = txt.gsub(/0|1|2|3|4|5|6|7|8|9|-/, '')
    if (_txt.length == 0)
      return true
    else
      return false
    end
  end

  # 郵便番号文字列チェック
  def check_zipcode_char?(txt)
    _txt = txt.gsub(/0|1|2|3|4|5|6|7|8|9|-/, '')
    if (_txt.length == 0)
      return true
    else
      return false
    end
  end

  module_function :check_hankaku?, :check_has_hankaku_katakana?, :check_katakana?, :check_phone_char?, :check_zipcode_char?

end
