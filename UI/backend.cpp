#include "backend.h"
#include <QDebug>
#include <QList>
#include <QStringList>
#include <QDir>
#include <QDebug>

BackEnd::BackEnd(QObject *parent) : QObject(parent){}
QString BackEnd::newLocation()
{
    return m_newLocation;
}
void BackEnd::setNewLocation(const QString &newLocation)
{
    FILE* fpt;
    if (newLocation == m_newLocation)
        return;
    m_newLocation = newLocation;
    fpt = fopen("data.csv", "a+");
    fprintf(fpt,"%s\n",newLocation.toUtf8().constData());
    fclose(fpt);
    emit newLocationChanged(m_newLocation);
}
void BackEnd::logChange(const QString &newLocation){
    qDebug()<<"New Location:"<<newLocation;
}

void BackEnd::CSVstuff(const QString &newLocation)
{
    FILE* fpt;
    fpt = fopen("data.csv", "r");
    fclose(fpt);


}
