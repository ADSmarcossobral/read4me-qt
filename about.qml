import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import QtQuick.Controls.Universal 2.2
import Qt.labs.settings 1.0

Page {
    width: 360
    height: 520
    title: "Read4me"

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: Pane{
            id: pane

            Label{
                text: "Sobre nós..."
                anchors.margins: 20
                anchors.top: logo.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: arrow.top
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                wrapMode: Label.Wrap
            }

            // Adicionar aqui botão para biblioteca

        }
    }

}
