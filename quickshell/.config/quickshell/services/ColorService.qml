pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string background
    property string foreground
    property string color0
    property string color1
    property string color2
    property string color3
    property string color4
    property string color5
    property string color6
    property string color7
    property string color8
    property string color9
    property string color10
    property string color11
    property string color12
    property string color13
    property string color14
    property string color15
    FileView {
        id: paletteFile
        path: `${Quickshell.env("HOME")}/.cache/wallust/quickshell.json`
        watchChanges: true
        onLoaded: {
            const data = JSON.parse(text());

            root.background = data.background;
            root.foreground = data.foreground;
            root.color0 = data.color0;
            root.color1 = data.color1;
            root.color2 = data.color2;
            root.color3 = data.color3;
            root.color4 = data.color4;
            root.color5 = data.color5;
            root.color6 = data.color6;
            root.color7 = data.color7;
            root.color8 = data.color8;
            root.color9 = data.color9;
            root.color10 = data.color10;
            root.color11 = data.color11;
            root.color12 = data.color12;
            root.color13 = data.color13;
            root.color14 = data.color14;
            root.color15 = data.color15;
        }
        onFileChanged: reload()
    }
}
