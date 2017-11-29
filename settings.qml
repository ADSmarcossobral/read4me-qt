import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
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

            // Configurações aqui

        }
    }


}
