using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
using TFW;

namespace UIFW
{    
    public class LoadManager : MonoBehaviour
    {
        //本脚本私有单例
        private static LoadManager _Instance = null;

        //UI根节点对象
        private GameObject _GoCanvasRoot = null;

        //加载面板
        private GameObject _GoLoadUIForm;

        private GameObject objProcessBar;
        private GameObject percent;

        public static LoadManager GetInstance()   //得到实例
        {
            if (_Instance == null)
            {
                _Instance = new GameObject("_LoadManager").AddComponent<LoadManager>();
                DontDestroyOnLoad(_Instance);
            }
            return _Instance;
        }
        void Awake()
        {
            _GoCanvasRoot = GameObject.FindGameObjectWithTag(SysDefine.SYS_TAG_CANVAS);  //得到UI根节点对象  
            _GoLoadUIForm = UnityHelper.FindTheChildNode(_GoCanvasRoot, "LoadUIForm").gameObject;
            objProcessBar= UnityHelper.FindTheChildNode(_GoLoadUIForm, "Slider").gameObject;
            percent = UnityHelper.FindTheChildNode(_GoLoadUIForm, "percent").gameObject;
        }
        public void Load(string str)
        {
            Debug.Log("执行到LoadManager");
           // _GoLoadUIForm.SetActive(true);
            StartCoroutine(StartLoading(str));
        }
        IEnumerator StartLoading(string str)
        {
            float i = 0;
            AsyncOperation acOp = SceneManager.LoadSceneAsync(str);
            //acOp.allowSceneActivation = false;
            //while (i <= 100)
            //{
            //    i++;
            //    objProcessBar.GetComponent<Slider>().value = i / 100;
            //    yield return new WaitForEndOfFrame();
            //    percent.GetComponent<Text>().text = i.ToString() + "%";
            //}
            yield return null;
            //acOp.allowSceneActivation = true;
            //_GoLoadUIForm.SetActive(false);
            //percent.GetComponent<Text>().text = "0%";
        }
    }
}
