#include "Loader.h"
#include <QApplication>
#include <QQuickStyle>
#include <QIcon>

int main(int argc, char *argv[]) {
  // These must be set before creating QGuiApplication
  QApplication app(argc, argv);
  QCoreApplication::setOrganizationName("FFChan");
  QCoreApplication::setApplicationName("FFChan");
  
  // Set application icon (used by window decorations and some platforms)
  app.setWindowIcon(QIcon("qrc:/icon.png"));
  
  // Set Qt Quick style
  QQuickStyle::setStyle("FluentWinUI3");

  // Initialize and run engine (all QML/engine logic in Loader)
  return FFChan::initializeAndRunEngine();
}
