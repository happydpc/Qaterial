/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0

Rectangle
{
    id: control

    property alias text: _text.text
    property alias overlineText: _overline.text
    property alias secondaryText: _info.text

    property bool alignTextRight: false
    property bool drawline: false
    property bool enabled: true
    property bool mirrored: false

    property double padding
    property double leftPadding: padding
    property double rightPadding: padding
    property double topPadding: padding
    property double bottomPadding: padding

    property bool onPrimary: false
    property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary

    readonly property int lines: (secondaryText != "" ? _info.lineCount : 0) + 1
    property int elide: mirrored ? Text.ElideLeft : Text.ElideRight
    property int textAligment: mirrored ? alignTextRight ? Text.AlignLeft : Text.AlignRight : alignTextRight ? Text.AlignRight : Text.AlignLeft

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "red"
        visible: control.drawline
    } // DebugRectangle

    // Style.DelegateType.Default | Style.DelegateType.Overline | Style.DelegateType.Icon
    // Style.DelegateType.Round | Style.DelegateType.Square | Style.DelegateType.Large
    property int type: Style.DelegateType.Default

    color: "transparent"
    implicitHeight: _info.visible ? (_info.y + _info.implicitHeight) : (_text.implicitHeight)
    //implicitWidth: 180
    implicitWidth: Math.max(_overline.implicitWidth, _text.implicitWidth, _info.implicitWidth)

    function reanchors()
    {
        _text.reanchors()
    }

    onMirroredChanged: Qt.callLater(reanchors)
    onTypeChanged: Qt.callLater(reanchors)
    onLinesChanged: Qt.callLater(reanchors)
    Component.onCompleted: reanchors()

    Label
    {
        id: _overline
        visible : text != ""
        enabled: control.enabled
        textType: Style.TextType.Overline
        elide: control.elide
        onPrimary: control.onPrimary
        colorReversed: control.colorReversed

        horizontalAlignment: control.textAligment

        anchors.baseline: control.top
        anchors.baselineOffset: Style.delegate.baselineOffsetOverline(control.lines)
        anchors.left: control.left
        anchors.right: control.right
        anchors.leftMargin: control.leftPadding
        anchors.rightMargin: control.rightPadding

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "orange"
            visible: control.drawline
        } // DebugRectangle
    } // Label

    Label
    {
        id: _text
        visible : text != ""
        enabled: control.enabled
        textType: Style.TextType.ListText
        elide: control.elide
        onPrimary: control.onPrimary
        colorReversed: control.colorReversed

        horizontalAlignment: control.textAligment

        readonly property bool centerBaseline: control.secondaryText != "" || control.overlineText != ""

        anchors.verticalCenter: control.verticalCenter
        anchors.baselineOffset: centerBaseline ? Style.delegate.baselineOffsetText(control.type, control.lines) : 0
        anchors.left: control.left
        anchors.right: control.right
        anchors.leftMargin: control.leftPadding
        anchors.rightMargin: control.rightPadding

        function reanchors()
        {
            anchors.baseline = undefined
            anchors.verticalCenter = undefined

            if(centerBaseline)
                anchors.baseline = control.top
            else
                anchors.verticalCenter = control.verticalCenter
        }

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "orange"
            visible: control.drawline
        } // DebugRectangle
    } // Label

    Label
    {
        id: _info
        visible : text != ""
        enabled: control.enabled
        textType: Style.TextType.ListSecText
        elide: control.elide
        maximumLineCount: 2
        onPrimary: control.onPrimary
        colorReversed: control.colorReversed

        wrapMode: Text.WordWrap
        horizontalAlignment: control.textAligment

        anchors.baseline: control.top
        anchors.baselineOffset: Style.delegate.baselineOffsetSecText(control.type, lineCount + 1)

        anchors.left: control.left
        anchors.right: control.right
        anchors.leftMargin: control.leftPadding
        anchors.rightMargin: control.rightPadding

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "orange"
            visible: control.drawline
        } // DebugRectangle
    } // Label

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "red"
        visible: control.drawline
    } // DebugRectangle
} // Rectangle
