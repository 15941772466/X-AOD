
//所有的路径常量、路径方法
 
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace ABFW
{
	public class PathTools
	{
        public static string GetABResourcesPath()
        {
            return Application.dataPath + "/"+ "AB_Resources";
        }

        public static string GetABOutPath()    
        {
            return GetPlatformPath() + "/" + GetPlatformName();
        }

        private static string GetPlatformPath()
        {
            string strReturnPlatformPath = string.Empty;
            switch (Application.platform)
            {
                case RuntimePlatform.WindowsPlayer:
                case RuntimePlatform.WindowsEditor:
                    strReturnPlatformPath = Application.streamingAssetsPath;
                    break;
                case RuntimePlatform.IPhonePlayer:
                case RuntimePlatform.Android:
                    strReturnPlatformPath = Application.persistentDataPath;
                    break;      
                default:
                    break;
            }
            return strReturnPlatformPath;
        }

        public static string GetPlatformName()
        {
            string strReturnPlatformName = string.Empty;
            switch (Application.platform)
            {
                case RuntimePlatform.WindowsPlayer:
                case RuntimePlatform.WindowsEditor:
                    strReturnPlatformName = "Windows";
                    break;
                case RuntimePlatform.IPhonePlayer:
                    strReturnPlatformName = "Iphone";
                    break;
                case RuntimePlatform.Android:
                    strReturnPlatformName = "Android";
                    break;
                default:
                    break;
            }
            return strReturnPlatformName;
        }

        public static string GetWWWPath()  // 获取WWW协议下载（AB包）路径
        {
            //返回路径字符串
            string strReturnWWWPath = string.Empty;

            switch (Application.platform)
            {
                //Windows 主平台
                case RuntimePlatform.WindowsPlayer:
                case RuntimePlatform.WindowsEditor:
                    strReturnWWWPath = "file://" + GetABOutPath();
                    break;
                //Android 平台
                case RuntimePlatform.Android:
                    strReturnWWWPath = "jar:file://" + GetABOutPath();
                    break;
                //IPhone平台
                case RuntimePlatform.IPhonePlayer:
                    strReturnWWWPath = GetABOutPath()+"/Raw/";
                    break;
                default:
                    break;
            }

            return strReturnWWWPath;
        }
		
	}
}


