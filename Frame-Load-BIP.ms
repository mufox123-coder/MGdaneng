/* FRAME safe BIP loader for 3ds Max 2021+
   Preserves the selected target Biped Figure.
   Intentionally does NOT load FIG, match file structure, or load source List controllers.
*/
global FRAME_BIP_FILE_OVERRIDE
global FRAME_BIP_LOADER_DEFINE_ONLY
global FRAME_BIP_LAST_RESULT
global frameLoadBipPreserveFigure

fn frameLoadBipPreserveFigure bipPath quiet:false =
(
    if selection.count != 1 then
    (
        if not quiet do messageBox "请只选择目标 Biped 的一个骨骼（任意骨骼或 COM），然后重试。" title:"FRAME BIP 适配加载器"
        return false
    )
    selectedNode = selection[1]
    selectedController = try(selectedNode.controller)catch(undefined)
    targetComNode = try(selectedController.rootNode)catch(undefined)
    if targetComNode == undefined then
    (
        if not quiet do messageBox "当前选择不属于 Autodesk Biped。请选择目标 Biped 的骨骼或 COM。" title:"FRAME BIP 适配加载器"
        return false
    )
    masterController = try(targetComNode.transform.controller)catch(undefined)
    if masterController == undefined then
    (
        if not quiet do messageBox "无法取得目标 Biped 的 COM 控制器。" title:"FRAME BIP 适配加载器"
        return false
    )
    if masterController.figureMode then
    (
        if not quiet do messageBox "请先退出 Figure Mode，再加载 BIP。" title:"FRAME BIP 适配加载器"
        return false
    )
    if bipPath == undefined or not doesFileExist bipPath or toLower(getFilenameType bipPath) != ".bip" then
    (
        if not quiet do messageBox "请选择有效的 .bip 文件。" title:"FRAME BIP 适配加载器"
        return false
    )
    result = false
    try
    (
        -- Preserve target Figure: no #matchFileStruct, no FIG, no #loadSubAnimControllers.
        result = biped.loadBipFile masterController bipPath #noRedraw #retargetHeight #retargetLimbSizes
    )
    catch
    (
        if not quiet do messageBox ("BIP 加载失败：\n" + getCurrentException()) title:"FRAME BIP 适配加载器"
        return false
    )
    if not result and not quiet do messageBox "3ds Max 未能加载该 BIP；请确认目标为兼容的 Autodesk Biped 结构。" title:"FRAME BIP 适配加载器"
    result
)

if FRAME_BIP_LOADER_DEFINE_ONLY != true then
(
    bipPath = if FRAME_BIP_FILE_OVERRIDE != undefined then FRAME_BIP_FILE_OVERRIDE else getOpenFileName caption:"选择要适配到当前 Biped 的动作" types:"Biped Motion (*.bip)|*.bip|"
    if bipPath != undefined then
    (
        FRAME_BIP_LAST_RESULT = frameLoadBipPreserveFigure bipPath quiet:(FRAME_BIP_FILE_OVERRIDE != undefined)
        if FRAME_BIP_LAST_RESULT and FRAME_BIP_FILE_OVERRIDE == undefined do messageBox "BIP 已加载；目标 Figure、身高与肢长保持不变。" title:"FRAME BIP 适配加载器"
    )
)
