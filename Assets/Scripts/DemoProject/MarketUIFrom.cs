
// 防御塔列表窗体  

using System.Collections;
using System.Collections.Generic;
using SUIFW;
using UnityEngine;

namespace DemoProject
{
    public class MarketUIFrom : BaseUIForm
    {
		void Awake ()
        {
		    //窗体性质
		    CurrentUIType.UIForms_Type = UIFormType.PopUp;  //弹出窗体
		    CurrentUIType.UIForms_ShowMode = UIFormShowMode.ReverseChange;


            ////注册道具事件：神杖 
            //RigisterButtonObjectEvent("BtnTicket",
            //    () =>
            //    {
            //        //打开子窗体
            //        OpenUIForm(ProConst.PRO_DETAIL_UIFORM);
            //        //传递数据
            //        string[] strArray = new string[] { "A防御塔详情", "A防御塔详细介绍。。。" };
            //        SendMessage("Props", "ticket", strArray);
            //    }
            //    );

            ////注册道具事件：战靴 
            //RigisterButtonObjectEvent("BtnShoe",
            //    () =>
            //    {
            //        //打开子窗体
            //        OpenUIForm(ProConst.PRO_DETAIL_UIFORM);
            //        //传递数据
            //        string[] strArray = new string[] { "B防御塔详情", "B防御塔详细介绍。。。" };
            //        SendMessage("Props", "shoes", strArray);
            //    }
            //    );

            ////注册道具事件：盔甲 
            //RigisterButtonObjectEvent("BtnCloth",
            //    () =>
            //    {
            //        //打开子窗体
            //        OpenUIForm(ProConst.PRO_DETAIL_UIFORM);
            //        //传递数据
            //        string[] strArray = new string[] { "C防御塔详情", "C防御塔详细介绍。。。" };
            //        SendMessage("Props", "cloth", strArray);
            //    }
            //    );
        }
		
	}
}