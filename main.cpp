#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSettings>
#include <QQuickStyle>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication::setApplicationName("Read4me");
    QGuiApplication app(argc, argv);

    QSettings settings;
    QString style = QQuickStyle::name();
    if(!style.isEmpty())
        settings.setValue("style", style);
    else
        QQuickStyle::setStyle(settings.value("style").toString());

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/read4me.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
