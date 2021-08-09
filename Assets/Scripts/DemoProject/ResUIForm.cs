/***
 * 
 *    Title: "SUIFW" UI框架项目
 *           主题： 注册窗体   
 *                  
 */
using System.Collections;
using System.Collections.Generic;
using SUIFW;
using UnityEngine;
using UnityEngine.UI;

namespace DemoProject
{
    public class ResUIForm : BaseUIForm
    {
        

        public void Awake()
        {
            base.CurrentUIType.UIForms_Type = UIFormType.PopUp;
            base.CurrentUIType.UIForms_ShowMode = UIFormShowMode.ReverseChange;
            

        }

    }
}