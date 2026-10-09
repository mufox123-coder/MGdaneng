# FRAME BIP Loader

用于在 Autodesk 3ds Max 2021 或更高版本中，将 `.bip` 动作安全加载到不同身高和肢长的目标 Biped。

## 下载

在 GitHub 文件页面打开 `Frame-Load-BIP.ms`，点击 **Raw**，然后保存文件。发布到 GitHub 后也可以直接使用仓库的 Raw 下载地址。

## 使用

1. 在 3ds Max 中打开目标角色并退出 Figure Mode。
2. 只选择目标 Biped 的任意一个骨骼或 COM。
3. 打开 **Scripting → Run Script**，运行 `Frame-Load-BIP.ms`。
4. 选择要加载的 `.bip` 文件。
5. 检查脚底接触、握持、穿模和循环衔接。

加载器会保留目标 Figure、身高和肢长。不要向其他角色加载资源配套的 FIG，也不要使用 `#matchFileStruct` 或加载源 List 控制器，否则可能覆盖目标角色比例。

仅支持 Autodesk Biped。普通 Bone、CAT 和 UE 骨架需要单独重定向。

## 校验

发布文件 SHA-256：`9023205dc813234f584a72a328de0122bfc85d97aca7027b002c72981112c68a`

经 3ds Max 2021 验证：124 个 BIP、两套不同身高与肢长的目标 Biped，共 248 次加载全部成功，未发现缩放键变化。

Autodesk 文档：[Biped Load and Save Methods](https://help.autodesk.com/cloudhelp/2025/ENU/MAXScript-Help/files/3ds-Max-Objects-and-Interfaces/MAXScript-Extensions/MAXScript-Extensions-in/Biped-MAXScript-Extensions/Biped-General-Topics/GUID-0BEE71B1-4C68-4419-959F-0BFBA7ED70B6.html)
