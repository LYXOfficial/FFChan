#pragma once

#include <QColor>
#include <QObject>
#include <QString>
#include <QStringList>

namespace FFChan {

class Sysfetch : public QObject {
  Q_OBJECT
public:
  explicit Sysfetch(QObject *parent = nullptr) : QObject(parent) {}

  Q_INVOKABLE QColor getSystemThemeColor() const;
  Q_INVOKABLE QString getSystemLanguage() const;
  Q_INVOKABLE QStringList getFFmpegPath() const;
  // Returns "light", "dark" or "auto" (fallback if cannot detect)
  Q_INVOKABLE QString getSystemThemeMode() const;
  // Verify an ffmpeg binary at `path` by running `-version` and checking output
  Q_INVOKABLE bool verifyFFmpeg(const QString &path) const;
  Q_INVOKABLE QString openFile(const QString &filter) const;
  Q_INVOKABLE QString openFile(const QString &filter, const QString &title) const;
  Q_INVOKABLE QString openFile(const QString &filter, const QString &title, const QString &defaultPath) const;
  Q_INVOKABLE QString openFolder(const QString &filter) const;
  Q_INVOKABLE QString openFolder(const QString &filter, const QString &title) const;
  Q_INVOKABLE QString openFolder(const QString &filter, const QString &title, const QString &defaultPath) const;
};

} // namespace FFChan
