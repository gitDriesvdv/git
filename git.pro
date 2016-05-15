TEMPLATE = app

QT += qml quick widgets
QT += qml quick enginio
SOURCES += main.cpp \
    mainwindow.cpp \
    fileio.cpp

RESOURCES += qml.qrc \
    desktop.qrc \
    mobiel.qrc \
    logo.qrc \
    formbuildercomponents.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

HEADERS += \
    mainwindow.h \
    fileio.h
