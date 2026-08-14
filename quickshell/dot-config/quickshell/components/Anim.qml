import QtQuick
import qs.config

// Standard animation with the Material 3 Expressive motion set baked in.
// Mirrors caelestia's `Anim`, minus the plugin dependency.
//
//     Behavior on x { Anim { type: Anim.Spatial } }
NumberAnimation {
    id: root

    enum Type {
        Small,
        Normal,
        Large,
        FastEffects,
        DefaultEffects,
        SlowEffects,
        Spatial,
        FastSpatial,
        SlowSpatial
    }

    property int type: Anim.DefaultEffects

    duration: {
        const d = Appearance.anim.durations;
        switch (type) {
        case Anim.Small:
            return d.small;
        case Anim.Normal:
            return d.normal;
        case Anim.Large:
            return d.large;
        case Anim.FastEffects:
            return d.fastEffects;
        case Anim.SlowEffects:
            return d.slowEffects;
        case Anim.Spatial:
            return d.defaultSpatial;
        case Anim.FastSpatial:
            return d.fastSpatial;
        case Anim.SlowSpatial:
            return d.slowSpatial;
        default:
            return d.defaultEffects;
        }
    }

    easing.type: Easing.BezierSpline
    easing.bezierCurve: {
        const a = Appearance.anim;
        switch (type) {
        case Anim.Spatial:
        case Anim.SlowSpatial:
            return a.expressiveSpatial;
        case Anim.FastSpatial:
            return a.expressiveFastSpatial;
        case Anim.Large:
            return a.emphasized;
        default:
            return a.expressiveEffects;
        }
    }
}
