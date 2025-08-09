import QtQuick
import QtQuick.Shapes
import qs.Theme

QtObject {
    component Up: Shape {
        id: root
        width: 60
        height: 15
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            strokeWidth: 0
            fillColor: Theme.blue
            startX: 0
            startY: (1 / 3) * height
            PathLine {
                x: width / 2
                y: 0
            }
            PathLine {
                x: width
                y: (1 / 3) * height
            }
            PathLine {
                x: width
                y: height
            }
            PathLine {
                x: width / 2
                y: (2 / 3) * height
            }
            PathLine {
                x: 0
                y: height
            }
        }
    }
}
