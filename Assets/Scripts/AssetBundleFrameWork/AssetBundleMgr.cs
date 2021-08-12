/***

 *          框架主流程(第4层): 所有“场景”的AssetBundle 管理。

 *          功能： 
 *             1: 提取“Menifest 清单文件”，缓存本脚本。
 *             2：以“根目录文件夹”为单位，管理整个项目中所有的AssetBundle 包。 
 *
 */
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace ABFW
{
    public delegate void DelLoadComplete(string abName);
    public class AssetBundleMgr:MonoBehaviour
	{
        //本类实例
        private static AssetBundleMgr _Instance;
        //场景集合
        private Dictionary<string, MultiABMgr> _DicAllScenes = new Dictionary<string, MultiABMgr>();
        //资源初始化
        private static bool init = true;
        //第一关AB包
        public AssetBundle level_oneNav = null;


        //得到本类实例
        public static AssetBundleMgr GetInstance()
        {
            if (_Instance==null)
            {
                _Instance = new GameObject("_AssetBundleMgr").AddComponent<AssetBundleMgr>();
                DontDestroyOnLoad(_Instance);
            }
            return _Instance;
        }

        void Awake()
        {
            //加载Manifest清单文件
            StartCoroutine(ABManifestLoader.GetInstance().LoadMainifestFile());
            //这块是在加载场景 ，放在软件最开始//
            string path = ABFW.PathTools.GetABOutPath() + "/sences/";
            if (init)
            {
                Debug.Log("path: " + path);
                AssetBundle.LoadFromFile(path + ("sences.u3d").ToLower());
                level_oneNav = AssetBundle.LoadFromFile(path + ("level_one.ab").ToLower());
                init = false;
            }
        }

        public IEnumerator LoadAssetBundlePack(string scenesName, string abName, DelLoadComplete loadAllCompleteHandle)   // 下载AssetBundel 指定包
        {

            //等待Manifest清单文件加载完成
            while (!ABManifestLoader.GetInstance().IsLoadFinish)
            {
                yield return null;
            }

            //把当前场景加入集合中。
            if (!_DicAllScenes.ContainsKey(scenesName))
            {
                MultiABMgr multiMgrObj = new MultiABMgr(scenesName,abName, loadAllCompleteHandle);
                _DicAllScenes.Add(scenesName, multiMgrObj);
            }

            //调用下一层（“多包管理类”）
            MultiABMgr tmpMultiMgrObj = _DicAllScenes[scenesName];
            
            //调用“多包管理类”的加载指定AB包。
            yield return tmpMultiMgrObj.LoadAssetBundeler(abName);

        }

        public UnityEngine.Object LoadAsset(string scenesName, string abName, string assetName)    // 加载(AB 包中)资源
        {
            if (_DicAllScenes.ContainsKey(scenesName))
            {
                MultiABMgr multObj = _DicAllScenes[scenesName];
                return multObj.LoadAsset(abName, assetName);
            }
            Debug.LogError(GetType()+ "/LoadAsset()/找不到场景名称，无法加载（AB包中）资源,请检查！  scenesName="+ scenesName);
            return null;
        }
        public void DisposeAllAssets(string scenesName)          // 释放资源。
        {
            if (_DicAllScenes.ContainsKey(scenesName))
            {
                MultiABMgr multObj = _DicAllScenes[scenesName];
                multObj.DisposeAllAsset();
            }
            else {
                Debug.LogError(GetType() + "/DisposeAllAssets()/找不到场景名称，无法释放资源，请检查！  scenesName=" + scenesName);
            }
        }

    }//Class_end
}


