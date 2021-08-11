/***
 * 
 *    Title: "SUIFW" UI框架项目
 *           主题： 通用配置管理器接口   
 *    Description: 
 *           功能： 
 *                基于“键值对”配置文件的通用解析
 *    
 *   
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace SUIFW
{
	public interface IConfigManager  {
	    Dictionary<string, string> AppSetting { get; }   //只读属性
	}

    [Serializable]
    class KeyValuesInfo
    {
        //配置信息
        public List<KeyValuesNode> ConfigInfo = null;
    }

    [Serializable]
    class KeyValuesNode
    {
        //键
        public string Key = null;
        //值
        public string Value = null;
    }
}