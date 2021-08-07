using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using SUIFW;

namespace DemoProject
{
    public class NotificationUIForm :BaseUIForm
    {
        private void Awake()
        {
            //窗体性质
            CurrentUIType.UIForms_Type = UIFormType.PopUp;  //弹出窗体    
            CurrentUIType.UIForms_ShowMode = UIFormShowMode.ReverseChange;
            //注册按钮事件
            RigisterButtonObjectEvent("BtnConfirm", () => CloseUIForm());
        }
    }
}

