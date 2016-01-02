#include <QApplication>
#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QQuickView>
#include <QQmlEngine>
#include "mainwindow.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc,argv);
    QQuickView view;
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    QObject::connect(view.engine(), SIGNAL(quit()), qApp, SLOT(quit()));
    view.setSource(QUrl("qrc:///FormResults.qml"));
    view.resize(800, 480);
    view.showFullScreen();
    return app.exec();
}
