/***
 * 
 *    Title: "SUIFW" UI框架项目
 *           主题： 游戏中上端信息显示窗体
 *    Description: 
 *           功能： 
 *    
 *   
 */
using System.Collections;
using System.Collections.Generic;
using SUIFW;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace DemoProject
{
    public class GameInfoUIForm : BaseUIForm
    {

        void Awake()
        {
            //窗体性质
            CurrentUIType.UIForms_Type = UIFormType.Fixed;  //固定在主窗体上面显示
            CurrentUIType.UIForms_ShowMode = UIFormShowMode.HideOther;   //隐藏其他窗体

            RigisterButtonObjectEvent("BackGameHall",
                () =>
                {
                    OpenUIForm(ProConst.MAIN_CITY_UIFORM);
                    OpenUIForm(ProConst.HERO_INFO_UIFORM);
                    SceneManager.LoadScene("UI");    //sences.u3d  的ab已经加载完成 ，场景可直接转换

                }
                );
        }

    }
}