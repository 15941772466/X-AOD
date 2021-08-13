/***
 *    UI框架
 *           1： 系统常量
 *           2： 全局性方法。
 *           3： 系统枚举类型
 *           
 *   
 */
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace SUIFW
{
    public struct ABPara       // AB包的参数结构
    {
        //AB包所属根目录名称
        public string RootFileName;
        //AB包名称
        public string AssetBundleName;
        //资源的名称
        public string AssetName;
    }

    /*  委托定义 （UI框架的委托） */
    public delegate void DelTaskComplete(UnityEngine.GameObject obj);
    /*  委托定义 （游戏预制体加载使用的委托） */
    public delegate void DTComplete(string preName);

    public enum UIFormType   // UI窗体（位置）类型
    {
        //普通窗体
        Normal,   
        //固定窗体                              
        Fixed,
        //弹出窗体
        PopUp
    }

    public enum UIFormShowMode  // UI窗体的显示类型
    {
        //普通
        Normal,
        //反向切换
        ReverseChange,
        //隐藏其他
        HideOther
    }
  

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

    }
}