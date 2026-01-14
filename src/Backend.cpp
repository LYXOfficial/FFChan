#include "Backend.h"

Backend::Backend(QObject *parent)
    : QObject(parent), m_message("Hello from C++")
{
}

QString Backend::message() const
{
    return m_message;
}

void Backend::setMessage(const QString &msg)
{
    if (m_message == msg) return;
    m_message = msg;
    emit messageChanged();
}
