/*
    Copyright 2021 Crimson AS <info@crimson.no>
    Copyright 2011-2012 Heikki Holstila <heikki.holstila@gmail.com>

    This work is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 2 of the License, or
    (at your option) any later version.

    This work is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this work.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <QClipboard>
#include <QDebug>
#include <QFontDatabase>
#include <QFontInfo>
#include <QGuiApplication>
#include <QQuickView>

#include "include/terminal.h"
#include "include/terminal/textrender.h"
#include "include/terminal/utilities.h"
#include "include/terminal/version.h"

#ifdef HAVE_FEEDBACK
#    include <QFeedbackEffect>
#endif

static Util* s_instance;

Util::Util(const QString& settingsFile, QObject* parent)
    : QObject(parent)
    , m_settings(settingsFile, QSettings::IniFormat)
    , iWindow(0)
{
    Q_ASSERT(s_instance == nullptr);
    s_instance = this;
}

Util::~Util()
{
    s_instance = nullptr;
}

Util* Util::instance()
{
    return s_instance;
}

QString Util::panLeftTitle() const
{
    return settingsValue("gestures/panLeftTitle", "Alt-Right").toString();
}

QString Util::panLeftCommand() const
{
    return settingsValue("gestures/panLeftCommand", "\\e\\e[C").toString();
}

QString Util::panRightTitle() const
{
    return settingsValue("gestures/panRightTitle", "Alt-Left").toString();
}

QString Util::panRightCommand() const
{
    return settingsValue("gestures/panRightCommand", "\\e\\e[D").toString();
}

QString Util::panDownTitle() const
{
    return settingsValue("gestures/panDownTitle", "Page Up").toString();
}

QString Util::panDownCommand() const
{
    return settingsValue("gestures/panDownCommand", "\\e[5~").toString();
}

QString Util::panUpTitle() const
{
    return settingsValue("gestures/panUpTitle", "Page Down").toString();
}

QString Util::panUpCommand() const
{
    return settingsValue("gestures/panUpCommand", "\\e[6~").toString();
}

QString Util::startupErrorMessage() const
{
    return m_startupErrorMessage;
}

void Util::setStartupErrorMessage(const QString& message)
{
    Q_ASSERT(m_startupErrorMessage.isNull()); // CONSTANT
    m_startupErrorMessage = message;
}

QByteArray Util::terminalEmulator() const
{
    return m_settings.value("terminal/envVarTERM", "xterm-256color").toByteArray();
}

QString Util::terminalCommand() const
{
    return m_settings.value("general/execCmd").toString();
}

int Util::terminalScrollbackSize() const
{
    return m_settings.value("terminal/scrollbackLineLimit", "3000").toInt();
}

void Util::setWindow(QQuickView* win)
{
    if (iWindow)
        qFatal("Should set window property only once");
    iWindow = win;
    if (!iWindow)
        qFatal("invalid main window");
    connect(win, SIGNAL(contentOrientationChanged(Qt::ScreenOrientation)), this, SIGNAL(windowOrientationChanged()));
    connect(win, SIGNAL(windowTitleChanged(QString)), this, SIGNAL(windowTitleChanged()));
}

void Util::setWindowTitle(QString title)
{
    iWindow->setTitle(title);
    emit windowTitleChanged();
}

QString Util::windowTitle()
{
    return iWindow->title();
}

int Util::windowOrientation()
{
    return iWindow->contentOrientation();
}

void Util::setWindowOrientation(int orientation)
{
    iWindow->reportContentOrientationChange(static_cast<Qt::ScreenOrientation>(orientation));
}

void Util::openNewWindow()
{
    QProcess::startDetached("/usr/bin/literm", QStringList());
}

QString Util::getUserMenuXml()
{
    QString ret;
    QFile f(configPath() + "/menu.xml");
    if (f.open(QIODevice::ReadOnly | QIODevice::Text)) {
        ret = f.readAll();
        f.close();
    }

    return ret;
}

QString Util::configPath()
{
    QFileInfo f(m_settings.fileName());
    return f.path();
}

QVariant Util::settingsValue(QString key, const QVariant& defaultValue) const
{
    return m_settings.value(key, defaultValue);
}

void Util::setSettingsValue(QString key, QVariant value)
{
    m_settings.setValue(key, value);
}

QString Util::versionString()
{
    return PROGRAM_VERSION;
}

int Util::uiFontSize()
{
    return 12;
}

int Util::fontSize()
{
#if defined(Q_OS_MAC)
    return settingsValue("ui/fontSize", 14).toInt();
#endif

    return settingsValue("ui/fontSize", 11).toInt();
}

void Util::setFontSize(int size)
{
    if (size == fontSize()) {
        return;
    }

    setSettingsValue("ui/fontSize", size);
    emit fontSizeChanged();
}

void Util::keyPressFeedback()
{
    if (!settingsValue("ui/keyPressFeedback", true).toBool())
        return;

#ifdef HAVE_FEEDBACK
    QFeedbackEffect::playThemeEffect(QFeedbackEffect::PressWeak);
#endif
}

void Util::keyReleaseFeedback()
{
    if (!settingsValue("ui/keyPressFeedback", true).toBool())
        return;

        // TODO: check what's more comfortable, only press, or press and release
#ifdef HAVE_FEEDBACK
    QFeedbackEffect::playThemeEffect(QFeedbackEffect::ReleaseWeak);
#endif
}

bool Util::visualBellEnabled() const
{
    return settingsValue("general/visualBell", true).toBool();
}

int Util::cursorAnimationStartPauseDuration() const
{
    return settingsValue("cursor/animation/startPauseDuration", 500).toInt();
}

int Util::cursorAnimationFadeInDuration() const
{
    return settingsValue("cursor/animation/fadeInDuration", 0).toInt();
}

int Util::cursorAnimationMiddlePauseDuration() const
{
    return settingsValue("cursor/animation/middlePauseDuration", 500).toInt();
}

int Util::cursorAnimationFadeOutDuration() const
{
    return settingsValue("cursor/animation/fadeOutDuration", 0).toInt();
}

int Util::cursorAnimationEndPauseDuration() const
{
    return settingsValue("cursor/animation/endPauseDuration", 0).toInt();
}

QString Util::fontFamily()
{
    QFont defaultFont(QFontDatabase::systemFont(QFontDatabase::FixedFont));
    QFontInfo fi(defaultFont);
    return settingsValue("ui/fontFamily", fi.family()).toString();
}

TextRender::DragMode Util::dragMode()
{
    QString defaultDragMode("select");
    QString mode = settingsValue("ui/dragMode", defaultDragMode).toString();

    if (mode == "gestures") {
        return TextRender::DragGestures;
    } else if (mode == "scroll") {
        return TextRender::DragScroll;
    } else if (mode == "select") {
        return TextRender::DragSelect;
    } else {
        return TextRender::DragOff;
    }
}

void Util::setDragMode(TextRender::DragMode mode)
{
    if (mode == dragMode()) {
        return;
    }

    QString modeString;
    switch (mode) {
    case TextRender::DragGestures:
        modeString = "gestures";
        break;
    case TextRender::DragScroll:
        modeString = "scroll";
        break;
    case TextRender::DragSelect:
        modeString = "select";
        break;
    case TextRender::DragOff:
    default:
        modeString = "off";
    }

    setSettingsValue("ui/dragMode", modeString);
    emit dragModeChanged();
}

int Util::keyboardMode()
{
    QString mode = settingsValue("ui/vkbShowMethod", "move").toString();

    if (mode == "fade") {
        return KeyboardFade;
    } else if (mode == "move") {
        return KeyboardMove;
    } else {
        return KeyboardOff;
    }
}

void Util::setKeyboardMode(int mode)
{
    if (mode == keyboardMode()) {
        return;
    }

    QString modeString;
    switch (mode) {
    case KeyboardFade:
        modeString = "fade";
        break;
    case KeyboardMove:
        modeString = "move";
        break;
    case KeyboardOff:
    default:
        modeString = "off";
    }

    setSettingsValue("ui/vkbShowMethod", modeString);
    emit keyboardModeChanged();
}

int Util::keyboardFadeOutDelay()
{
    return settingsValue("ui/keyboardFadeOutDelay", 4000).toInt();
}

void Util::setKeyboardFadeOutDelay(int delay)
{
    if (delay == keyboardFadeOutDelay()) {
        return;
    }

    setSettingsValue("ui/keyboardFadeOutDelay", delay);
    emit keyboardFadeOutDelayChanged();
}

QString Util::keyboardLayout()
{
    return settingsValue("ui/keyboardLayout", "english").toString();
}

void Util::setKeyboardLayout(const QString& layout)
{
    if (layout == keyboardLayout()) {
        return;
    }

    setSettingsValue("ui/keyboardLayout", layout);
    emit keyboardLayoutChanged();
}

int Util::extraLinesFromCursor()
{
    return settingsValue("ui/showExtraLinesFromCursor", 1).toInt();
}

QString Util::charset()
{
    return settingsValue("terminal/charset", "UTF-8").toString();
}

int Util::keyboardMargins()
{
    return settingsValue("ui/keyboardMargins", 10).toInt();
}

int Util::orientationMode()
{
    QString mode = settingsValue("ui/orientationLockMode", "auto").toString();

    if (mode == "auto") {
        return OrientationAuto;
    } else if (mode == "landscape") {
        return OrientationLandscape;
    } else {
        return OrientationPortrait;
    }
}

void Util::setOrientationMode(int mode)
{
    if (mode == orientationMode()) {
        return;
    }

    QString modeString;
    switch (mode) {
    case OrientationAuto:
        modeString = "auto";
        break;
    case OrientationLandscape:
        modeString = "landscape";
        break;
    case OrientationPortrait:
    default:
        modeString = "portrait";
    }

    setSettingsValue("ui/orientationLockMode", modeString);
    emit orientationModeChanged();
}

void Util::notifyText(QString text)
{
    emit notify(text);
}

void Util::fakeKeyPress(int key, int modifiers)
{
    QKeyEvent pev(QEvent::KeyPress, key, Qt::KeyboardModifiers(modifiers));
    QCoreApplication::sendEvent(iWindow, &pev);
    QKeyEvent rev(QEvent::KeyRelease, key, Qt::KeyboardModifiers(modifiers));
    QCoreApplication::sendEvent(iWindow, &rev);
}

void Util::copyTextToClipboard(QString str)
{
    QClipboard* cb = QGuiApplication::clipboard();

    cb->clear();
    cb->setText(str);
}
