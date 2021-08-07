/***
 *
 *  Title: "热更新流程设计"课程项目
 *        
 *         拷贝所有项目的资源文件（lua/Json配置文件）从编辑器区拷贝到发布区。
 *     
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using UnityEditor;
using System.IO;
using ABFW;


namespace HotUpdateProcess
{
    public class CopyAssetFileToSA 
    {
        /* 拷贝lua文件定义字段  */
        //定义lua编辑目录路径
        private static string _LuaDIRPath = Application.dataPath + HotUpdateProcess.HotUpdatePathTool.LUA_EDITOR_PATH;
        //定义lua 框架编辑目录路径
        private static string _LuaLuaEditorFrameworkPath = Application.dataPath + HotUpdateProcess.HotUpdatePathTool.LUA_EDITOR_FRAMEWORK_PATH;
        //定义lua发布目录路径
        private static string _CopyTargetDIR = PathTools.GetABOutPath() + HotUpdateProcess.HotUpdatePathTool.LUA_DEPLOY_PATH;

        /* 拷贝Json文件定义字段  */
        //Json编辑目录路径
        private static string _JsonEditorDIRPath = Application.dataPath + HotUpdateProcess.HotUpdatePathTool.JSON_EDITOR_PATH;
        //Json配置文件发布目录路径
        private static string _JsonTargetDIR = PathTools.GetABOutPath() + HotUpdateProcess.HotUpdatePathTool.JSON_DEPLOY_PATH;



        /// <summary>
        /// 拷贝lua文件到StreamAsset 目录
        /// </summary>
        [MenuItem("HotUpdateProcess/CopyLuaFileToSA")]
        public static void CopyLuaFileTo()
        {
           

            ////定义目录与文件结构
            //DirectoryInfo dirInfo = new DirectoryInfo(_LuaDIRPath);
            //FileInfo[] files=dirInfo.GetFiles();

            ////如果拷贝的目标路径不存在，则创建
            //if (!Directory.Exists(_CopyTargetDIR))
            //{
            //    Directory.CreateDirectory(_CopyTargetDIR);
            //}

            ////开始循环拷贝文件
            //foreach (FileInfo infoObj in files)
            //{
            //    File.Copy(infoObj.FullName, _CopyTargetDIR+"/"+ infoObj.Name,true);
            //}

            //拷贝lua编辑器目录
            CopyLuaFileToSA();

            //拷贝lua编辑器lua框架目录
            CopyLuaFrameworkFileToSA();
            //Unity编辑器窗体刷新
            Debug.Log("CopyAssetFileToSA.cs/CopyLuaFileTo()/ lua文件已经拷贝的指定区域！");
            AssetDatabase.Refresh();
        }
        //拷贝lua编辑器目录  (luascripts)
        private static void CopyLuaFileToSA()
        {
            //定义目录与文件结构
            DirectoryInfo dirInfo = new DirectoryInfo(_LuaDIRPath);
            FileInfo[] files = dirInfo.GetFiles();

            //如果拷贝的目标路径不存在，则创建
            if (!Directory.Exists(_CopyTargetDIR))
            {
                Directory.CreateDirectory(_CopyTargetDIR);
            }

            //开始循环拷贝文件
            foreach (FileInfo infoObj in files)
            {
                File.Copy(infoObj.FullName, _CopyTargetDIR + "/" + infoObj.Name, true);
            }
        }
        //拷贝lua编辑器lua框架目录  (luaframework)
        private static void CopyLuaFrameworkFileToSA()
        {
            //定义目录与文件结构
            DirectoryInfo dirInfo = new DirectoryInfo(_LuaLuaEditorFrameworkPath);
            FileInfo[] files = dirInfo.GetFiles();

            //如果拷贝的目标路径不存在，则创建
            if (!Directory.Exists(_CopyTargetDIR))
            {
                Directory.CreateDirectory(_CopyTargetDIR);
            }

            //开始循环拷贝文件
            foreach (FileInfo infoObj in files)
            {
                File.Copy(infoObj.FullName, _CopyTargetDIR + "/" + infoObj.Name, true);
            }
        }
        /// <summary>
        /// 拷贝Json文件到StreamAsset 目录
        /// </summary>
        [MenuItem("HotUpdateProcess/CopyJsonsFileToSA")]
        public static void CopyJsonsFileTo()
        {
            //定义目录与文件结构
            DirectoryInfo dirInfo = new DirectoryInfo(_JsonEditorDIRPath);
            FileInfo[] files = dirInfo.GetFiles();

            //如果发布区文件不存在，则创建
            if (!Directory.Exists(_JsonTargetDIR))
            {
                Directory.CreateDirectory(_JsonTargetDIR);
            }

            //开始循环拷贝文件：Json的编辑相关文件
            foreach (FileInfo jsonEditorFilesObj in files)
            {
                //过滤扩展名称
                if ((jsonEditorFilesObj.Extension==".json") || (jsonEditorFilesObj.Extension == ".Json"))
                {
                    File.Copy(jsonEditorFilesObj.FullName, _JsonTargetDIR + "/" + jsonEditorFilesObj.Name, true);
                }
            }

            //Unity编辑器窗体刷新
            Debug.Log("CopyAssetFileToSA.cs/CopyJsonsFileTo()/ Json配置文件已经拷贝的指定区域！");
            AssetDatabase.Refresh();
        }



    }//Class_end
}


