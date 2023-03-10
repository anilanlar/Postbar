import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:postbar/core/utils/index.dart';

class TranslationsUtil extends Translations {
  static Locale? locale = LanguageHelper.getLocale();
  static const Locale fallbackLocale = Locale('tr', 'TR');

  @override
  Map<String, Map<String, String>> get keys => const <String, Map<String, String>>{
        "tr": <String, String>{
          "app.updated.dialog.title": "Uygulama Güncelleme",
          "app.updated.dialog.description": "Uygulamamız güncellendi! En yeni özelliklere erişebilmek için uygulamayı hemen güncelleyin.",
          "app.updated.dialog.update": "Güncelle",
          "app.updated.dialog.continue": "Devam Et",
          "app.login.title": "Giriş Yap",
          "app.login.email.hint": "Kullanıcı adı giriniz...",
          "app.login.email.label": "Kullanıcı Adı",
          "app.login.password.hint": "Parolanızı giriniz...",
          "app.login.password.label": "Parola",
          "app.login.button": "GİRİŞ",
          "app.contact.button": "İLETİŞİM",
          "app.login.credentials.empty.title": "Bilgiler Hatalı!",
          "app.login.credentials.empty.message": "Kullanıcı bilgileri boş veya geçersiz olamaz",
          "app.login.error.title": "Bilgiler Hatalı!",
          "app.login.error.message": "Bilgilerinizi kontrol edip tekrar deneyiniz.",
          "app.home.title": "Hoş geldiniz, ",
          "app.home.description": " Ayı Kütüphanesi",
          "app.selected.designs.not.ready": "Seçtiğiniz tasarım yükleniyor...",
          "app.selected.designs.ready": "İşte bu kadar!",
          "app.designs.download": "İNDİR",
          "app.designs.share": "Paylaş",
          "app.designs.discover": "#Keşfet",
          "app.design.download.success.title": "Indirme Başarılı!",
          "app.design.download.success.message": "Düzenlenen tasarım başarıyla cihazınıza kaydedildi.",
          "app.design.download.failure.title": "Indirme Başarısız!",
          "app.design.download.failure.message": "Düzenlenen tasarımı cihazınıza kaydederken bir sorunla karşılaştı. Lütfen tekrar deneyiniz.",
          "app.restart.required": "Bir şeyler yanlış gitti! Uygulamayı tekrardan başlatınız.",
          "app.no.internet": "İnternet bağlantısı bulunamadı.",
          "app.something.went.wrong": "Bir şeyler yanlış gitti!",
          "app.try.later": "Lütfen daha sonra tekrar deneyiniz.",
        },
        "en": <String, String>{
          "app.updated.dialog.title": "App Update",
          "app.updated.dialog.description": "To access most new features update the app immediately.",
          "app.updated.dialog.update": "Update",
          "app.updated.dialog.continue": "Continue",
          "app.login.title": "Sign In",
          "app.login.email.hint": "Enter your username...",
          "app.login.email.label": "User Name",
          "app.login.password.hint": "Enter your password...",
          "app.login.password.label": "Password",
          "app.login.button": "SIGN IN",
          "app.contact.button": "CONTACT",
          "app.login.credentials.empty.title": "Credentials Error!",
          "app.login.credentials.empty.message": "Credentials can not be empty or invalid!",
          "app.login.error.title": "Credentials Error!",
          "app.login.error.message": "Please check your credentials and try again.",
          "app.home.title": "Welcome, ",
          "app.home.description": " Library",
          "app.selected.designs.not.ready": "Selected design is loading...",
          "app.selected.designs.ready": "This is it!",
          "app.designs.download": "Download",
          "app.designs.share": "Share",
          "app.designs.discover": "#Discover",
          "app.design.download.success.title": "Download Successful!",
          "app.design.download.success.message": "Processed design is saved to your device.",
          "app.design.download.failure.title": "Download Failure!",
          "app.design.download.failure.message": "Something went wrong! Please try again.",
          "app.restart.required": "Something went wrong! Please restart the app.",
          "app.no.internet": "Internet connection could not be found.",
          "app.something.went.wrong": "Something went wrong!",
          "app.try.later": "Please try again later.",
        },
      };
}
