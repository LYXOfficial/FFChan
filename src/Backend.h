#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>

class Backend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString message READ message NOTIFY messageChanged)
public:
    explicit Backend(QObject *parent = nullptr);
    QString message() const;
    Q_INVOKABLE void setMessage(const QString &msg);

signals:
    void messageChanged();

private:
    QString m_message;
};

#endif // BACKEND_H
