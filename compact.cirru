
{} (:package |app)
  :configs $ {} (:init-fn |app.main/main!) (:reload-fn |app.main/reload!) (:version |0.0.4)
    :modules $ [] |touch-control/ |pointed-prompt/ |quatrefoil/ |respo.calcit/ |respo-ui.calcit/ |alerts.calcit/ |memof/ |lilac/ |respo-markdown.calcit/
  :entries $ {}
  :files $ {}
    |app.comp.container $ {}
      :defs $ {}
        |calc-unit-x-axis $ quote
          defn calc-unit-x-axis (p)
            let[] (a b c) p $ v-scale
              [] (negate c) 0 a
              / 1 $ sqrt (sum-squares a c)
        |calc-unit-y-axis $ quote
          defn calc-unit-y-axis (p)
            let[] (a b c) p $ v-scale
              [] (* -1 a b) (sum-squares a c) (* -1 b c)
              / 1 $ sqrt
                sum-squares (* a b) (sum-squares a c) (* b c)
        |comp-axis $ quote
          defn comp-axis () $ line-segments
            {}
              :segments $ []
                [][] (-100 0 0) (100 0 0)
                [][] (0 -100 0) (0 100 0)
                [][] (0 0 -100) (0 0 100)
              :material style-line
        |comp-container $ quote
          defcomp comp-container (store)
            let
                states $ :states store
                cursor $ :cursor states
                state $ either (:data states)
                  {} $ :tab :portal
                tab $ :tab state
                look-distance $ [] 20 30 -60
                screen-x $ wo-log (calc-unit-x-axis look-distance)
                screen-y $ wo-log (calc-unit-y-axis look-distance)
                s $ noted "\"cone back scale" 0.5
                targets $ [][] (80 70 -90) (; 50 90 -70)
                projections $ map targets
                  fn (p) (transform-3d p look-distance s)
              scene ({})
                ambient-light $ {} (:color 0x666666)
                comp-axis
                noted "\"look direction" $ line
                  {}
                    :points $ [] (v-scale look-distance 5)
                      v-scale look-distance $ negate s
                    :material $ assoc style-line :color 0xaaaaee
                noted "\"look point" $ group ({})
                  sphere $ {} (:radius 1) (:position look-distance)
                    :material $ assoc style-point :color 0xffffaa
                  text $ {} (:text |C) (:size 0.8) (:height 0.5)
                    :material $ assoc style-point :color 0xffffaa
                    :position $ v+ look-distance ([] 1 0 1)
                group ({}) & $ map-indexed projections
                  fn (idx pro) (comp-point-explain idx pro look-distance screen-x screen-y s)
                comp-grid look-distance screen-x screen-y
                group ({})
                  sphere $ {} (:radius 1) (:material style-point)
                  text $ {} (:text |O) (:material style-point) (:size 0.8) (:height 0.5)
                    :position $ [] 1 0 1
                if (not= s 0)
                  group ({})
                    sphere $ {} (:radius 1) (:material style-point)
                      :position $ v-scale look-distance (negate s)
                    text $ {} (:text |S) (:material style-point) (:size 0.8) (:height 0.5)
                      :position $ v+
                        v-scale look-distance $ negate s
                        [] -1 -2 0
                point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                  :position $ [] 20 40 50
                ; point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 200)
                  :position $ [] 0 60 0
        |comp-demo $ quote
          defcomp comp-demo () $ group ({})
            box $ {} (:width 16) (:height 4) (:depth 6)
              :position $ [] -40 0 0
              :material $ {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.6)
              :event $ {}
                :click $ fn (e d!) (d! :demo nil)
            sphere $ {} (:radius 8)
              :position $ [] 10 0 0
              :material $ {} (:kind :mesh-lambert) (:opacity 0.6) (:color 0x9050c0)
              :event $ {}
                :click $ fn (e d!) (d! :canvas nil)
            group ({})
              text $ {} (:text |Quatrefoil) (:size 4) (:height 2)
                :position $ [] -30 0 20
                :material $ {} (:kind :mesh-lambert) (:color 0xffcccc)
            sphere $ {} (:radius 4) (:emissive 0xffffff) (:metalness 0.8) (:color 0x00ff00) (:emissiveIntensity 1) (:roughness 0)
              :position $ [] -10 20 0
              :material $ {} (:kind :mesh-basic) (:color 0xffff55) (:opacity 0.8) (:transparent true)
              :event $ {}
                :click $ fn (e d!) (d! :canvas nil)
            point-light $ {} (:color 0xffff55) (:intensity 2) (:distance 200)
              :position $ [] -10 20 0
        |comp-grid $ quote
          defn comp-grid (look-distance screen-x screen-y)
            let
                gap 20
              group ({})
                line-segments $ {} (:position look-distance)
                  :segments $ concat
                    map (range -5 6)
                      fn (i)
                        []
                          v+
                            v-scale screen-x $ * 5 gap
                            v-scale screen-y $ * 20 i
                          v+
                            v-scale screen-x $ * -5 gap
                            v-scale screen-y $ * 20 i
                    map (range -5 6)
                      fn (i)
                        []
                          v+
                            v-scale screen-y $ * 5 gap
                            v-scale screen-x $ * 20 i
                          v+
                            v-scale screen-y $ * -5 gap
                            v-scale screen-x $ * 20 i
                  :material $ {} (:kind :line-basic) (:color 0x6677aa) (:opacity 0.4) (:transparent true)
                line-segments $ {} (:position look-distance)
                  :segments $ []
                    []
                      v+ (v-scale screen-y -18) (v-scale screen-x 32)
                      v+ (v-scale screen-y 18) (v-scale screen-x 32)
                    []
                      v+ (v-scale screen-y -18) (v-scale screen-x -32)
                      v+ (v-scale screen-y 18) (v-scale screen-x -32)
                    []
                      v+ (v-scale screen-y -18) (v-scale screen-x 32)
                      v+ (v-scale screen-y -18) (v-scale screen-x -32)
                    []
                      v+ (v-scale screen-y 18) (v-scale screen-x 32)
                      v+ (v-scale screen-y 18) (v-scale screen-x -32)
                  :material $ {} (:kind :line-basic) (:color 0xaaaa88) (:opacity 0.9) (:transparent true)
        |comp-point-explain $ quote
          defn comp-point-explain (idx pro look-distance screen-x screen-y s)
            let
                point-on-screen $ let[] (x y) (:shadow pro)
                  v+ look-distance $ v+ (v-scale screen-x x) (v-scale screen-y y)
                screen-near $ v+ look-distance
                  v-scale screen-x $ :x pro
              group ({})
                sphere $ {} (:radius 1)
                  :material $ assoc style-point :color 0xffffff
                  :position $ :p0 pro
                text $ {} (:material style-point) (:size 1.2) (:height 0.5)
                  :text $ point-label "\"P " idx
                  :position $ v+ (:p0 pro) ([] 2 0 1)
                line $ {}
                  :points $ [] (:p0 pro)
                    v-scale look-distance $ negate s
                  :material $ assoc style-line :color 0xeeaaff
                group ({})
                  sphere $ {} (:radius 2) (:material style-point) (:position point-on-screen)
                  text $ {} (:material style-point) (:size 1.2) (:height 0.5)
                    :text $ point-label "\"P' " idx
                    :position $ v+ point-on-screen ([] 2 0 1)
                  line $ {}
                    :points $ [] point-on-screen look-distance
                    :material $ assoc style-line :color 0x555533
                  line $ {}
                    :points $ [] (:p0 pro)
                      v-scale look-distance $ :scale pro
                    :material $ assoc style-line :color 0x555533
                  sphere $ {} (:radius 1) (:material style-point)
                    :position $ v-scale look-distance (:scale pro)
                  text $ {} (:material style-point) (:size 1.2) (:height 0.5)
                    :text $ point-label "\"Q " idx
                    :position $ v+
                      v-scale look-distance $ :scale pro
                      [] 2 0 1
                group ({})
                  mesh-line $ {}
                    :points $ [] look-distance screen-near
                    :material style-bold-line
                  sphere $ {} (:radius 1) (:material style-point) (:position screen-near)
                  text $ {} (:material style-point) (:size 0.8) (:height 0.5)
                    :text $ point-label "\"B " idx
                    :position $ v+ screen-near ([] 1 0 1)
                  mesh-line $ {}
                    :points $ [] point-on-screen screen-near
                    :material style-bold-line
        |point-label $ quote
          defn point-label (t idx)
            if (> idx 0) (str t "\" " idx) t
        |square $ quote
          defn square (x) (pow x 2)
        |style-bold-line $ quote
          def style-bold-line $ {} (:kind :mesh-line) (:color 0xaaaaff) (:transparent true) (:opacity 0.6) (:depthTest true) (:lineWidth 0.3)
        |style-line $ quote
          def style-line $ {} (:kind :line-basic) (:color 0x5555aa) (:opacity 0.9) (:transparent true)
        |style-point $ quote
          def style-point $ {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.9)
        |sum-squares $ quote
          defn sum-squares (& xs)
            -> xs (map square) (reduce 0 &+)
        |transform-3d $ quote
          defn transform-3d (point look-distance s)
            let-sugar
                  [] x y z
                  , point
                ([] a b c) look-distance
                b $ nth look-distance 1
                c $ nth look-distance 2
                r $ /
                  + (* a x) (* b y) (* c z)
                  + (square a) (square b) (square c)
                q $ / (+ s 1) (+ r s)
                L1 $ sqrt
                  + (* a a b b)
                    square $ sum-squares a c
                    * b b c c
                y' $ *
                  /
                    + (* q y) (* b q s) (* -1 b s) (* -1 b)
                    sum-squares a c
                  , L1
                x' $ *
                  /
                    -
                      + (* q x) (* a q s) (* -1 s a) (* -1 a)
                      * y' $ / (* -1 a b) L1
                    , c -1
                  sqrt $ sum-squares a c
                z' $ negate r
              {} (:p0 point) (:scale r)
                :shadow $ [] x' y' z'
                :x x'
                :y y'
      :ns $ quote
        ns app.comp.container $ :require
          quatrefoil.alias :refer $ group box sphere point-light ambient-light perspective-camera scene text line line-segments mesh-line
          quatrefoil.core :refer $ defcomp >>
          quatrefoil.math :refer $ v-scale v+ v-
    |app.comp.nav $ {}
      :defs $ {}
        |comp-nav $ quote
          defcomp comp-nav (store states)
            let
                cursor $ :cursor states
                state $ or (:data states)
                  {} $ :menu? false
              div
                {} $ :class-name css-nav
                a $ {} (:inner-text "\"Menu") (:class-name css/link)
                  :on-click $ fn (e d!)
                    d! cursor $ update state :menu? not
                if (:menu? state)
                  div
                    {} $ :class-name css-pop-menu
                    =< nil 24
                    comp-md-block (load-content "\"explain.md") ({})
                    =< nil 120
        |css-nav $ quote
          defstyle css-nav $ {}
            "\"$0" $ merge ui/global
              {} (:color :white) (:position :absolute) (:top 0) (:left 0)
        |css-pop-menu $ quote
          defstyle css-pop-menu $ {}
            "\"$0" $ {} (:max-height "\"90vh") (:border-radius "\"6px") (:padding "\"8px 8px") (:z-index 900) (:position :fixed) (:left 8) (:top 32) (:overflow :auto)
              :color $ hsl 0 0 30
              :background-color $ hsl 0 0 100 0.9
        |load-content $ quote
          defmacro load-content (file)
            read-file $ str "\"docs/" file
      :ns $ quote
        ns app.comp.nav $ :require (respo-ui.core :as ui)
          respo-ui.core :refer $ hsl
          respo.core :refer $ defcomp defeffect <> >> div button textarea span input a list->
          respo.css :refer $ defstyle
          respo.comp.space :refer $ =<
          app.config :refer $ dev? api-host
          app.widget :as widget
          respo-alerts.core :refer $ use-prompt use-modal
          app.comp.key-event :refer $ comp-key-event
          app.fetch :refer $ load-files!
          app.comp.stack :refer $ comp-stack
          app.style :refer $ css-hover-entry
          app.comp.command :refer $ comp-command on-save run-command
          memof.once :refer $ memof1-call
          respo-ui.css :as css
          respo-md.comp.md :refer $ comp-md-block
    |app.config $ {}
      :defs $ {}
        |dev? $ quote
          def dev? $ = "\"dev" (get-env "\"mode" "\"release")
      :ns $ quote (ns app.config)
    |app.main $ {}
      :defs $ {}
        |*store $ quote
          defatom *store $ {}
            :states $ {}
              :cursor $ []
        |dispatch! $ quote
          defn dispatch! (op op-data)
            if (list? op)
              recur :states $ [] op op-data
              let
                  store $ updater @*store op op-data
                ; js/console.log |Dispatch: op op-data store
                reset! *store store
        |main! $ quote
          defn main! ()
            when dev? (load-console-formatter!) (println "\"Run in dev mode")
            set-perspective-camera! $ {} (:fov 45)
              :aspect $ / js/window.innerWidth js/window.innerHeight
              :near 0.1
              :far 1000
              :position $ [] 0 0 100
            inject-tree-methods
            let
                canvas-el $ js/document.querySelector |canvas
              init-renderer! canvas-el $ {} (:background 0x110022)
            render-app!
            add-watch *store :changes $ fn (store prev) (render-app!)
            set! js/window.onkeydown handle-key-event
            render-control!
            handle-control-events
            println "|App started!"
        |mount-target $ quote
          def mount-target $ js/document.querySelector "\".page"
        |reload! $ quote
          defn reload! () $ if (some? build-errors) (hud! "\"error" build-errors)
            do (hud! "\"ok~" nil) (clear-cache!) (clear-control-loop!) (handle-control-events) (respo/clear-cache!) (remove-watch *store :changes)
              add-watch *store :changes $ fn (store prev) (render-app!)
              render-app!
              set! js/window.onkeydown handle-key-event
              println "|Code updated."
        |render-app! $ quote
          defn render-app! () (; println "|Render app:")
            render-canvas! (comp-container @*store) dispatch!
            respo/render! mount-target
              comp-nav @*store $ >> (:states @*store) :dom
              , dispatch!
      :ns $ quote
        ns app.main $ :require
          "\"@quatrefoil/utils" :refer $ inject-tree-methods
          quatrefoil.core :refer $ render-canvas! *global-tree clear-cache! init-renderer! handle-key-event handle-control-events
          app.comp.container :refer $ comp-container
          app.updater :refer $ [] updater
          "\"three" :as THREE
          touch-control.core :refer $ render-control! control-states start-control-loop! clear-control-loop!
          "\"bottom-tip" :default hud!
          "\"./calcit.build-errors" :default build-errors
          app.config :refer $ dev?
          quatrefoil.dsl.object3d-dom :refer $ set-perspective-camera!
          respo.core :as respo
          respo.core :refer $ defcomp defeffect <> >> div button textarea span input
          app.comp.nav :refer $ comp-nav
    |app.updater $ {}
      :defs $ {}
        |updater $ quote
          defn updater (store op op-data)
            case-default op store $ :states (update-states store op-data)
      :ns $ quote
        ns app.updater $ :require
          quatrefoil.cursor :refer $ update-states
