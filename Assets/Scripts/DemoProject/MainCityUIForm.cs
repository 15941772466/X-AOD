/***
 * 
 *    Title: "SUIFW" UI框架项目
 *           主题： 主城窗体
 */
using System.Collections;
using System.Collections.Generic;
using ABFW;
using LuaFramework;
using SUIFW;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace DemoProject
{
    public class MainCityUIForm : BaseUIForm
    {
		public void Awake () 
        {
	        //窗体性质
		    CurrentUIType.UIForms_ShowMode = UIFormShowMode.HideOther;

           

            //事件注册
            //RigisterButtonObjectEvent("BtnMarket",
            //    () => OpenUIForm(ProConst.MARKET_UIFORM)           
            //    );
            //事件注册(弹出公告系统)
            RigisterButtonObjectEvent("BtnEmall",
                () => OpenUIForm(ProConst.NOTIFICATION_UIFORM)
                );
            //开始游戏
            //RigisterButtonObjectEvent("PlayNormal",
            //    () =>
            //    {

            //        LuaHelper.GetInstance().DoString("require 'TestStartGame'");
            //        OpenUIForm(ProConst.GAME_INFO_UIFORM);
            //        OpenUIForm(ProConst.DEFENSE_LIST_UIFORM);

            //        SceneManager.LoadScene("Level_One");
            //        Debug.Log("切换场景完成");


            //    }
            //    );

        }
		
	}
}