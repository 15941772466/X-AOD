/***
 * 
 *    Title:  “纯lua框架”，C#与lua文件映射调用
 *                  
 *            主要功能：
 *                    使得"UI预设"同名的lua文件，自动获取常用的unity生命周期函数
 *                    （eg: Awake()、Start()、Update()....）
 *          
 *    Description: 
 *            详细描述：
 *                使用委托技术，与特定的(lua文件)lua函数，进行映射。
 *            
 *   
 */
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using XLua;


namespace LuaFramework
{
    public class BaseLuaTurret : MonoBehaviour
    {


        //定义委托
        [CSharpCallLua]
        public delegate void delLuaStart(GameObject go);
        //声明委托
        BaseLuaTurret.delLuaStart luaStart;

        [CSharpCallLua]
        public delegate void delLuaAwake(GameObject go);
        BaseLuaTurret.delLuaAwake luaAwake;

        [CSharpCallLua]
        public delegate void delLuaUpdate(GameObject go);
        BaseLuaTurret.delLuaUpdate luaUpdate;

        [CSharpCallLua]
        public delegate void delLuaDestroy(GameObject go);
        BaseLuaTurret.delLuaDestroy luaDestroy;

        [CSharpCallLua]
        public delegate void delOnTriggerEnter(Collider go);
        BaseLuaTurret.delOnTriggerEnter LuaOnTriggerEnter;

        [CSharpCallLua]
        public delegate void delOnTriggerExit(Collider go);
        BaseLuaTurret.delOnTriggerExit LuaOnTriggerExit;

        //定义lua表
        private LuaTable luaTable;
        //定义lua环境
        private LuaEnv luaEnv;



        private void Awake()
        {
            //得到lua的环境
            luaEnv = LuaHelper.GetInstance().GetLuaEnv();
            /*  设置luaTable 的元方法 （“__index”）  */
            luaTable = luaEnv.NewTable();
            LuaTable tmpTab = luaEnv.NewTable();//临时表
            tmpTab.Set("__index", luaEnv.Global);
            luaTable.SetMetaTable(tmpTab);
            tmpTab.Dispose();
            /* 得到当前脚本所在对象的预设名称，且去除后缀(["（Clone）"]) */
            string prefabName = this.name;  //当前脚本所挂载的游戏对象的名称
            if (prefabName.Contains("(Clone)"))
            {
                prefabName = prefabName.Split(new string[] { "(Clone)" }, StringSplitOptions.RemoveEmptyEntries)[0];
                //Debug.LogError("prefabName::"+prefabName);
            }
            /* 查找指定路径下lua文件中的方法，映射为委托 */
            luaAwake = luaTable.GetInPath<BaseLuaTurret.delLuaAwake>(prefabName + ".Awake");
            luaStart = luaTable.GetInPath<BaseLuaTurret.delLuaStart>(prefabName + ".Start");
            luaUpdate = luaTable.GetInPath<BaseLuaTurret.delLuaUpdate>(prefabName + ".Update");
            luaDestroy = luaTable.GetInPath<BaseLuaTurret.delLuaDestroy>(prefabName + ".OnDestroy");

            LuaOnTriggerEnter= luaTable.GetInPath<BaseLuaTurret.delOnTriggerEnter>(prefabName + ".OnTriggerEnter");
            LuaOnTriggerExit= luaTable.GetInPath<BaseLuaTurret.delOnTriggerExit>(prefabName + ".OnTriggerExit");
            //调用委托
            if (luaAwake != null)
            {
                luaAwake(gameObject);
            }

        }



        void Start()
        {
            //调用委托
            if (luaStart!=null)
            {
                luaStart(gameObject);
            }
        }

        private void Update()
        {
            if (luaUpdate != null)
            {
                luaUpdate(gameObject);
            }
        }

        private void OnDestroy()
        {
            if (luaDestroy != null)
            {
                luaDestroy(gameObject);
            }
            luaAwake = null;
            luaStart = null;
            luaUpdate = null;
            luaDestroy = null;
        }


        //碰撞检测触发器
        private void OnTriggerEnter(Collider other)
        {
            if (LuaOnTriggerEnter != null)
            {
                LuaOnTriggerEnter(other);
            }
        }

        private void OnTriggerExit(Collider other)
        {
            if (LuaOnTriggerExit != null)
            {
                LuaOnTriggerExit(other);
            }
        }



    }//Class_end
}//namespace_end