#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QCameraInfo>
#include <QStringListModel>
#include "Backend.h"

int ButtonsClicked::activeButton = 0;
QStringListModel cameraNamesList;
QList<QCameraInfo> camerasList = QCameraInfo::availableCameras();

int main(int argc, char *argv[]) {
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  QGuiApplication app(argc, argv);
  QQmlApplicationEngine engine;

  ButtonsClicked buttonsClicked;
  PopupMenu popupMenu;

  // Get and Populate CameraInfo to CameraList
  QStringList list = cameraNamesList.stringList();
  for (int i = 0; i < camerasList.length(); i++) {
      list.append(camerasList[i].deviceName());
      cout << "cameraNameList += " << camerasList[i].deviceName().toStdString() << endl;
  }
  cameraNamesList.setStringList(list);

  // set context properties to access in QML
  engine.rootContext()->setContextProperty("buttonsClicked", &buttonsClicked);
  engine.rootContext()->setContextProperty("cameraNamesList", &cameraNamesList);
  engine.rootContext()->setContextProperty("popupMenu", &popupMenu);

  engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
  if (engine.rootObjects().isEmpty())
    return -1;

  return app.exec();
}
