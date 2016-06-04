#include "fileio.h"
#include <QFile>
#include <QTextStream>

FileIO::FileIO()
{

}

void FileIO::save(QString text){
    QFile file("/Users/driesvandevelde/Desktop/text.csv");

    if(file.open(QIODevice::ReadWrite)){
    QTextStream stream(&file);
    stream << text << endl;
    }

    return;

}

FileIO::~FileIO()
{

}

