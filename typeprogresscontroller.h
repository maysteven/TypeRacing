#ifndef TYPEPROGRESSCONTROLLER_H
#define TYPEPROGRESSCONTROLLER_H

#include <QObject>

class TypeProgressController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString text         READ getText          WRITE setText                        )
    Q_PROPERTY(QString input        READ getInput         WRITE setInput                       )
    Q_PROPERTY(QString progressText READ getProgressText                 NOTIFY progressChanged)
    Q_PROPERTY(QString progress     READ getProgress                     NOTIFY progressChanged)

public:
    explicit TypeProgressController(QString text=QString(), QObject * parent = nullptr);

    void setText (QString t) {reset(); text=t;}
    void setInput(QString i) {input = i; computeProgress();}

    QString getText()         const {return text         ;}
    QString getProgressText() const {return progressText ;}
    double  getProgress()     const {return progress     ;}
    QString getInput()        const {return input        ;}
    QString getGoodColor()    const {return goodColor    ;}
    QString getWrongColor()   const {return wrongColor   ;}


    QString goodColor="green";
    QString wrongColor="grey";

signals:

    void progressTextChanged(QString);
    void progressChanged(double );
public slots:

    void computeProgress();

protected slots:

    void reset(){
        input        = "";
        progressText = "";
        progress     = 0.;
    }

protected:
    void emitProgressChanged();
    static QString coloredText(QString txt,QString color);
    QString input;
    QString text;
    QString progressText;
    double  progress;

};

#endif // TYPEPROGRESSCONTROLLER_H
