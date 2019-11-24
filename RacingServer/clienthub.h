#ifndef CLIENTHUB_H
#define CLIENTHUB_H

#include <QObject>

class ClientHub : public QObject
{
    Q_OBJECT
public:
    explicit ClientHub(QObject *parent = nullptr);

signals:

public slots:
};

#endif // CLIENTHUB_H