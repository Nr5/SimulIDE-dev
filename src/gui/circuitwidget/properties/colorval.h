/***************************************************************************
 *   Copyright (C) 2021 by Santiago González                               *
 *                                                                         *
 ***( see copyright.txt file at root folder )*******************************/

#ifndef COLORVAL_H
#define COLORVAL_H

#include "ui_colorval.h"
#include "propval.h"

class Component;
class PropDialog;

class ColorVal : public PropVal, private Ui::ColorVal
{
    Q_OBJECT
    
    public:
        ColorVal( PropDialog* parent, CompBase* comp, ComProperty* prop );
        ~ColorVal();

        virtual void setup( bool ) override;
        virtual void updtValues() override;

    public slots:
        void on_valueBox_activated( int index );

    private:
        QColor m_color;

        bool m_blocked;
};

#endif
