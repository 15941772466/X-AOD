                 
//防御塔详细信息窗体  

using System.Collections;
using System.Collections.Generic;
using System.Net.Mime;
using SUIFW;
using UnityEngine;
using UnityEngine.UI;

namespace DemoProject
{
	public class PropDetailUIForm : BaseUIForm
	{
	    public Text TxtName;                                //窗体显示名称

		void Awake () 
        {
		    //窗体的性质
		    CurrentUIType.UIForms_Type = UIFormType.PopUp;
		    CurrentUIType.UIForms_ShowMode = UIFormShowMode.ReverseChange;


            /*  接受信息   */
            ReceiveMessage("Props", 
                p =>
                {
                    if (TxtName)
                    {
                        string[] strArray = p.Values as string[];
                        TxtName.text = strArray[0];
                    }
                }
           );

        }//Awake_end
		
	}
}