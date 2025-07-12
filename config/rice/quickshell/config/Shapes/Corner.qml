import QtQuick
import QtQuick.Shapes
import "root:Theme"

QtObject {
    component BottomLeft: Shape {
        id: root
        property int radius: 20
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            strokeWidth: 0
            fillColor: Theme.bg
            startX: root.radius
            startY: root.radius
            PathArc {
                radiusX: root.radius
                radiusY: root.radius
                x: 0
                y: 0
            }
            PathLine {
                x: 0
                y: root.radius
            }
        }
    }
    component BottomRight: Shape {
        id: root
        property int radius: 20
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            strokeWidth: 0
            fillColor: Theme.bg
            startX: root.radius
            startY: 0
            PathArc {
                radiusX: root.radius
                radiusY: root.radius
                x: 0
                y: root.radius
            }
            PathLine {
                x: root.radius
                y: root.radius
            }
        }
    }
    component TopLeft: Shape {
        id: root
        property int radius: 20
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            strokeWidth: 0
            fillColor: Theme.bg
            startX: 0
            startY: root.radius
            PathArc {
                radiusX: root.radius
                radiusY: root.radius
                x: root.radius
                y: 0
            }
            PathLine {
                x: 0
                y: 0
            }
        }
    }
    component TopRight: Shape {
        id: root
        property int radius: 20
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            strokeWidth: 0
            fillColor: Theme.bg
            startX: 0
            startY: 0
            PathArc {
                radiusX: root.radius
                radiusY: root.radius
                x: root.radius
                y: root.radius
            }
            PathLine {
                x: root.radius
                y: 0
            }
        }
    }
}
