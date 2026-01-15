#include "Loader.h"
#include "Settings.h"
#include "Translator.h"
#include "SettingsBridge.h"
#include "ThemeManager.h"
#include "Sysfetch.h"
#include "QtAwesome.h"
#include "QtAwesomeQuickImageProvider.h"
#include <QDir>
#include <QFile>
#include <QUrl>
#include <QQmlContext>
#include <QGuiApplication>
#include <iostream>

namespace FFChan {

bool loadConfigIfExists(const QString &cfgPath, QSettings &settings) {
  if (!QFile::exists(cfgPath)) {
    return false;
  }

  FFChan::SettingsManager manager;
  return manager.loadYaml(cfgPath, settings);
}

bool prepareSettings(const QString &cfgPath)
{
  bool existed = QFile::exists(cfgPath);
  initializeSettings(cfgPath);
  return existed;
}

bool prepareEngine(QQmlApplicationEngine &engine) {
  QString cfgPath = QDir::current().filePath("config.yaml");

  bool existed = prepareSettings(cfgPath);
  #ifndef QT_DEBUG
  if (existed) {
    engine.load(QUrl(QStringLiteral("qrc:/qml/MainWindow.qml")));
  } else {
  #endif
    engine.load(QUrl(QStringLiteral("qrc:/qml/Wizard.qml")));
  #ifndef QT_DEBUG
  }
  #endif

  return !engine.rootObjects().isEmpty();
}

int initializeAndRunEngine() {
  QQmlApplicationEngine engine;
  
  // Initialize translator
  Translator translator;
  engine.rootContext()->setContextProperty("i18n", &translator);
  translator.setLocale("en");
  
  std::cout << "DEBUG: i18n set to engine.rootContext(): " << &translator << std::endl;
  // Expose Sysfetch utilities to QML and use it for system info
  FFChan::Sysfetch sysfetch;
  engine.rootContext()->setContextProperty("sysfetch", &sysfetch);
  std::cout << "DEBUG: system theme is:" << sysfetch.getSystemThemeMode().toStdString() << std::endl;

  // Initialize settings bridge
  SettingsBridge settingsBridge;
  engine.rootContext()->setContextProperty("settings", &settingsBridge);

  // Initialize theme manager
  ThemeManager themeManager;
  themeManager.setColor(QColor("#39c5bb"));
  themeManager.setMode("auto");
  engine.rootContext()->setContextProperty("theme", &themeManager);
  
  // Initialize FontAwesome image provider
  fa::QtAwesome* awesome = new fa::QtAwesome(qApp);
  awesome->initFontAwesome();
  engine.addImageProvider("fa", new QtAwesomeQuickImageProvider(awesome));

  // React to settings changes
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

  // Load QML after all context properties are registered
  bool ok = prepareEngine(engine);
  
  // Apply settings loaded from config
  translator.setLocale(getSetting("language", "en"));
  themeManager.setColor(QColor(getSetting("theme/color", "#39c5bb")));
  themeManager.setMode(getSetting("theme/mode", "auto"));
  themeManager.applyTheme();

  if (engine.rootObjects().isEmpty())
    return -1;

  return QCoreApplication::exec();
}

} // namespace FFChan
