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
            var t1 = UnityHelper.FindTheChildNode(this.transform.gameObject, "InputField (1)");//id
            var t2 = UnityHelper.FindTheChildNode(this.transform.gameObject, "InputField");//name
            var t3 = UnityHelper.FindTheChildNode(this.transform.gameObject, "InputField (2)");//pas
            var t4 = UnityHelper.FindTheChildNode(this.transform.gameObject, "Button");
            Button btnreg = t4.gameObject.GetComponent<Button>();
            //Login.LogIn(t1.Find("Text").GetComponent<Text>().text, t2.Find("Text").GetComponent<Text>().text);
            btnreg.onClick.AddListener(() => Savegame.SaveGame(t1.Find("Text").GetComponent<Text>().text, t2.Find("Text").GetComponent<Text>().text, t3.Find("Text").GetComponent<Text>().text, 0, null));


        }

    }
}