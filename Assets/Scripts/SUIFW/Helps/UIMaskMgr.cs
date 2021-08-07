/***
 * 
 *    Title: "SUIFW" UI框架项目
 *           主题： UI遮罩管理器  
 *    Description: 
 *           功能： 负责“弹出窗体”模态显示实现
 *                  
 *    Date: 2017
 *    Version: 0.1版本
 *    Modify Recoder: 
 *    
 *   
 */
using System.Collections;
using System.Collections.Generic;
using System.Net.Mime;
using UnityEngine;
using UnityEngine.UI;

namespace SUIFW
{
	public class UIMaskMgr : MonoBehaviour {
        /*  字段 */
        //本脚本私有单例
	    private static UIMaskMgr _Instance = null;  
        //UI根节点对象
	    private GameObject _GoCanvasRoot = null;
        //UI脚本节点对象
	    private Transform _TraUIScriptsNode = null;
        //顶层面板
	    private GameObject _GoTopPanel;
        //遮罩面板
	    private GameObject _GoMaskPanel;
        //UI摄像机
	    private Camera _UICamera;
        //UI摄像机原始的“层深”
	    private float _OriginalUICameralDepth;

        //得到实例
	    public static UIMaskMgr GetInstance()
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

            //把本脚本实例，作为“脚本节点对象”的子节点。
            UnityHelper.AddChildNodeToParentNode(_TraUIScriptsNode,this.gameObject.transform);

            //得到“顶层面板”、“遮罩面板”
	        //_GoTopPanel = _GoCanvasRoot;
	        _GoMaskPanel = UnityHelper.FindTheChildNode(_GoCanvasRoot, "_UIMaskPanel").gameObject;

            //得到UI摄像机原始的“层深”
	        _UICamera = GameObject.FindGameObjectWithTag("_TagUICamera").GetComponent<Camera>();
	        if (_UICamera != null)
	        {
	            //得到UI摄像机原始“层深”
	            _OriginalUICameralDepth = _UICamera.depth;
	        }
	        else
	        {
	            Debug.Log(GetType()+"/Start()/UI_Camera is Null!,Please Check! ");
            }
	    }

        /// <summary>
        /// 设置遮罩状态
        /// </summary>
        /// <param name="goDisplayUIForms">需要显示的UI窗体</param>
       
	    public void SetMaskWindow(GameObject goDisplayUIForms)
        {
	        ////顶层窗体下移
            //_GoTopPanel.transform.SetAsLastSibling();
            _GoMaskPanel.SetActive(true);

            //遮罩窗体下移
            _GoMaskPanel.transform.SetAsLastSibling();
            //显示窗体的下移
            goDisplayUIForms.transform.SetAsLastSibling();
            //增加当前UI摄像机的层深（保证当前摄像机为最前显示）
            if (_UICamera!=null)
            {
                _UICamera.depth = _UICamera.depth + 100;    //增加层深
            }

	    }

        /// <summary>
        /// 取消遮罩状态
        /// </summary>
	    public void CancelMaskWindow()
	    {
            //顶层窗体上移
            //_GoTopPanel.transform.SetAsFirstSibling();
            //禁用遮罩窗体
	        if (_GoMaskPanel.activeInHierarchy)
	        {
                //隐藏
	            _GoMaskPanel.SetActive(false);
            }

	        //恢复当前UI摄像机的层深 
            if (_UICamera != null)
            {
                _UICamera.depth = _OriginalUICameralDepth;  //恢复层深
            }
        }
	}
}