#include "mainwindow.h"
#include <QtWidgets>

MainWindow::MainWindow(QWidget *parent) : QMainWindow(parent)
{
    QPushButton *train_button = new QPushButton(this);
    train_button->setText(tr("something"));
    setCentralWidget(train_button);
}

