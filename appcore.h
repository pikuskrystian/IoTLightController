#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>

#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>
#include <QtNetwork/QHttpPart>

#include <QJsonObject>
#include <QJsonArray>
#include <QJsonParseError>

#include <QTimer>

#include <QtDebug>

class AppCore : public QObject
{
    Q_OBJECT
public:
    explicit AppCore(QObject *parent = nullptr);

private:
    void managerFinished(QNetworkReply *reply);

    QNetworkAccessManager *manager;
    QNetworkRequest request;
    QString answer;
    QVector<int> control;
    uint deviceid=0;

public slots:
    void onRequest();
    void onSendValue(int n, int v);
    int getValue(int n);
    QString getInfo();

signals:
    void isDataChanged();
};

#endif // APPCORE_H
