//根据标签打AB包
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;   
using System.IO;     

namespace ABFW
{
    public class BuildAssetBundle {

        [MenuItem("AssetBundelTools/BuildAllAssetBundles")]
        public static void BuildAllAB()
        {
            //打包AB输出路径
            string strABOutPathDIR = PathTools.GetABOutPath();

            //判断生成输出目录文件夹
            if (!Directory.Exists(strABOutPathDIR))
            {
                Directory.CreateDirectory(strABOutPathDIR);
            }
            BuildPipeline.BuildAssetBundles(strABOutPathDIR, BuildAssetBundleOptions.None, BuildTarget.StandaloneWindows64);
        }

    }
}
