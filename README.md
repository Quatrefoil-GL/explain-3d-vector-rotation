Explain 3D vector rotation
----

Demo: http://r.tiye.me/Quatrefoil-GL/expain-3d-vector-rotation/

### Calcit 0.42.1 使用说明

升级时请同时使用正式 Calcit 与 `@calcit/procs` 0.42.1，重新安装依赖并生成 JS。
静态三维场景的回调接收并忽略两项输入，菜单仍通过具名 `Op` 开关说明。

### 历史：Calcit 0.37.0

配对正式 **Calcit CLI / @calcit/procs 0.37.0**，消费者需要协调全部模块并重新生成 JS。
正式图为 Quatrefoil **0.3.4**、Quaternion **0.2.23**、Touch Control **0.0.39**、
Pointed Prompt **0.0.27**、Markdown **0.8.2**、UI **0.15.2**、Respo **0.19.5**、
JS-FFI **0.2.13**，传递 Router **0.12.2**；不再依赖旧 Router alpha。

三份材质常量使用 `MaterialValue = Tag | Number | Bool`，取代 Dynamic；
`style-point` 在真实 JS 材质边界声明 `JsNullish<MaterialValue>`，保留未指定颜色时
原有的 `:color nil`，不替换为默认颜色。`v3-list` 返回明确的三项 Number Tuple，
调用方不应再把它当作任意长度的 List 合同。

官方 CLI 逐定义对照确认向量公式、旋转圆、V3/Projection、相机、原 0.006 场景缩放、
HUD 和布局代码保持。菜单仍用既有名义 Op，两个旧竖直间距迁为 `space-y 24/120`；
键 0/1、关闭时不产生说明节点、Markdown 内容及实际事件语义保持。

原 Node 24、Yarn 4.18.0、npm/Three/Vite 锁版本与所有门禁保持，仅 procs 锁版本更新。
材质/宿主/开放 dispatch 的真实边界继续保留，不增加强转、decoder 或验证脚本。
名义 union 的可空 Map 扩大限制已用无依赖最小复现汇报
[Calcit #2559](https://github.com/calcit-lang/calcit/issues/2559)，不通过放宽门禁绕过。

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

此前 0.34.2 迁移的正式 Caps strict/toolchain、Yarn immutable、canonical dry-run、376/376 全定义、
33/33 公开定义、完整 strict（diagnostics=[]）、原五项回归及构建通过。
同一官方 0.34.2 对照中，schema Dynamic **6→3**、unresolved **13→8**；
源码 unsafe/deprecated 为零，未更改原质量门禁或测试断言。

全新临时 Chrome 156 headless profile 中，以真实鼠标完成三轮菜单开关、Markdown 显示
和刷新；实际 Three 场景 17 个 geometry、32997 项坐标均有限，菜单开关前后缓冲区摘要相同。
桌面截图已检查。该范围不代表 VR、实体移动硬件、所有参数、跨 GPU 或其他浏览器均已验收；
浏览器显示 VR NOT SUPPORTED 是本轮环境限制。本次 0.37.0 的 CI 和评审见迁移 PR。

PR 原流程只上传构建artifact，不上传COS/rsync。main才上传dist/assets，使用
COS action内置verify，再执行原rsync；相对预览路径、生产CDN路径及旧revision守卫保留。
PR构建成功不等于生产部署验收。

### License

MIT
