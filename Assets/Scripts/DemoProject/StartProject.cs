/***
 * 
 *    Title: "SUIFW" UI框架项目
 *           主题： xxx    
 *    Description: 
 *           功能： yyy
 *                  
 *    Date: 2017
 *    Version: 0.1版本
 *    Modify Recoder: 
 *    
 *   
 */
using System.Collections;
using System.Collections.Generic;
using SUIFW;
using UnityEngine;
using PFW;

namespace DemoProject
{
	public class StartProject : MonoBehaviour,HotUpdateProcess.IStartGame{
        public void ReceiveInfoStartRuning()
        {
            UIManager.GetInstance().ShowUIForms(ProConst.LOGON_FROMS);
           // DefenseManager.GetInstance().PreLoad();
        }
	}
}