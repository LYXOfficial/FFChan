#pragma once

#include <QQmlApplicationEngine>
#include <QSettings>
#include <QString>

namespace FFChan {

bool loadConfigIfExists(const QString &cfgPath, QSettings &settings);

// Prepare the QQmlApplicationEngine: detect config.yaml, populate QSettings
// and load either MainWindow.qml or Wizard.qml. Returns true on success.
// Prepare settings (create config file with defaults if missing).
// Returns true if config file existed prior to this call.
bool prepareSettings(const QString &cfgPath);

// Backwards-compatible: prepare and load engine (kept for compatibility)
bool prepareEngine(QQmlApplicationEngine &engine);

// Initialize engine with all context properties, load QML, and run event loop.
// Returns the application exit code.
int initializeAndRunEngine();

} // namespace FFChan