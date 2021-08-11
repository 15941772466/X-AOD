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

namespace DemoProject
{
    public class LogonUIForm : BaseUIForm
    {
        public Text TxtLogonName;                           //登陆名称
        public Text TxtLogonNameByBtn;                      //登陆名称(Button)

        public void Awake()
        {
            base.CurrentUIType.UIForms_Type = UIFormType.Normal;
            base.CurrentUIType.UIForms_ShowMode = UIFormShowMode.Normal;
            //base.CurrentUIType.UIForm_LucencyType = UIFormLucenyType.Lucency;

            /* 给按钮注册事件 */
            //RigisterButtonObjectEvent("Btn_OK", LogonSys);
            //Lamda表达式写法
            //RigisterButtonObjectEvent("Btn_OK", 
            //    ()=>OpenUIForm(ProConst.STORY_UIFORM)
            //    );

            //RigisterButtonObjectEvent("Btn_Res",
            //    () => OpenUIForm(ProConst.RES_UIFORM)
            //    );

            //var t1 = UnityHelper.FindTheChildNode(this.transform.gameObject, "Inp_Name");
            //var t2 = UnityHelper.FindTheChildNode(this.transform.gameObject, "Inp_PW");
            //var t3 = UnityHelper.FindTheChildNode(this.transform.gameObject, "Btn_OK");
            
            
            //Button btnok = t3.gameObject.GetComponent<Button>();
            ////Login.LogIn(t1.Find("Text").GetComponent<Text>().text, t2.Find("Text").GetComponent<Text>().text);
            //btnok.onClick.AddListener(() => LoginRes.Login.LogIn(t1.Find("Text").GetComponent<Text>().text, t2.Find("Text").GetComponent<Text>().text));
            

        }

    }
}