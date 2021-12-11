#ifndef BACKEND_H
#define BACKEND_H
#include <QObject>
#include <QString>

class BackEnd : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString newLocation READ newLocation WRITE setNewLocation NOTIFY newLocationChanged)
public:
    explicit BackEnd(QObject *parent = nullptr);
    QString newLocation();
    Q_INVOKABLE void setNewLocation(const QString &newLocation);
signals:
    void newLocationChanged(const QString &newLocation);

public slots:
    void logChange(const QString &newLocation);
    void CSVstuff(const QString &newLocation);

private:
    QString m_newLocation;
};
#endif // BACKEND_H
