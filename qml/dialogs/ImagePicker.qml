/*

Hanghish
Copyright (C) 2015 Daniele Rogora

This file is part of Hangish.

Hangish is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Hangish is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Nome-Programma.  If not, see <http://www.gnu.org/licenses/>

*/


import QtQuick 2.8
import QtQuick.Controls 2.3
import ".."

//Thanks to mitakuuluu for this page


GridView {
    id: view
    clip: true

    cellWidth: page.isPortrait ? (page.width / 4) : (page.width / 8)
    cellHeight: cellWidth
    cacheBuffer: cellHeight * 2

    model: fileModel

    delegate: Item {
        width: view.cellWidth - 1
        height: view.cellHeight - 1

        Image {
            id: image
            source: model.path
            height: parent.height
            width: parent.width
            sourceSize.height: parent.height
            anchors.centerIn: parent
            fillMode: Image.PreserveAspectCrop
            clip: true
            smooth: true
            cache: true
            asynchronous: true

            states: [
                State {
                    name: 'loaded'
                    when: image.status == Image.Ready
                    PropertyChanges {
                        target: image
                        opacity: 1
                    }
                },
                State {
                    name: 'loading'
                    when: image.status != Image.Ready
                    PropertyChanges {
                        target: image
                        opacity: 0
                    }
                }
            ]

            Behavior on opacity {
                NumberAnimation { duration: 100 }
            }
        }

        Rectangle {
            anchors.fill: parent
            color: palette.highlight
            visible: model.path === page.selectedPath
            opacity: 0.5
        }

        Rectangle {
            id: rec
            color: Theme.secondaryHighlightColor
            height: Theme.fontSizeExtraSmall
            width: parent.width
            anchors.bottom: parent.bottom
            opacity: mArea.pressed ? 1.0 : 0.6
        }

        Label {
            anchors.fill: rec
            anchors.margins: 3
            //height: 26
            font.pointSize: Theme.fontSizeExtraSmall
            text: model.name
            wrapMode: Text.NoWrap
            elide: Text.ElideRight
            horizontalAlignment : Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        MouseArea {
            id: mArea
            anchors.fill: parent
            onClicked: {
                if (page.selectedPath === model.path) {
                    page.selectedPath = ""
                    page.selectedRotation = 0
                }
                else {
                    page.selectedPath = model.path
                    page.selectedRotation = image.rotation
                }
            }
        }
    }
}
