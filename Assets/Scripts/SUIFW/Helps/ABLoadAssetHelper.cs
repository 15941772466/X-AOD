/***
 * 
 *    UI框架： AssetBunde 资源调用帮助脚本
 *    封装ABFW框架中关于资源调用API，帮助类。
 *   
 */
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using ABFW;   //导入AB框架命名空间

namespace SUIFW
{
    public class ABLoadAssetHelper : MonoBehaviour
    {
        //本类实例
        private static ABLoadAssetHelper _Instance;
        //AB包场景名称
        private string _ScenesName = string.Empty;
        //AB包的名称
        private string _AssetBundleName = string.Empty;
        //AB包中资源的名称
        private string _AssetName = string.Empty;
        //是否包资源加载完毕
        private bool _IsLoadFinish = false;
        //克隆出来的UI预设
        private UnityEngine.Object _CloneUIPrefab = null;
        //不克隆的防御塔预设
        private UnityEngine.Object _DTPrefab = null;
        /*  属性 */
        public bool IsLoadFinish
        {
            get { return _IsLoadFinish; }
        }

        //得到本类的实例
        public static ABLoadAssetHelper GetInstance()
        {
            if (_Instance==null)
            {
                _Instance = new GameObject("_ABLoadAssetHelper").AddComponent<ABLoadAssetHelper>();
                DontDestroyOnLoad(_Instance);
            }
            return _Instance;
        }

        public void LoadAssetBundlePack(ABPara abPara)      // 调用AB框架ab包
        {
            //仅仅是加载相同AB包中的不同资源
            if ((abPara.ScenesName==_ScenesName)  && (abPara.AssetBundleName==_AssetBundleName))
            {
                _AssetName = abPara.AssetName;
                LoadABAssetComplete(""); 
            }
            else {
                _ScenesName = abPara.ScenesName;
                _AssetBundleName = abPara.AssetBundleName;
                _AssetName = abPara.AssetName;
                StartCoroutine(AssetBundleMgr.GetInstance().LoadAssetBundlePack(_ScenesName, _AssetBundleName, LoadABAssetComplete));  // 下载AssetBundel 指定包
            }
        }

        private void LoadABAssetComplete(string abName)      // （回调函数） 调用AB包中的资源
        {
            UnityEngine.Object tmpObj = null;

            tmpObj=AssetBundleMgr.GetInstance().LoadAsset(_ScenesName, _AssetBundleName, _AssetName);  //加入缓存
            if (tmpObj!=null)
            {
                _CloneUIPrefab = Instantiate(tmpObj);
                _DTPrefab = tmpObj;
            }
            _IsLoadFinish = true;
        }
        
        public UnityEngine.Object GetPrefab()   // 得到abName 对应的预制体（没有实例化）
        {
            if (_DTPrefab != null)
            {
                _IsLoadFinish = false;
                return _DTPrefab;
            }
            return null;
        }
       
        public UnityEngine.Object GetCloneUIPrefab()     // 得到（克隆）的UI预设
        {
            if (_CloneUIPrefab!=null)
            {
                _IsLoadFinish = false;
                return _CloneUIPrefab;
            }

            return null;
        }

    }//Class_end
}//namespace_end