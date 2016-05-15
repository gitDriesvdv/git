#include <QObject>

#ifndef FILEIO_H
#define FILEIO_H


class FileIO : public QObject
{

    Q_OBJECT

public:
    FileIO();
    Q_INVOKABLE void save(QString text);
    ~FileIO();

};

#endif // FILEIO_H
