import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

Page{
    StackView{
        Button{
            id:addBook
            text: "Adicionar Livro"
            onClicked: popAddBook.open()
        }
    }
    Popup{
        id: popAddBook
        modal: true
        focus: true

        contentItem: ColumnLayout{
            id: theme
            spacing: 20

            Label{
                text: "Adicionar Livro"
                font.bold: true
            }

            RowLayout{
                Label{
                    text: "Descrição:"
                }

            }
        }
    }
}
