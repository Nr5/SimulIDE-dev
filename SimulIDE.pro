
VERSION = "1.0.1"
RELEASE = ""

TEMPLATE = app
TARGET = simulide

QT += svg
QT += xml
QT += script
QT += widgets
QT += concurrent
QT += serialport
QT += multimedia widgets

SOURCES      = $$files( $$PWD/src/*.cpp, true )
HEADERS      = $$files( $$PWD/src/*.h, true )
TRANSLATIONS = $$files( $$PWD/resources/translations/*.ts )
FORMS       += $$files( $$PWD/src/*.ui, true )
RESOURCES    = ../src/application.qrc

INCLUDEPATH += ../src \
    ../src/gui \
    ../src/gui/circuitwidget \
    ../src/gui/circuitwidget/components \
    ../src/gui/circuitwidget/components/active \
    ../src/gui/circuitwidget/components/logic \
    ../src/gui/circuitwidget/components/mcu \
    ../src/gui/circuitwidget/components/meters \
    ../src/gui/circuitwidget/components/other \
    ../src/gui/circuitwidget/components/outputs \
    ../src/gui/circuitwidget/components/outputs/displays \
    ../src/gui/circuitwidget/components/outputs/leds \
    ../src/gui/circuitwidget/components/outputs/motors \
    ../src/gui/circuitwidget/components/passive \
    ../src/gui/circuitwidget/components/passive/reactive \
    ../src/gui/circuitwidget/components/passive/resistors \
    ../src/gui/circuitwidget/components/passive/resist_sensors \
    ../src/gui/circuitwidget/components/sources \
    ../src/gui/circuitwidget/components/switches \
    ../src/gui/circuitwidget/properties \
    ../src/gui/circuitwidget/subcircuits \
    ../src/gui/dataplotwidget \
    ../src/gui/serial \
    ../src/gui/componentselector \
    ../src/gui/filebrowser \
    ../src/gui/editorwidget \
    ../src/gui/editorwidget/dialogs \
    ../src/gui/editorwidget/debuggers \
    ../src/gui/dialogs \
    ../src/gui/memory \
    ../src/simulator \
    ../src/simulator/elements \
    ../src/simulator/elements/active \
    ../src/simulator/elements/outputs \
    ../src/simulator/elements/passive \
    ../src/mcusim \
    ../src/mcusim/cores \
    ../src/mcusim/cores/avr \
    ../src/mcusim/cores/i51 \
    ../src/mcusim/cores/pic \
    ../src/mcusim/cores/mcs65 \
    ../src/mcusim/cores/scripted \
    ../src/mcusim/cores/intmem \
    ../src/mcusim/modules \
    ../src/mcusim/modules/memory \
    ../src/mcusim/modules/usart \
    ../src/mcusim/modules/twi \
    ../src/mcusim/modules/spi

QMAKE_CXXFLAGS += -Wno-unused-parameter
QMAKE_CXXFLAGS += -Wno-implicit-fallthrough
QMAKE_CXXFLAGS -= -fPIC
QMAKE_CXXFLAGS += -fno-pic
QMAKE_CXXFLAGS += -Ofast
QMAKE_CXXFLAGS_DEBUG -= -O
QMAKE_CXXFLAGS_DEBUG -= -O1
QMAKE_CXXFLAGS_DEBUG -= -O2
QMAKE_CXXFLAGS_DEBUG -= -O3
QMAKE_CXXFLAGS_DEBUG += -O0

win32 {
    OS = Windows
    QMAKE_LIBS += -lwsock32
    RC_ICONS += ../src/icons/simulide.ico
}
linux {
    OS = Linux
    QMAKE_LFLAGS += -no-pie
}
macx {
    OS = MacOs
    QMAKE_LFLAGS += -no-pie
    ICON = ../src/icons/simulide.icns
}

CONFIG += qt 
CONFIG += warn_on
CONFIG += no_qml_debug
CONFIG *= c++11

REV_NO = $$system( bzr revno )
DEFINES += REVNO=\\\"$$REV_NO\\\"

DEFINES += MAINMODULE_EXPORT=
DEFINES += APP_VERSION=\\\"$$VERSION$$RELEASE\\\"

BUILD_DATE = $$system(date +\"\\\"%d-%m-%y\\\"\")
DEFINES += BUILDDATE=\\\"$$BUILD_DATE\\\"


TARGET_NAME   = SimulIDE_$$VERSION$$RELEASE
TARGET_PREFIX = $$BUILD_DIR/executables/$$TARGET_NAME

OBJECTS_DIR *= $$OUT_PWD/build/objects
MOC_DIR     *= $$OUT_PWD/build/moc
INCLUDEPATH += $$MOC_DIR

win32 | linux {
    DESTDIR = $$TARGET_PREFIX
    mkpath( $$TARGET_PREFIX/data )
    mkpath( $$TARGET_PREFIX/examples )
    copy2dest.commands = \
        $(COPY_DIR) ../resources/data     $$TARGET_PREFIX; \
        $(COPY_DIR) ../resources/examples $$TARGET_PREFIX; \
}
macx {
QMAKE_CC = /usr/local/Cellar/gcc@7/7.5.0_4/bin/gcc-7
QMAKE_CXX = /usr/local/Cellar/gcc@7/7.5.0_4/bin/g++-7
QMAKE_LINK = /usr/local/Cellar/gcc@7/7.5.0_4/bin/g++-7

    QMAKE_CXXFLAGS -= -stdlib=libc++
    QMAKE_LFLAGS   -= -stdlib=libc++
    DESTDIR = $$TARGET_PREFIX
    mkpath( $$TARGET_PREFIX/simulide.app )
    mkpath( $$TARGET_PREFIX/simulide.app/Contents/MacOs/data )
    mkpath( $$TARGET_PREFIX/simulide.app/Contents/MacOs/examples )
    copy2dest.commands = \
        $(COPY_DIR) ../resources/data     $$TARGET_PREFIX/simulide.app/Contents/MacOs; \
        $(COPY_DIR) ../resources/examples $$TARGET_PREFIX/simulide.app/Contents/MacOs;
}

runLrelease.commands = lrelease ../resources/translations/*.ts;
QMAKE_EXTRA_TARGETS += runLrelease
QMAKE_EXTRA_TARGETS += copy2dest
PRE_TARGETDEPS      += runLrelease
POST_TARGETDEPS     += copy2dest

message( "-----------------------------------")
message( "    "                               )
message( "    "$$TARGET_NAME for $$OS         )
message( "    "                               )
message( "          Qt version: "$$QT_VERSION )
message( "    "                               )
message( "    Destination Folder:"            )
message( $$TARGET_PREFIX                      )
message( "-----------------------------------")

