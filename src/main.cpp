#include "Loader.h"
#include "Translator.h"
#include "Settings.h"
#include "SettingsBridge.h"
#include "ThemeManager.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include "QtAwesome.h"
#include "QtAwesomeQuickImageProvider.h"
#include <iostream>
#include "Sysfetch.h"

int main(int argc, char *argv[]) {
  // These must be set before creating QGuiApplication
  QGuiApplication app(argc, argv);
  QCoreApplication::setOrganizationName("FFChan");
  QCoreApplication::setApplicationName("FFChan");
  // Set application icon (used by window decorations and some platforms)
  app.setWindowIcon(QIcon("qrc:/icon.png"));
  QQuickStyle::setStyle("FluentWinUI3");
  QQmlApplicationEngine engine;
  FFChan::Translator translator;
  engine.rootContext()->setContextProperty("i18n", &translator);
  // initialize translator to fallback until settings are loaded
  translator.setLocale("en");
  
  std::cout << "DEBUG: i18n set to engine.rootContext(): " << &translator << std::endl;
  std::cout << "DEBUG: system theme is:" << FFChan::getSystemThemeMode().toStdString() << std::endl;

  SettingsBridge settingsBridge;
  engine.rootContext()->setContextProperty("settings", &settingsBridge);

  FFChan::ThemeManager themeManager;
  // initialize theme color and mode to fallback until settings are loaded
  themeManager.setColor(QColor("#39c5bb"));
  themeManager.setMode("auto");
  engine.rootContext()->setContextProperty("theme", &themeManager);
  
  fa::QtAwesome* awesome = new fa::QtAwesome(qApp);
  awesome->initFontAwesome();
  engine.addImageProvider("fa", new QtAwesomeQuickImageProvider(awesome));

  // react to settings changes: update translator and theme manager
  QObject::connect(&settingsBridge, &SettingsBridge::settingChanged,
                   [&translator, &themeManager](const QString &key, const QVariant &value){
    std::cout<<"Setting changed: "<<key.toStdString()<<" = "<<value.toString().toStdString()<<std::endl;
    if (key == "language") {
      translator.setLocale(value.toString());
    } else if (key == "theme/color") {
      themeManager.setColor(QColor(value.toString()));
    } else if (key == "theme/mode") {
      themeManager.setMode(value.toString());
    }
  });

  // CRITICAL: Load QML AFTER all context properties are registered
  bool ok = FFChan::prepareEngine(engine);

  // Now settings have been initialized by prepareEngine — update translator and theme
  translator.setLocale(FFChan::getSetting("language", "en"));
  themeManager.setColor(QColor(FFChan::getSetting("theme/color", "#39c5bb")));
  themeManager.setMode(FFChan::getSetting("theme/mode", "auto"));
  themeManager.applyTheme();

  if (engine.rootObjects().isEmpty())
    return -1;
  return app.exec();
}
