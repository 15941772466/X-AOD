/***
 *基于Json 配置文件的“配置管理器”  
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;  //文件读写命名空间

namespace SUIFW
{
	public class ConfigManagerByJson : IConfigManager
	{
	    private static Dictionary<string, string> _AppSetting;

	    public Dictionary<string, string> AppSetting   //只读属性： 得到应用设置（键值对集合）
        {
	        get { return _AppSetting; }     
	    }
     
        // 构造函数
	    public ConfigManagerByJson(string jsonPath)
	    {
	        _AppSetting=new Dictionary<string, string>();
            
            InitAndAnalysisJson(jsonPath);        //初始化解析Json 数据，加载到（_AppSetting）集合。
        }

        
        //根据路径解析Json 数据，加载到字典
	    private void InitAndAnalysisJson(string jsonPath)
        {

            string strReadContent = string.Empty;
            KeyValuesInfo keyvalueInfoObj = null;

            //解析Json 配置文件
            strReadContent = System.IO.File.ReadAllText(jsonPath);
            keyvalueInfoObj = JsonUtility.FromJson<KeyValuesInfo>(strReadContent);
            
            //数据加载到AppSetting 集合中
            foreach (KeyValuesNode nodeInfo in keyvalueInfoObj.ConfigInfo)
            {
                _AppSetting.Add(nodeInfo.Key,nodeInfo.Value);
            }
        }



	}
}