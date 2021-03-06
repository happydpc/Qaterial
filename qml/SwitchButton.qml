/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

import Qaterial 1.0

T.Switch
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding + implicitIndicatorWidth)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    horizontalPadding: Style.switchButton.horizontalPadding
    verticalPadding: Style.switchButton.verticalPadding
    spacing: Style.switchButton.spacing
    focusPolicy: Qt.StrongFocus

    property bool onPrimary: false
    property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary

    property bool drawline: Style.debug.drawDebugButton

    property alias elide: _label.elide
    property alias textType: _label.textType

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    }

    indicator: SwitchIndicator
    {
        x: text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        control: control

        Ripple
        {
            x: parent.handle.x + parent.handle.width / 2 - width / 2
            y: parent.handle.y + parent.handle.height / 2 - height / 2
            width: Style.switchButton.rippleWidth
            height: Style.switchButton.rippleWidth
            pressed: control.pressed
            active: control.down || control.visualFocus || control.hovered
            color: Style.rippleColor(control.checked ? Style.RippleBackground.AccentLight : Style.RippleBackground.Background)
        } // Ripple


        DebugRectangle
        {
            anchors.fill: parent
            border.color: "red"
            visible: control.drawline
        } // DebugRectangle
    } // SwitchIndicator

    contentItem: Label
    {
        id: _label
        leftPadding: (text && control.indicator && !control.mirrored) ? control.indicator.width + control.spacing : 0
        rightPadding: (text && control.indicator && control.mirrored) ? control.indicator.width + control.spacing : 0

        onPrimary: control.onPrimary
        colorReversed: control.colorReversed

        text: control.text
        enabled: control.enabled
        elide: !control.mirrored ? Text.ElideRight : Text.ElideLeft
        verticalAlignment: Text.AlignVCenter

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "green"
            visible: control.drawline
        } // DebugRectangle
    } // Label
} // Switch
