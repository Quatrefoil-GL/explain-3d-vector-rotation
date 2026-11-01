Explain 3D vector rotation
----

Demo: http://r.tiye.me/Quatrefoil-GL/expain-3d-vector-rotation/

### 使用者影响

配对使用正式 Calcit CLI/procs 0.32.1，类型标注由官方 CLI 迁移。
Quatrefoil 0.2.0、Quaternion 0.2.19、Touch Control 0.0.35、Pointed Prompt 0.0.24、
JS-FFI 0.2.9 组成一致的正式依赖图。包龄明确为 60 分钟，无单版本豁免。
保留原类型/质量门禁和 hud! 页面提示，不新增验证脚本或测试框架，不提交生成目录。

菜单仍展示原 Markdown，向量公式、V3/Projection、旋转圆、相机和布局不变。
原可选说明改用 Respo list-> 的显式 keyed children：链接键0、说明键1；
关闭时没有额外节点。Respo dispatch-op 绑定已有 app.updater/Op，
在 render! 处用对应类型的回调转发，不把类型槽设成 dynamic。

说明面板配对已发布 Markdown 0.5.0、UI 0.9.0、Respo 0.17.1；UI 已发布图固定
Router 0.9.0-alpha.4，因此仍有这一项传递 alpha，不宣称整个图均为稳定版。
触控 CSS 改从同一 Caps 模块加载，与旧 npm CSS 哈希相同，删除重复 npm 包。
Actions 使用精确正式 tag，接受可移动 tag 风险；原发布条件与路径不变。

### 检查与运行

Node 24、Yarn 4.18.0、Caps 0.1.1：

```sh
caps --strict --ci
yarn install --immutable
caps verify --toolchain
calcit --check-only --all-defs
calcit fix --workflow strict --verify
calcit test --require-match
calcit js
cp assets/* js-out/
yarn vite build
yarn vite --host 127.0.0.1
```

完整 strict、371/371 定义、32/32 公开定义、原5项回归、编译及构建通过；
源码 unsafe/deprecated 均为0。实际 IAB 菜单反复开关、Markdown显示及刷新正常，
控制台无警告/错误；不宣称VR、移动硬件或跨GPU完整验收，开放材质/宿主边界保留。

PR 原流程只上传构建artifact，不上传COS/rsync。main才上传dist/assets，使用
COS action内置verify，再执行原rsync；相对预览路径、生产CDN路径及旧revision守卫保留。
PR构建成功不等于生产部署验收。

### License

MIT
