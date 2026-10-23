
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :js) (:reload-fn 'app.main/reload!) (:target :browser)
      :feature-policy $ {}
      :modules $ [] |touch-control/ |pointed-prompt/ |quatrefoil/ |respo.calcit/ |respo-ui.calcit/ |respo-markdown.calcit/ |quaternion/ |js-ffi/
      :type-slots $ {}
  :files $ {}
    'app.comp.container $ %{} 'FileEntry
      :defs $ {}
        'Projection $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defstruct Projection (:p0 'quaternion.vector/V3) (:scale 'Number) (:shadow 'quaternion.vector/V3) (:x 'Number) (:y 'Number)
          :examples $ []
          :schema $ :: 'StructDef
        'calc-unit-x-axis $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn calc-unit-x-axis (p)
            match p $
              :v3 a b c
              v-scale
                v3 (negate c) 0 a
                / 1 $ sqrt $ sum-squares a c
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'quaternion.vector/V3)
            :args $ [] 'quaternion.vector/V3
          :tests $ [] $ %{} 'TestEntry (:name |perpendicular-screen-axes)
            :code $ quote $ do
              assert= (v3 0 0 1)
                calc-unit-x-axis $ v3 1 0 0
              assert= (v3 0 1 0)
                calc-unit-y-axis $ v3 1 0 0
              assert= 25 $ sum-squares 3 4
        'calc-unit-y-axis $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn calc-unit-y-axis (p)
            match p $
              :v3 a b c
              v-scale
                v3 (* -1 a b) (sum-squares a c) (* -1 b c)
                / 1 $ sqrt $ sum-squares (* a b) (sum-squares a c) (* b c)
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'quaternion.vector/V3)
            :args $ [] 'quaternion.vector/V3
        'comp-axis $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-axis ()
            line-segments $ {}
              :segments $ []
                [] ([] -100 0 0) ([] 100 0 0)
                [] ([] 0 -100 0) ([] 0 100 0)
                [] ([] 0 0 -100) ([] 0 0 100)
              :material style-line
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'quatrefoil.schema/Shape)
            :args $ []
        'comp-container $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-container ()
            let
                look-distance $ v3 20 30 -60
                s 0.5
                targets $ [] $ v3 80 70 -50
                projections $ map targets $ fn (p)
                  hint-fn $ {}
                    :args $ [] 'quaternion.vector/V3
                    :return 'app.comp.container/Projection
                  transform-3d p look-distance s
                scaled 0.006
              scene ({})
                group
                  {}
                    :scale $ v3 scaled scaled scaled
                    :position $ v3 0 0.9 -0.2
                  ambient-light $ {} $ :color 0x666666
                  comp-axis
                  comp-mark-point |C (Option :some 0xffffff) look-distance
                  mesh-line $ {}
                    :points $ map
                      [] (v-scale look-distance 5)
                        v-scale look-distance $ negate s
                      , v3-list
                    :material $ assoc style-bold-line :color 0x44aa44
                  group ({}) & $ map-indexed projections $ fn (idx pro)
                    hint-fn $ {}
                      :args $ [] 'Number 'app.comp.container/Projection
                      :return 'quatrefoil.schema/Shape
                    let
                        q-point $ v-scale look-distance $ :scale pro
                        distance-v $ v- (:p0 pro) q-point
                        next-axis $ v-scale (cross-unit distance-v look-distance) (v-length distance-v)
                      group ({})
                        comp-mark-point |P (Option :some 0xffffff) (:p0 pro)
                        mesh-line $ {}
                          :points $ map
                            [] (:p0 pro) q-point
                            , v3-list
                          :material $ assoc style-bold-line :color 0xccccff
                        comp-mark-point |Q (Option :none) q-point
                        mesh-line $ {}
                          :points $ map
                            [] q-point $ v+ q-point next-axis
                            , v3-list
                          :material $ assoc style-bold-line :color 0xccccff
                        comp-mark-point |R (Option :some 0xaaaaff) (v+ q-point next-axis)
                        mesh-line $ {}
                          :points $ map (range 320)
                            fn (idx)
                              hint-fn $ {}
                                :args $ [] 'Number
                                :return $ :: 'List 'Number
                              v3-list $ v+ q-point
                                v-scale distance-v $ cos $ * idx 0.02
                                v-scale next-axis $ sin $ * idx 0.02
                          :material $ assoc style-bold-line :color 0xff5533
                  comp-mark-point |O (Option :none) (v3 0 0 0)
                  point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                    :position $ v3 20 40 50
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'quatrefoil.schema/Component)
            :args $ []
        'comp-demo $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-demo ()
            group ({})
              box $ {} (:width 16) (:height 4) (:depth 6)
                :position $ [] -40 0 0
                :material $ {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.6)
                :event $ {} $ :click
                  fn (e d!) (d! :demo nil)
              sphere $ {} (:radius 8)
                :position $ [] 10 0 0
                :material $ {} (:kind :mesh-lambert) (:opacity 0.6) (:color 0x9050c0)
                :event $ {} $ :click
                  fn (e d!) (d! :canvas nil)
              group ({})
                text $ {} (:text |Quatrefoil) (:size 4) (:height 2)
                  :position $ [] -30 0 20
                  :material $ {} (:kind :mesh-lambert) (:color 0xffcccc)
              sphere $ {} (:radius 4) (:emissive 0xffffff) (:metalness 0.8) (:color 0x00ff00) (:emissiveIntensity 1) (:roughness 0)
                :position $ [] -10 20 0
                :material $ {} (:kind :mesh-basic) (:color 0xffff55) (:opacity 0.8) (:transparent true)
                :event $ {} $ :click
                  fn (e d!) (d! :canvas nil)
              point-light $ {} (:color 0xffff55) (:intensity 2) (:distance 200)
                :position $ [] -10 20 0
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'quatrefoil.schema/Component)
            :args $ []
        'comp-grid $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-grid (look-distance screen-x screen-y)
            let
                gap 20
              group ({})
                line-segments $ {} (:position look-distance)
                  :segments $ concat
                    map (range -5 6)
                      fn (i)
                        hint-fn $ {}
                          :args $ [] 'Number
                          :return $ :: 'List $ :: 'List 'Number
                        map
                          []
                            v+
                              v-scale screen-x $ * 5 gap
                              v-scale screen-y $ * 20 i
                            v+
                              v-scale screen-x $ * -5 gap
                              v-scale screen-y $ * 20 i
                          , v3-list
                    map (range -5 6)
                      fn (i)
                        hint-fn $ {}
                          :args $ [] 'Number
                          :return $ :: 'List $ :: 'List 'Number
                        map
                          []
                            v+
                              v-scale screen-y $ * 5 gap
                              v-scale screen-x $ * 20 i
                            v+
                              v-scale screen-y $ * -5 gap
                              v-scale screen-x $ * 20 i
                          , v3-list
                  :material $ {} (:kind :line-basic) (:color 0x6677aa) (:opacity 0.4) (:transparent true)
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'quatrefoil.schema/Shape)
            :args $ [] 'quaternion.vector/V3 'quaternion.vector/V3 'quaternion.vector/V3
        'comp-mark-point $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-mark-point (label color position)
            let
                material $ match color
                  (:some value) (assoc style-point :color value)
                  (:none) (assoc style-point :color nil)
              group
                {} $ :position position
                sphere $ {} (:radius 1) (:material material)
                text $ {} (:material material) (:size 6.0) (:depth 0.5) (:text label)
                  :position $ v3 2 0 1
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'quatrefoil.schema/Shape)
            :args $ [] 'String (:: 'calcit.core/Option 'Number) 'quaternion.vector/V3
        'point-label $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn point-label (t idx)
            if (> idx 0) (str t "| " idx) t
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'String)
            :args $ [] 'String 'Number
        'square $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn square (x) (pow x 2)
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Number)
            :args $ [] 'Number
        'style-bold-line $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def style-bold-line
            {} (:kind :mesh-line) (:color 0xaaaaff) (:transparent true) (:opacity 0.9) (:depthTest true) (:lineWidth 0.02)
          :examples $ []
          :schema $ :: 'Map 'Tag 'Dynamic
        'style-line $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def style-line
            {} (:kind :line-basic) (:color 0x5555aa) (:opacity 0.9) (:transparent true)
          :examples $ []
          :schema $ :: 'Map 'Tag 'Dynamic
        'style-point $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def style-point
            {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.9)
          :examples $ []
          :schema $ :: 'Map 'Tag 'Dynamic
        'sum-squares $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn sum-squares (& xs)
            -> xs (map square) (reduce 0 &+)
          :examples $ []
          :schema $ :: 'Fn $ {} (:rest 'Number) (:return 'Number)
            :args $ []
        'transform-3d $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn transform-3d (point look-distance s)
            match point $
              :v3 x y z
              match look-distance $
                :v3 a b c
                let
                    r $ /
                      + (* a x) (* b y) (* c z)
                      + (square a) (square b) (square c)
                    q $ / (+ s 1) (+ r s)
                    L1 $ sqrt $ + (* a a b b)
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
                  Projection :p0 point :scale r :shadow (v3 x' y' z') :x x' :y y'
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'app.comp.container/Projection)
            :args $ [] 'quaternion.vector/V3 'quaternion.vector/V3 'Number
          :tests $ [] $ %{} 'TestEntry (:name |projection-contract)
            :code $ quote $ let
                projection $ transform-3d (v3 4 0 -2) (v3 0 0 -2) 0.5
              assert= (v3 4 0 -2) (:p0 projection)
              assert= 1 $ :scale projection
              assert= (v3 4 0 -1) (:shadow projection)
              assert= 4 $ :x projection
              assert= 0 $ :y projection
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require
            quatrefoil.alias :refer $ group box sphere point-light ambient-light perspective-camera scene text line line-segments mesh-line
            quatrefoil.core :refer $ defcomp >>
            app.math :refer $ v-length cross-unit v3-list
            quaternion.vector :refer $ v-scale v+ v- v3
    'app.comp.nav $ %{} 'FileEntry
      :defs $ {}
        'comp-nav $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-nav (menu?)
            div
              {} $ :class-name css-nav
              a $ {} (:inner-text |Menu) (:class-name css/link)
                :on-click $ fn (e d!)
                  d! $ Op :toggle-menu
              if menu? $ div
                {} $ :class-name css-pop-menu
                =< nil 24
                comp-md-block (load-content |explain.md) ({})
                =< nil 120
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'respo.schema/Component)
            :args $ [] 'Bool
        'css-nav $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defstyle css-nav
            {} $ |$0 $ merge ui/global
              {} (:color :white) (:position :absolute) (:top 0) (:left 0)
          :examples $ []
          :schema $ :: 'String
        'css-pop-menu $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defstyle css-pop-menu
            {} $ |$0 $ {} (:max-height |90vh) (:border-radius |6px) (:padding "|8px 8px") (:z-index 900) (:position :fixed) (:left 8) (:top 32) (:overflow :auto)
              :color $ ui/hsl 0 0 30
              :background-color $ ui/hsl 0 0 100 $ Option :some 0.9
          :examples $ []
          :schema $ :: 'String
        'load-content $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defmacro load-content (file)
            read-file $ str |docs/ file
          :examples $ []
          :schema $ :: 'Macro $ {}
            :capabilities $ #{} :fs-read
            :expansion $ :: 'Expr 'String
            :required $ [] $ :: 'Expr 'String
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.nav
          :require
            respo.core :refer $ defcomp div a
            respo.css :refer $ defstyle
            respo.comp.space :refer $ =<
            respo-ui.css :as css
            respo-md.comp.md :refer $ comp-md-block
            app.updater :refer $ Op
            respo-ui.core :as ui
    'app.config $ %{} 'FileEntry
      :defs $ {} $ 'dev?
        %{} 'CodeEntry (:doc |)
          :code $ quote $ def dev?
            = |dev $ .unwrap-or (get-env |mode) |release
          :examples $ []
          :schema $ :: 'Bool
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.config
    'app.main $ %{} 'FileEntry
      :defs $ {}
        '*store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *store false
          :examples $ []
          :schema $ :: 'Ref 'Bool
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op)
            match (try-decode-map-as op 'app.updater/Op)
              (:ok typed-op)
                reset! *store $ updater @*store typed-op
              (:err error)
                raise $ str |Invalid-menu-operation: error
            , &unit
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ [] 'Dynamic
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! ()
            when dev? (load-console-formatter!) (println |Run-in-dev-mode)
            set-perspective-camera! $ {} (:fov 45)
              :aspect $ / (browser/viewport-width) (browser/viewport-height)
              :near 0.1
              :far 1000
              :position $ v3 0 1 2
            inject-tree-methods
            match (browser/query-selector |canvas)
              (:some canvas-el)
                init-renderer! canvas-el $ {} $ :background 0x110022
              (:none) (raise |Missing-canvas-element)
            render-app!
            add-watch! *store :changes on-store-change!
            set! js/window.onkeydown handle-key-event
            render-control!
            handle-control-events
            init-controls!
            println |App-started!
            , &unit
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
        'mount-target $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn mount-target ()
            match (respo-dom/query-selector |.page)
              (:some element) element
              (:none) (raise |Missing-.page-mount-target)
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'respo.dom/DomElement)
            :args $ []
            :features $ #{} :js-ffi
        'on-store-change! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn on-store-change! (store previous) (render-app!)
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ [] 'Bool 'Bool
            :features $ #{} :js-ffi
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! ()
            if (non-nil? build-errors) (hud! |error build-errors)
              do (hud! |ok~ nil) (clear-cache!) (clear-control-loop!) (handle-control-events) (respo/clear-cache!) (remove-watch! *store :changes) (add-watch! *store :changes on-store-change!) (render-app!) (set! js/window.onkeydown handle-key-event) (println |Code-updated.)
            , &unit
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! ()
            render-canvas! (comp-container)
              fn (op op-data)
                hint-fn $ {}
                  :args $ [] 'Dynamic 'Dynamic
                  :return 'Unit
                , &unit
            respo/render! (mount-target) (comp-nav @*store) dispatch!
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.main
          :require
            |@quatrefoil/utils :refer $ inject-tree-methods
            quatrefoil.core :refer $ render-canvas! init-controls! clear-cache! init-renderer! handle-key-event handle-control-events
            app.comp.container :refer $ comp-container
            app.updater :refer $ updater
            touch-control.core :refer $ render-control! clear-control-loop!
            |bottom-tip :default hud!
            |./calcit.build-errors :default build-errors
            app.config :refer $ dev?
            quatrefoil.dsl.object3d-dom :refer $ set-perspective-camera!
            respo.core :as respo
            app.comp.nav :refer $ comp-nav
            js-ffi.browser :as browser
            quaternion.vector :refer $ v3
            respo.ffi.browser :as respo-dom
    'app.math $ %{} 'FileEntry
      :defs $ {}
        'cross-unit $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn cross-unit (p1 p2)
            match p1 $
              :v3 a b c
              match p2 $
                :v3 x y z
                let
                    v $ v3
                      - (* b z) (* c y)
                      - (* c x) (* a z)
                      - (* a y) (* b x)
                    l $ v-length v
                  v-scale v $ / 1 l
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'quaternion.vector/V3)
            :args $ [] 'quaternion.vector/V3 'quaternion.vector/V3
          :tests $ [] $ %{} 'TestEntry (:name |axis-orientation)
            :code $ quote $ do
              assert= (v3 0 0 1)
                cross-unit (v3 1 0 0) (v3 0 1 0)
              assert= (v3 0 0 -1)
                cross-unit (v3 0 1 0) (v3 1 0 0)
        'v-length $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn v-length (v)
            match v $
              :v3 x y z
              sqrt $ + (* x x) (* y y) (* z z)
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Number)
            :args $ [] 'quaternion.vector/V3
          :tests $ [] $ %{} 'TestEntry (:name |vector-length)
            :code $ quote $ do
              assert= 5 $ v-length $ v3 3 4 0
              assert= 0 $ v-length $ v3 0 0 0
        'v3-list $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn v3-list (point)
            match point $
              :v3 x y z
              [] x y z
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] 'quaternion.vector/V3
            :return $ :: 'List 'Number
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.math
          :require $ quaternion.vector :refer $ v-scale v3
    'app.updater $ %{} 'FileEntry
      :defs $ {}
        'Op $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defenum Op (:toggle-menu)
          :examples $ []
          :schema $ :: 'EnumDef
        'updater $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn updater (menu? op)
            match op $
              :toggle-menu
              not menu?
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Bool)
            :args $ [] 'Bool 'app.updater/Op
          :tests $ [] $ %{} 'TestEntry (:name |menu-toggle)
            :code $ quote $ do
              assert= true $ updater false $ Op :toggle-menu
              assert= false $ updater true $ Op :toggle-menu
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.updater
