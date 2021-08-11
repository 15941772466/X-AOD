//弹出窗口的遮罩
using System.Collections;
using System.Collections.Generic;
using System.Net.Mime;
using UnityEngine;
using UnityEngine.UI;

namespace SUIFW
{
	public class UIMaskMgr : MonoBehaviour {
        
        //本脚本私有单例
	    private static UIMaskMgr _Instance = null;  
        //UI根节点对象
	    private GameObject _GoCanvasRoot = null;
        //UI脚本节点对象
	    private Transform _TraUIScriptsNode = null;
        
        //遮罩面板
	    private GameObject _GoMaskPanel;
        //UI摄像机
	    private Camera _UICamera;
        //UI摄像机原始的“层深”
	    private float _OriginalUICameralDepth;

        
	    public static UIMaskMgr GetInstance()   //得到实例
        {
	        if (_Instance==null)
	        {
	            _Instance = new GameObject("_UIMaskMgr").AddComponent<UIMaskMgr>();
	        }
	        return _Instance;
	    }

	    void Awake()
	    {   
	        _GoCanvasRoot = GameObject.FindGameObjectWithTag(SysDefine.SYS_TAG_CANVAS);  //得到UI根节点对象
            _TraUIScriptsNode = UnityHelper.FindTheChildNode(_GoCanvasRoot, SysDefine.SYS_SCRIPTMANAGER_NODE);//脚本节点对象
            UnityHelper.AddChildNodeToParentNode(_TraUIScriptsNode,this.gameObject.transform);  //把本脚本实例，作为“脚本节点对象”的子节点。
            _GoMaskPanel = UnityHelper.FindTheChildNode(_GoCanvasRoot, "_UIMaskPanel").gameObject;

            //得到UI摄像机原始的“层深”
	        _UICamera = GameObject.FindGameObjectWithTag("_TagUICamera").GetComponent<Camera>();
	        _OriginalUICameralDepth = _UICamera.depth;
	    }

       
	    public void SetMaskWindow(GameObject goDisplayUIForms)          // 设置遮罩状态
        {
            _GoMaskPanel.SetActive(true);         //打开遮罩面板  
            _GoMaskPanel.transform.SetAsLastSibling();  //遮罩窗体下移            
            goDisplayUIForms.transform.SetAsLastSibling();  //显示窗体的下移            
            _UICamera.depth = _UICamera.depth + 100;    //增加层深
	    }

	    public void CancelMaskWindow()                  // 取消遮罩状态
        {
	        if (_GoMaskPanel.activeInHierarchy)
	        {
	            _GoMaskPanel.SetActive(false);          
            }
            if (_UICamera != null)
            {
                _UICamera.depth = _OriginalUICameralDepth;  //恢复层深
            }
        }
	}
}