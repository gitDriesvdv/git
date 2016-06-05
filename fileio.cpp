#include "fileio.h"
#include <QFile>
#include <QTextStream>
#include <QFileDialog>
FileIO::FileIO()
{

}

void FileIO::save(QString text, QString url){

    url.remove(1, 7);
    QFile file(url+"/Results.csv");

    if(file.open(QIODevice::ReadWrite)){
    QTextStream stream(&file);
    stream << text << endl;
    }

    return;

}

FileIO::~FileIO()
{

}

