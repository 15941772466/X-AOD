using SUIFW;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace PFW
{
    public class DefenseManager : MonoBehaviour
    {
        private static DefenseManager _Instance = null;

        //游戏预制体路径(参数1：防御塔预设名称，2：表示防御塔预设路径)
        public Dictionary<string, string> _DicDefensesPaths;
        //缓存所有游戏预制体
        public Dictionary<string, UnityEngine.Object> _DicALLDTForms;

        ////游戏预制体名称
        //private string _DefenseName = string.Empty;

        //游戏预制体实例
        private UnityEngine.Object goPrefab = null;


        public static DefenseManager GetInstance()
        {
            if (_Instance == null)
            {
                _Instance = new GameObject("_DefenseManager").AddComponent<DefenseManager>();
            }
            return _Instance;
        }
        public void Awake()
        {
            //字段初始化
            _DicALLDTForms = new Dictionary<string, UnityEngine.Object>();
            _DicDefensesPaths = new Dictionary<string, string>();

        }
        void Start()
        {
            //初始化“游戏预制体预设”路径数据
            InitDefensesPathData();
            DontDestroyOnLoad(_Instance);
            //把所有的游戏预制体都加载出来
            StartCoroutine(InitRootCanvasLoading(_DicDefensesPaths, DICgoPrefab));
        }
        public void PreLoad()
        {
        }
        private void DICgoPrefab(string preName)
        {
            _DicALLDTForms.Add(preName, goPrefab);
            
            Debug.Log("preName : " + preName);
        }

        /// <summary>
        /// 初始化加载游戏预制体
        /// </summary>
        private IEnumerator InitRootCanvasLoading(Dictionary<string,string> DTPaths, DTComplete taskComplete)
        {
            foreach (var item in DTPaths)
            {
                //Debug.LogError(item.Value);
                //从路径(ab包参数)配置文件中，来合成需要的ab包参数
                string[] strTempArray = item.Value.Split('|');
                ABPara abPara = new ABPara();
                abPara.ScenesName = strTempArray[0];
                abPara.AssetBundleName = strTempArray[1];
                abPara.AssetName = strTempArray[2];
                //调用AB框架ab包
                ABLoadAssetHelper.GetInstance().LoadAssetBundlePack(abPara);
                //AB包是否调用完成
                while (!ABLoadAssetHelper.GetInstance().IsLoadFinish)
                {
                    yield return null;
                }
                goPrefab = ABLoadAssetHelper.GetInstance().GetPrefab();
                //print(goPrefab.name);
                string pName = goPrefab.name;
                UnityEngine.GameObject goCloneUIPrefab = (UnityEngine.GameObject)ABLoadAssetHelper.GetInstance().GetCloneUIPrefab();
                Destroy(goCloneUIPrefab);
                //委托调用
                taskComplete.Invoke(pName);    
            }
        }

        /// <summary>
        /// 初始化“游戏预制体”路径数据
        /// </summary>
        private void InitDefensesPathData()
        {
            //json 再SA目录中路径信息
            string strJsonDeployPath = string.Empty;

            strJsonDeployPath = ABFW.PathTools.GetABOutPath() + HotUpdateProcess.HotUpdatePathTool.JSON_DEPLOY_PATH;
            strJsonDeployPath = strJsonDeployPath + "/" + SysDefine.SYS_PATH_DT_CONFIG_INFO;

            IConfigManager configMgr = new ConfigManagerByJson(strJsonDeployPath);
            if (configMgr != null)
            {
                _DicDefensesPaths = configMgr.AppSetting; 
            }
            foreach (var item in _DicDefensesPaths)
            {
                Debug.Log(item.Key + "    " + item.Value);
            }
        }
        public UnityEngine.GameObject PrefabAB(string DTname)    //通过名字作为key，返回游戏预制体
        {
            UnityEngine.Object DefenseTower = null;
            _DicALLDTForms.TryGetValue(DTname, out DefenseTower);

            UnityEngine.GameObject DTPre = (UnityEngine.GameObject)DefenseTower;
            return DTPre;
        }

        public void ABDIC()    //查询所有游戏预制体
        {
            foreach (var item in _DicALLDTForms)
            {
                Debug.Log(item.Key+"    "+item.Value);
            }
        }


    }
}

