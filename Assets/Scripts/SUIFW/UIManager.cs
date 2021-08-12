//UI管理器  
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace SUIFW
{
	public class UIManager : MonoBehaviour {
        /* 字段 */
	    private static UIManager _Instance = null;
        //UI窗体预设路径(参数1：窗体预设名称，2：表示窗体预设路径)
	    private Dictionary<string, string> _DicFormsPaths; 
        //缓存所有UI窗体
	    private Dictionary<string, BaseUIForm> _DicALLUIForms;
        //当前显示的UI窗体
	    private Dictionary<string, BaseUIForm> _DicCurrentShowUIForms;
        //定义“栈”集合,存储显示当前所有[反向切换]的窗体类型
	    private Stack<BaseUIForm> _StaCurrentUIForms;
  

        //UI根节点
	    public Transform _TraCanvasTransfrom = null;
        //全屏幕显示的节点
	    private Transform _TraNormal = null;
        //固定显示的节点
	    private Transform _TraFixed = null;
        //弹出节点
	    private Transform _TraPopUp = null;
        //UI管理脚本的节点
	    private Transform _TraUIScripts = null;

        /* 引入了AB加载机制，增加的字段 */
        //UI窗体名称
        private string _UIFormName = string.Empty;
        //UI窗体父类
        private BaseUIForm _BaseUIForm = null;
        //UI根窗体初始化完毕
        private bool _IsUIRootNodeInitFinish = false;


        
	    public static UIManager GetInstance()       // 得到实例
        {
	        if (_Instance==null)
	        {
	            _Instance = new GameObject("_UIManager").AddComponent<UIManager>();
	        }
	        return _Instance;
	    }
 
	    public void Awake()
	    {
	        //字段初始化
            _DicALLUIForms=new Dictionary<string, BaseUIForm>();
            _DicCurrentShowUIForms=new Dictionary<string, BaseUIForm>();
            _DicFormsPaths=new Dictionary<string, string>();
            _StaCurrentUIForms = new Stack<BaseUIForm>();
	    }

        private void Start()
        {
            //初始化“UI窗体预设”路径数据
            InitUIFormsPathData();

            //初始化加载（根UI窗体）Canvas预设
            StartCoroutine(InitRootCanvasLoading(InitRootCanvas));
        }

        #region 加载UI Canvas
        private void InitRootCanvas(UnityEngine.GameObject go)  // （回调函数）初始化Canvas预设上的各主要节点
        {
            //得到UI根节点、全屏节点、固定节点、弹出节点
            _TraCanvasTransfrom = GameObject.FindGameObjectWithTag(SysDefine.SYS_TAG_CANVAS).transform;
            _TraNormal = UnityHelper.FindTheChildNode(_TraCanvasTransfrom.gameObject, SysDefine.SYS_NORMAL_NODE);
            _TraFixed = UnityHelper.FindTheChildNode(_TraCanvasTransfrom.gameObject, SysDefine.SYS_FIXED_NODE);
            _TraPopUp = UnityHelper.FindTheChildNode(_TraCanvasTransfrom.gameObject, SysDefine.SYS_POPUP_NODE);
            _TraUIScripts = UnityHelper.FindTheChildNode(_TraCanvasTransfrom.gameObject, SysDefine.SYS_SCRIPTMANAGER_NODE);

            //把本脚本作为“根UI窗体”的子节点。
            this.gameObject.transform.SetParent(_TraUIScripts, false);
            //"根UI窗体"在场景转换的时候，不允许销毁
            DontDestroyOnLoad(_TraCanvasTransfrom);
            //UI根窗体初始化完毕
            _IsUIRootNodeInitFinish = true;
        }
        private IEnumerator InitRootCanvasLoading(DelTaskComplete taskComplete)         // 初始化加载（根UI窗体）Canvas预设
        {
            //UI 根窗体路径（参数）
            string uiRootFormPaths = string.Empty;

            //从UI预设路径集合中，查询UI根窗体的路径
            _DicFormsPaths.TryGetValue(SysDefine.ROOT_UIFORM, out uiRootFormPaths);

            //从路径(ab包参数)配置文件中，来合成需要的ab包参数
            string[] strTempArray = uiRootFormPaths.Split('|');
            ABPara abPara = new ABPara();
            abPara.ScenesName = strTempArray[0];
            abPara.AssetBundleName = strTempArray[1];
            abPara.AssetName = strTempArray[2];

            return LoadABAsset(abPara, taskComplete);
        }

        #endregion

        public void ShowUIForms(string uiFormName, bool IsRedirection = false)          // 显示（打开）UI窗体  lua调用
        {
            StartCoroutine(ShowUIForm(uiFormName,IsRedirection));
        }
        public void CloseUIForms(string uiFormName)                 //关闭窗体 lua调用
        { 
            BaseUIForm baseUiForm;                          //窗体基类

            _DicALLUIForms.TryGetValue(uiFormName,out baseUiForm);
            if(baseUiForm==null ) return;
            //根据窗体不同的显示类型，分别作不同的关闭处理
            switch (baseUiForm.CurrentUIType.UIForms_ShowMode)
	        {
                case UIFormShowMode.Normal:
                    //普通窗体的关闭
                    ExitUIForms(uiFormName);
                    break;
                case UIFormShowMode.ReverseChange:
                    //反向切换窗体的关闭
                    PopUIFroms();
                    break;
                case UIFormShowMode.HideOther:
                    //隐藏其他窗体关闭
                    ExitUIFormsAndDisplayOther(uiFormName);
                    break;

		        default:
                    break;
	        }
        }

        #region 加载并打开
        public IEnumerator ShowUIForm(string uiFormName, bool IsRedirection = false)  //打开UI窗体 
        {
            BaseUIForm baseUIForms = null;                    //UI窗体

            //等待UI根窗体初始化完毕
            while (!_IsUIRootNodeInitFinish)
            {
                yield return null;  //等待
            }

            //根据UI窗体的名称，加载到“所有UI窗体”缓存集合中
            LoadFormsToAllUIFormsCatch(uiFormName);//此时UI预设窗体(根据“位置模式”)已经加载到层级试图的相应位置了

            //等待UI窗体父类对象被赋值
            while (_BaseUIForm == null)
            {
                yield return null; //等待
            }
            baseUIForms = _BaseUIForm;

            //是否清空“栈集合”中得数据(如果直接转向，则直接清空“栈集合”)
            if (IsRedirection || baseUIForms.CurrentUIType.IsClearStack)
            {
                ClearStackArray();
            }

            //直接转向
            if (IsRedirection)
            {
                //“隐藏其他”窗口模式
                EnterUIFormsAndHideOther(uiFormName);
            }
            else
            {
                //根据不同的UI窗体的显示模式，分别作不同的加载处理
                switch (baseUIForms.CurrentUIType.UIForms_ShowMode)
                {
                    case UIFormShowMode.Normal:                 //“普通显示”窗口模式
                        LoadUIToCurrentCache(uiFormName);       //把当前窗体加载到“当前窗体”集合中。
                        break;
                    case UIFormShowMode.ReverseChange:          //需要“反向切换”窗口模式
                        PushUIFormToStack(uiFormName);
                        break;
                    case UIFormShowMode.HideOther:              //“隐藏其他”窗口模式
                        EnterUIFormsAndHideOther(uiFormName);
                        break;
                    default:
                        break;
                }
            }
            //UI窗体父类对象，置空处理，为下一次加载窗体服务
            _BaseUIForm = null;
        }//ShowUIForms()_end
        private void LoadFormsToAllUIFormsCatch(string uiFormsName)         //检查“所有UI窗体”集合中，是否已经加载过，否则才加载。
        {
            BaseUIForm baseUIResult = null;                 //加载的返回UI窗体基类

            _DicALLUIForms.TryGetValue(uiFormsName, out baseUIResult);
            if (baseUIResult == null)
            {
                LoadUIForm(uiFormsName);         //加载指定名称的“UI窗体”
            }
            else
            {
                _BaseUIForm = baseUIResult;
            }
        }

        private void LoadUIForm(string uiFormName)      // 加载指定名称的“UI窗体”
        {
            string strUIFormPaths = null;                   //UI窗体路径

            _UIFormName = uiFormName;
            //根据UI窗体名称，得到对应的加载路径
            _DicFormsPaths.TryGetValue(uiFormName, out strUIFormPaths);
            if (!string.IsNullOrEmpty(strUIFormPaths))
            {
                //从路径配置文件中，来合成需要的ab包参数
                string[] strTempArray = strUIFormPaths.Split('|');
                ABPara abPara = new ABPara();
                abPara.ScenesName = strTempArray[0];
                abPara.AssetBundleName = strTempArray[1];
                abPara.AssetName = strTempArray[2];

                //初始化加载Canvas 预设
                StartCoroutine(LoadABAsset(abPara, LoadUIForm_Process));
            }
        }//Mehtod_end

        private void LoadUIForm_Process(UnityEngine.GameObject goCloneUIPrefab)  //加载指定名称的“UI窗体”
        {

            BaseUIForm baseUIForm = null;   //窗体基类


            //设置“UI克隆体”的父节点（根据克隆体中带的脚本中不同的“位置信息”）
            if (_TraCanvasTransfrom != null && goCloneUIPrefab != null)
            {
                baseUIForm = goCloneUIPrefab.GetComponent<BaseUIForm>();

                //把UI窗体父类对象，赋给字段，传递给上层方法。
                _BaseUIForm = baseUIForm;

                switch (baseUIForm.CurrentUIType.UIForms_Type)
                {
                    case UIFormType.Normal:                 //普通窗体节点
                        goCloneUIPrefab.transform.SetParent(_TraNormal, false);
                        break;
                    case UIFormType.Fixed:                  //固定窗体节点
                        goCloneUIPrefab.transform.SetParent(_TraFixed, false);
                        break;
                    case UIFormType.PopUp:                  //弹出窗体节点
                        goCloneUIPrefab.transform.SetParent(_TraPopUp, false);
                        break;
                    default:
                        break;
                }

                //设置隐藏
                goCloneUIPrefab.SetActive(false);
                //把克隆体，加入到“所有UI窗体”（缓存）集合中。
                _DicALLUIForms.Add(_UIFormName, baseUIForm);

            }
            else
            {
                Debug.Log("_TraCanvasTransfrom==null Or goCloneUIPrefabs==null!! ,Plese Check!, 参数uiFormName=" + _UIFormName);
            }
            //使用完毕，进行置空
            _UIFormName = string.Empty;

        }

        private IEnumerator LoadABAsset(ABPara abPara, DelTaskComplete taskComplete)    // 调用AB 包资源（通过ABLoadAssetHelper.cs 进行再次封装）
        {
            //调用AB框架ab包
            ABLoadAssetHelper.GetInstance().LoadAssetBundleUIPack(abPara);
            //AB包是否调用完成
            while (!ABLoadAssetHelper.GetInstance().IsLoadFinish)
            {
                yield return null;
            }
            //得到（克隆）的UI预设
            UnityEngine.GameObject goCloneUIPrefab = (UnityEngine.GameObject)ABLoadAssetHelper.GetInstance().GetCloneUIPrefab();
            //委托调用
            taskComplete.Invoke(goCloneUIPrefab);
        }

        private void LoadUIToCurrentCache(string uiFormName)        // 把当前窗体加载到“正在显示窗体”集合中
        {
            BaseUIForm baseUiForm;                          //UI窗体
            BaseUIForm baseUIFormFromAllCache;              //从“所有窗体集合”中得到的窗体

            //如果“正在显示”的集合中，存在本UI窗体，则直接返回
            _DicCurrentShowUIForms.TryGetValue(uiFormName, out baseUiForm);
            if (baseUiForm != null)
            {
                baseUiForm.Redisplay();
            }
            else
            {
                //把当前窗体，加载到“正在显示”集合中
                _DicALLUIForms.TryGetValue(uiFormName, out baseUIFormFromAllCache);
                if (baseUIFormFromAllCache != null)
                {
                    _DicCurrentShowUIForms.Add(uiFormName, baseUIFormFromAllCache);
                    baseUIFormFromAllCache.Display();           //显示当前窗体
                }
            }
        }


        private void PushUIFormToStack(string uiFormName)           // UI窗体入栈
        {
            BaseUIForm baseUIForm;                          //UI窗体

            //判断“栈”集合中，是否有其他的窗体，有则“冻结”处理。
            if (_StaCurrentUIForms.Count > 0)
            {
                BaseUIForm topUIForm = _StaCurrentUIForms.Peek();
                //栈顶元素作冻结处理
                topUIForm.Freeze();
            }
            //判断“UI所有窗体”集合是否有指定的UI窗体，有则处理。
            _DicALLUIForms.TryGetValue(uiFormName, out baseUIForm);
            if (baseUIForm != null)
            {
                //当前窗口显示状态
                baseUIForm.Display();
                //把指定的UI窗体，入栈操作。
                _StaCurrentUIForms.Push(baseUIForm);
            }
            else
            {
                Debug.Log("baseUIForm==null,Please Check, 参数 uiFormName=" + uiFormName);
            }
        }

        private void EnterUIFormsAndHideOther(string strUIName)     // (“隐藏其他”属性)打开窗体，且隐藏其他窗体
        {
            BaseUIForm baseUIForm;                          //UI窗体基类
            BaseUIForm baseUIFormFromALL;                   //从集合中得到的UI窗体基类

            //参数检查
            if (string.IsNullOrEmpty(strUIName)) return;

            //把“正在显示集合”与“栈集合”中所有窗体都隐藏。
            foreach (BaseUIForm baseUI in _DicCurrentShowUIForms.Values)
            {
                baseUI.Hiding();
            }
            foreach (BaseUIForm staUI in _StaCurrentUIForms)
            {
                staUI.Hiding();
            }

            _DicCurrentShowUIForms.TryGetValue(strUIName, out baseUIForm);
            if (baseUIForm != null)
            {
                baseUIForm.Redisplay();
            }
            else
            {
                //把当前窗体加入到“正在显示窗体”集合中，且做显示处理。
                _DicALLUIForms.TryGetValue(strUIName, out baseUIFormFromALL);
                if (baseUIFormFromALL != null)
                {
                    _DicCurrentShowUIForms.Add(strUIName, baseUIFormFromALL);
                    //窗体显示
                    baseUIFormFromALL.Display();
                }
            }
        }
        #endregion


        #region 关闭窗体

        private void ExitUIForms(string strUIFormName)   // 正常关闭UI窗体
        {
            BaseUIForm baseUIForm;                          //窗体基类

            //"正在显示集合"中如果没有记录，则直接返回。
            _DicCurrentShowUIForms.TryGetValue(strUIFormName, out baseUIForm);
            if (baseUIForm == null) return;
            //指定窗体，标记为“隐藏状态”，且从"正在显示集合"中移除。
            baseUIForm.Hiding();
            _DicCurrentShowUIForms.Remove(strUIFormName);
        }
        private void PopUIFroms()               //（“反向切换”属性）窗体的出栈逻辑
        {
            if (_StaCurrentUIForms.Count >= 2)
            {
                //出栈处理
                BaseUIForm topUIForms = _StaCurrentUIForms.Pop();
                //做隐藏处理
                topUIForms.Hiding();
                //出栈后，下一个窗体做“重新显示”处理。
                BaseUIForm nextUIForms = _StaCurrentUIForms.Peek();
                nextUIForms.Redisplay();
            }
            else if (_StaCurrentUIForms.Count == 1)
            {
                //出栈处理
                BaseUIForm topUIForms = _StaCurrentUIForms.Pop();
                //做隐藏处理
                topUIForms.Hiding();
            }
        }
        
        private void ExitUIFormsAndDisplayOther(string strUIName)       // (“隐藏其他”属性)关闭窗体，且显示其他窗体
        {
            BaseUIForm baseUIForm;                          //UI窗体基类


            //参数检查
            if (string.IsNullOrEmpty(strUIName)) return;

            _DicCurrentShowUIForms.TryGetValue(strUIName, out baseUIForm);
            if (baseUIForm == null) return;

            //当前窗体隐藏状态，且“正在显示”集合中，移除本窗体
            baseUIForm.Hiding();
            _DicCurrentShowUIForms.Remove(strUIName);

            //把“正在显示集合”与“栈集合”中所有窗体都定义重新显示状态。
            foreach (BaseUIForm baseUI in _DicCurrentShowUIForms.Values)
            {
                baseUI.Redisplay();
            }
            foreach (BaseUIForm staUI in _StaCurrentUIForms)
            {
                staUI.Redisplay();
            }
        }

        private bool ClearStackArray()  // 是否清空“栈集合”中得数据
        {
            if (_StaCurrentUIForms != null && _StaCurrentUIForms.Count >= 1)
            {
                //清空栈集合
                _StaCurrentUIForms.Clear();
                return true;
            }

            return false;
        }
        #endregion


        #region 初始化“UI窗体预设”路径数据
        private void InitUIFormsPathData()
        {
            //json 再SA目录中路径信息
            string strJsonDeployPath = string.Empty;

            strJsonDeployPath = ABFW.PathTools.GetABOutPath() + HotUpdateProcess.HotUpdatePathTool.JSON_DEPLOY_PATH;
            strJsonDeployPath = strJsonDeployPath + "/" + SysDefine.SYS_PATH_UIFORMS_CONFIG_INFO;

            IConfigManager configMgr = new ConfigManagerByJson(strJsonDeployPath);
            if (configMgr != null)
            {
                _DicFormsPaths = configMgr.AppSetting;
            }
        }
        #endregion


    }
}