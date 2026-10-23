
(TODO)Expain 3D rotation with 3D vectors
----

> Based on [Quatrefoil](https://github.com/Quatrefoil-GL/quatrefoil).

Demo http://r.tiye.me/Quatrefoil-GL/expain-3d-vector-rotation/

### 迁移说明

使用者影响：菜单继续显示原说明文档，几何公式与旋转圆保持不变；修正初始相机位置，使缩放后的图形不再挤成几个像素。
菜单状态仅存在内存中，现在使用 Bool 和具名 `Op`，不再保留未使用的异构状态树。
从旧开发服务升级时请重启服务并刷新页面，不要沿用旧版本的热重载状态或 Vite 缓存。
公开 Demo 链接和原 rsync 服务器目录保持不变。

当前候选工具链是正式 Calcit / `@calcit/procs` **0.30.1**，CLI 与 procs 必须精确配对。
正式依赖图由 Linux CI 验收，不使用本地旧 CLI 编译正式图；不把单平台通过当作所有后端兼容保证。
使用 Node.js 24、Yarn 4.18.0、Vite 8.3.4。Calcit 模块全部锁定正式 tag，不再引用 main 或 commit hash。
实际模块配对 Touch Control0.0.32、Quatrefoil0.1.10、Markdown0.4.59、UI0.8.0、Respo0.16.124、JS-FFI0.2.5、Quaternion0.2.16和Pointed Prompt0.0.20。
触控 npm 包 0.0.13 只提供现有 CSS；实际控件代码来自正式 Calcit 模块 0.0.32。
已移除不再使用的 alpha Meshline 包，绘图使用 Quatrefoil 正式版本所需的 `meshline`。

`load-content` 仍在编译时读取同一份 Markdown，只补齐字符串表达式和只读文件能力合同。
数学与场景计算使用具名 `V3`，投影结果使用 `Projection`；只有 Quatrefoil 线条点集要求的接口转换为坐标 List。
挂载元素复用正式 `respo.ffi.browser/query-selector`，不在应用里强转 DOM 或伪造框架字段。

安装依赖、准备好 `deps.cirru` 声明的模块后，使用配套 CLI 验证：

```bash
yarn install --immutable
calcit --check-only --all-defs
calcit fix --workflow strict --verify
calcit test --require-match
calcit js
cp assets/* js-out/
yarn vite build
yarn vite preview --host 127.0.0.1
```

5 项定义内回归覆盖向量长度、叉积方向、屏幕轴、投影合同与菜单状态切换；不添加独立验证脚本或质量预算豁免。
应用源码的 unsafe 与 deprecated 调用均要求为 0。材质 Map 的异构值、Respo 的受检 dispatch 输入及原宿主 nil 参数仍是明确边界，不宣称全部 Dynamic/nil 已清零。
构建仍有 Three.js 大 chunk 提示，未通过提高阈值隐藏。

### 前端资源发布

本地默认使用相对资源路径。CI 使用 `VITE_BASE_URL=https://cos-sh.tiye.me/Quatrefoil-GL/explain-3d-vector-rotation/` 构建 CDN 路径。
PR 只做检查和构建，不上传 COS、不执行 rsync，也不提供已上传的预览地址；仅保留相对路径的单次原始构建artifact供本地隔离验收，生产仍使用绝对CDN路径。
main 发布先上传 `dist/assets` 到对应 COS `assets/` 前缀，Action 的 `public-base-url` 启用内置逐文件内容校验；成功后才执行原服务器部署。
不复制额外 curl/校验脚本，不修改后端或服务器目录。旧 main revision 跳过发布，同分支部署不互相中断。

发布需要 `COS_BUCKET`、`COS_SECRET_ID`、`COS_SECRET_KEY` 和原 `rsync_private_key`。
合并前需确认这些 secrets 已授权本仓库；PR 构建成功不等于 COS 上传或生产部署已验收。
只维护 `calcit.cirru` / `deps.cirru`，不提交 `compact.cirru`、`package.cirru`、`js-out/` 或构建产物。

### Workflow

https://github.com/Quamolit/quatrefoil-workflow

### License

MIT
