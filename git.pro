TEMPLATE = app

QT += qml quick widgets
QT += qml quick enginio
SOURCES += main.cpp

RESOURCES += qml.qrc \
    desktop.qrc \
    mobiel.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
