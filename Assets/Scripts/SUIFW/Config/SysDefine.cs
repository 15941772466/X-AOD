/***
 * 
 *    Title: "SUIFW" UI框架项目
 *           主题： 框架核心参数  
 *    Description: 
 *           功能：
 *           1： 系统常量
 *           2： 全局性方法。
 *           3： 系统枚举类型
 *           4： 委托定义
 *                          
 *   
 */
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace SUIFW
{

    /*  委托定义 （UI框架中，改造升级到与AB框架结合，需要本委托） */
    public delegate void DelTaskComplete(UnityEngine.GameObject obj);
    /*  委托定义 （防御塔使用的委托） */
    public delegate void DTComplete(string preName);

    #region 系统枚举类型

    /// <summary>
    /// UI窗体（位置）类型
    /// </summary>
    public enum UIFormType
    {
        //普通窗体
        Normal,   
        //固定窗体                              
        Fixed,
        //弹出窗体
        PopUp
    }

    /// <summary>
    /// UI窗体的显示类型
    /// </summary>
    public enum UIFormShowMode
    {
        //普通
        Normal,
        //反向切换
        ReverseChange,
        //隐藏其他
        HideOther
    }
    #endregion

    public class SysDefine : MonoBehaviour {
       
        /* 路径常量 */
        public const string SYS_PATH_UIFORMS_CONFIG_INFO = "UIFormsConfigInfo.json";
        public const string SYS_PATH_DT_CONFIG_INFO = "DTConfigInfo.json";
        public const string SYS_PATH_CONFIG_INFO = "SysConfigInfo.json";
        public const string SYS_PATH_LAUGUAGE_JSON_CONFIG = "LauguageJSONConfig.json";
        /* 标签常量 */
        public const string SYS_TAG_CANVAS = "_TagCanvas";
        /* 节点常量 */
        public const string ROOT_UIFORM = "RootUIForm";
        public const string SYS_NORMAL_NODE = "Normal";
        public const string SYS_FIXED_NODE = "Fixed";
        public const string SYS_POPUP_NODE = "PopUp";
        public const string SYS_SCRIPTMANAGER_NODE = "_ScriptMgr";
        

        /* 摄像机层深的常量 */

        /* 全局性的方法 */
        //Todo...

        /* 委托的定义 */
        //Todo....

    }
}