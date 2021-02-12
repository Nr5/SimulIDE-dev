/***************************************************************************
 *   Copyright (C) 2012 by santiago González                               *
 *   santigoro@gmail.com                                                   *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 3 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, see <http://www.gnu.org/licenses/>.  *
 *                                                                         *
 ***************************************************************************/

#ifndef ESOURCE_H
#define ESOURCE_H

#include <QColor>

#include "e-element.h"
#include "e-node.h"

enum pinMode_t{
    source=0,
    input,
    output,
    output_open,
    undefined
};

class MAINMODULE_EXPORT eSource : public eElement
{
    public:
        eSource( QString id, ePin* epin, pinMode_t mode=source );
        virtual ~eSource();

        virtual void initialize() override;
        
        void stamp() override;
        void stampOutput();

        pinMode_t pinMode() { return m_pinMode; }
        void setPinMode( pinMode_t mode );

        double voltHight() { return m_voltHigh; }
        void  setVoltHigh( double v );

        double voltLow() { return m_voltLow; }
        void  setVoltLow( double v );
        
        bool getState() { return m_state ; }
        void setState( bool out, bool st=false );
        void setStateZ( bool z );

        bool  isInverted() { return m_inverted; }
        void  setInverted( bool inverted );

        virtual void  setInputImp( double imp ){ m_inputImp = imp; setImp( imp );}
        virtual void  setOutputImp( double imp ){ m_outputImp = imp; setImp( imp ); }

        double imp() { return m_imp; }
        virtual void  setImp( double imp );

        double getVolt();

        ePin* getPin() { return m_ePin[0]; }

    protected:
        double m_voltHigh;
        double m_voltLow;
        double m_voltOut;

        double m_inputImp;
        double m_outputImp;
        double m_openImp;
        double m_imp;
        double m_admit;

        bool m_state;
        bool m_stateZ;
        bool m_inverted;

        pinMode_t m_pinMode;

        eNode* m_scrEnode;
};
#endif

