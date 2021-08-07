/***
 * 
 *    Title: "SUIFW" UI框架项目
 *           主题： 登陆窗体   
 *    Description: 
 *           功能： 

 *   
 */
using System.Collections;
using System.Collections.Generic;
using SUIFW;
using UnityEngine;
using UnityEngine.UI;
using PFW;

namespace DemoProject
{
    public class DefenseListUIForm : BaseUIForm
    {
      
        public void Awake()
        {
            base.CurrentUIType.UIForms_Type = UIFormType.Normal;
            base.CurrentUIType.UIForms_ShowMode = UIFormShowMode.Normal;


            /* 给按钮注册事件 */

            //RigisterButtonObjectEvent("DefenseA",
            //    () =>
            //    {
            //        UnityEngine.GameObject a = DefenseManager.GetInstance().PrefabAB("DefenseA");
            //        GameObject.Instantiate(a);
            //        //DefenseManager.GetInstance().ABDIC();
            //    }
            //    );

        }

    }
}