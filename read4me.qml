import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import Qt.labs.settings 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 360
    height: 520
    title: "Read4me"

    Settings {
       id: settings
       property string style: "Universal"
    }

    header:ToolBar{
        Material.foreground: "white"

        RowLayout{
            spacing: 20
            anchors.fill: parent

            ToolButton{
                contentItem: Image{
                    fillMode: Image.pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "qrc:/images/drawer.png"
                }
                onClicked: drawer.open();
            }

            Label{
                id: titlelabel
                text: "Read4me"
                font.pixelSize: 20
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton{
                contentItem: Image{
                    fillMode: Image.pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "qrc:/images/menu.png"
                }
                onClicked: optionsMenu.open()

                Menu{
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    MenuItem{
                        text: "Tema"
                        onTriggered: themePopup.open()
                    }
                    MenuItem{
                        text: "Sobre"
                        onTriggered: aboutDialog.open()
                    }
                }
            }
        }
    }

    Drawer{
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height

        ListView{
            id: listView
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate{
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked: {
                    if(listView.currentIndex != index){
                        listView.currentIndex = index
                        titlelabel.text = model.title
                        stackView.replace(model.source)
                    }
                    drawer.close()
                }
            }

            model: ListModel{
                ListElement{ title: "Início"; source: "qrc:/read4me.qml" }
                ListElement{ title: "Meus Livros"; source: "qrc:/pages/books.qml" }
                ListElement{ title: "Favoritos"; source: "qrc:/pages/favorites.qml" }
                ListElement{ title: "Configurações"; source: "qrc:/pages/settings.qml" }
                ListElement{ title: "Sobre Read4me"; source: "qrc:/pages/about.qml" }

            }

            ScrollIndicator.vertical: ScrollIndicator { }

        }
    }

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: Pane{
            id: pane

            Image{
                id: logo
                width: pane.availableWidth / 2
                height: pane.availableHeight / 2
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -50
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/read4me-logo.png"
            }

            Label{
                text: "Seu aplicativo para ouvir seus livros em PDF."
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

    Popup{
        id: themePopup
        x: (window.width - width) / 2
        y: window.height / 6
        width: Math.min(window.width, window.height) / 3 * 2
        height: themeColumn.implicitHeight + topPadding + bottomPadding
        modal: true
        focus: true

        contentItem: ColumnLayout{
            id: themeColumn
            spacing: 20

            Label{
                text: "Temas"
                font.bold: true
            }

            RowLayout{
                spacing: 10

                Label{
                    text: "Style:"
                }

                ComboBox{
                    id: styleBox
                    property int styleIndex: -1
                    model: ["Padrão", "Material", "Universal"]
                    Component.onCompleted: {
                        styleIndex = find(theme.style, Qt.MatchFixedString)
                        if(styleIndex !== -1)
                            currentIndex = styleIndex
                    }
                    Layout.fillWidth: true
                }
            }

            Label{
                text: "É necessário reiniciar o aplicativo."
                color: "#e41e25"
                opacity: styleBox.currentIndex !== styleBox.styleIndex ? 1.0 : 0.0
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            RowLayout{
                spacing: 10

                Button{
                    text: "Ok"
                    onClicked: {
                        theme.style = styleBox.displayText
                        themePopup.close()
                    }

                    Material.foreground: Material.primary
                    Material.background: "transparent"
                    Material.elevation: 0

                    Layout.preferredWidth: 0
                    Layout.fillWidth: true

                }

                Button {
                    id: cancelButton
                    text: "Cancelar"
                    onClicked: {
                        styleBox.currentIndex = styleBox.styleIndex
                        settingsPopup.close()
                    }

                    Material.background: "transparent"
                    Material.elevation: 0

                    Layout.preferredWidth: 0
                    Layout.fillWidth: true

                }
            }
        }
    }

    Popup {
        id: aboutDialog
        modal: true
        focus: true
        x: (window.width - width) / 2
        y: window.height / 6
        width: Math.min(window.width, window.height) / 3 * 2
        contentHeight: aboutColumn.height

        Column {
            id: aboutColumn
            spacing: 20

            Label {
                text: "About"
                font.bold: true
            }

            Label {
                width: aboutDialog.availableWidth
                text: "Desenvolvido por Marcos Sobral e Caio Jordão."
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }

            Label {
                width: aboutDialog.availableWidth
                text: "Nosso site: www.read4me.com.br"
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
        }
    }
}
